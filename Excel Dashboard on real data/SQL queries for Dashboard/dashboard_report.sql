alter procedure dashboard_report

@GroupId INT,  -- Replace with your actual GroupId
@StartDate DATE,
@EndDate DATE

as begin 
DECLARE @DynamicPivotQuery AS NVARCHAR(MAX);
DECLARE @ColumnNames AS NVARCHAR(MAX);
DECLARE @IsNullColumns AS NVARCHAR(MAX);
DECLARE @SumColumns AS NVARCHAR(MAX);

-- Step 1: Dynamically get all unique Pub_Abreviation values from Publications table based on Group_Id using FOR XML PATH
SELECT @ColumnNames = STUFF((SELECT DISTINCT ',' + QUOTENAME(Pub.Pub_Abreviation)
                             FROM PublicationGroupDetails pgd
                             INNER JOIN Publications Pub ON pgd.Publication = Pub.Id
                             WHERE pgd.Group_Id = @GroupId  -- Filter based on Group_Id
                             FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

-- Step 2: Prepare dynamic column names with ISNULL for the SELECT statement
SELECT @IsNullColumns = STUFF((SELECT DISTINCT ', ISNULL(' + QUOTENAME(Pub.Pub_Abreviation) + ', 0) AS ' + QUOTENAME(Pub.Pub_Abreviation)
                               FROM PublicationGroupDetails pgd
                               INNER JOIN Publications Pub ON pgd.Publication = Pub.Id
                               WHERE pgd.Group_Id = @GroupId  -- Filter based on Group_Id
                               FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '');

-- Step 3: Prepare dynamic column names for SUM in the SELECT statement
SELECT @SumColumns = STUFF((SELECT DISTINCT ' + ISNULL(' + QUOTENAME(Pub.Pub_Abreviation) + ', 0) '
                             FROM PublicationGroupDetails pgd
                             INNER JOIN Publications Pub ON pgd.Publication = Pub.Id
                             WHERE pgd.Group_Id = @GroupId  -- Filter based on Group_Id
                             FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 3, '');

-- Step 4: Construct the dynamic PIVOT SQL query using the view
SET @DynamicPivotQuery = N'
SELECT 
    ClientCompanyId AS Id, 
	Publication_Month_Year,
    --Client_Name AS Client,
    --GroupComp_Name AS City,
	Main_Category as MainCategory_Id,
	MainCategory,
	Sub_Category as SubCategory_Id,
	SubCategory,
    ' + @IsNullColumns + ',
    SUM(' + @SumColumns + ') AS GrandTotal
FROM 
(
    SELECT 
        v.ClientCompanyId,
		v.Publication_Month_Year,
        --v.Client_Name,
        --v.GroupComp_Name,
		v.Main_Category,
		v.MainCategory,
		v.Sub_Category,
		v.SubCategory,
        v.Pub_Abreviation,
        SUM(v.Total) AS Total
    FROM 
        v_dashboard v
    WHERE 
        v.Publication_Date BETWEEN @StartDate AND @EndDate 
       
    GROUP BY	
        v.ClientCompanyId,v.Publication_Month_Year,
        --v.Client_Name,
        --v.GroupComp_Name,
		v.Main_Category,
		v.MainCategory,
		v.Sub_Category,
		v.SubCategory,
        v.Pub_Abreviation,
        v.Type_Id,
        v.Brand_Id
) AS SourceTable
PIVOT 
(
    SUM(Total)
    FOR Pub_Abreviation IN (' + @ColumnNames + ')
) AS PivotTable
GROUP BY ClientCompanyId, Publication_Month_Year,
--Client_Name, GroupComp_Name,
Main_Category,
MainCategory,
Sub_Category,
SubCategory,
 ' + @ColumnNames + ' 
 HAVING SUM(' + @SumColumns + ') > 0
ORDER BY GrandTotal DESC;';

-- Step 5: Execute the dynamically generated SQL query
EXEC sp_executesql @DynamicPivotQuery, N'@StartDate DATE, @EndDate DATE',
 @StartDate, @EndDate;
 END 
 GO