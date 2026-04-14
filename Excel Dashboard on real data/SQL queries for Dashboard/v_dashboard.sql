alter view  v_dashboard as 
SELECT 
    t.Id AS TransactionId,
    cc.Id AS ClientCompanyId,
    cc.Client_Name,
    gc.GroupComp_Name,
    p.Pub_Abreviation,
    t.RO,
    t.Type_Id, ISNULL(Types.Type, '') AS Type,
    t.Brand AS Brand_Id,ISNULL(Brands.Brand_Name, '') AS Brand_Name,
    t.Publication,
    t.Main_Category,
	mcat.Category_Title as MainCategory,
    t.Sub_Category,
	scat.Category_Title as SubCategory,
    t.City_Edition,
    t.Size_CM,
    t.Col_Size,
    t.Publication_Date,  
	FORMAT(t.Publication_Date, 'MM-yyyy') AS Publication_Month_Year,
	
    CASE 
		--FOR Publication = 1
        WHEN t.Publication = 1 THEN
            CASE 
                WHEN t.City_Edition IN ('ISB', 'PEW') 
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'ISB')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'PEW')
                     AND t.City_Edition = 'ISB' THEN t.Size_CM * t.Col_Size
               -- WHEN t.City_Edition IN ('ISB', 'PEW') THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition IN ('KHI', 'SUK', 'HYD') 
					 AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'KHI')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'SUK')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'HYD')
					 AND t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                
                WHEN t.City_Edition IN ('LHE', 'FSB', 'GUJ', 'SGD') 
					 AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'LHE')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'FSB')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'GUJ')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'SGD')
					 AND t.City_Edition = 'LHE' THEN t.Size_CM * t.Col_Size
                
                WHEN t.City_Edition IN ('MUX', 'RYK') 
					 AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'MUX')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'RYK')
                     AND t.City_Edition = 'MUX' THEN t.Size_CM * t.Col_Size
                
                WHEN t.City_Edition = 'QTA' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
       -- END OF t.Publication = 1
        
       -- FOR t.Publication = 2
        WHEN t.Publication = 2 THEN
            CASE 
                WHEN t.City_Edition IN ('ISB', 'PEW') 
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'ISB')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'PEW')
                     AND t.City_Edition = 'ISB' THEN t.Size_CM * t.Col_Size
                
                WHEN t.City_Edition IN ('LHE', 'FSB', 'GUJ', 'SGD') 
					 AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'LHE')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'FSB')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'GUJ')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'SGD')
					 AND t.City_Edition = 'LHE' THEN t.Size_CM * t.Col_Size
                
                WHEN t.City_Edition IN ('MUX', 'RYK') 
					 AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'MUX')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'RYK')
                     AND t.City_Edition = 'MUX' THEN t.Size_CM * t.Col_Size
                
                WHEN t.City_Edition = 'QTA' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 2
        
        -- FOR t.Publication = 3
        WHEN t.Publication = 3 THEN
            CASE 
                WHEN t.City_Edition = 'LHE' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'ISB' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'MUX' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 3
        
        -- FOR t.Publication = 4
        WHEN t.Publication = 4 THEN
            CASE 
				WHEN t.City_Edition IN ('ISB', 'PEW') 
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'ISB')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'PEW')
                     AND t.City_Edition = 'ISB' THEN t.Size_CM * t.Col_Size
                     
                WHEN t.City_Edition = 'LHE' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'MUX' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 4
        
        -- FOR t.Publication = 5
        WHEN t.Publication = 5 THEN
            CASE 
                WHEN t.City_Edition = 'QTA' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'PEW' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 5
        
        -- FOR t.Publication = 6
        WHEN t.Publication = 6 THEN
            CASE 
				WHEN t.City_Edition IN ('LHE', 'MUX') 
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'LHE')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'MUX')
                     AND t.City_Edition = 'LHE' THEN t.Size_CM * t.Col_Size
                     
                WHEN t.City_Edition = 'PEW' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 6
        
        -- FOR t.Publication = 7
        WHEN t.Publication = 7 THEN
            CASE 
                WHEN t.City_Edition = 'PEW' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 7
        
        -- FOR t.Publication = 8
        WHEN t.Publication = 8 THEN
            CASE 
                WHEN t.City_Edition = 'LHE' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'ISB' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 8
        
        -- FOR t.Publication = 9
        WHEN t.Publication = 9 THEN
            CASE 
                WHEN t.City_Edition = 'MUX' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'ISB' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 9
        
        -- FOR t.Publication =10000003
        WHEN t.Publication = 10000003 THEN
            CASE 
                WHEN t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 10000003
        
        --FOR Publication = 10000004
        WHEN t.Publication = 10000004 THEN
            CASE 
                WHEN t.City_Edition IN ('ISB', 'PEW') 
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'ISB')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'PEW')
                     AND t.City_Edition = 'ISB' THEN t.Size_CM * t.Col_Size

                WHEN t.City_Edition IN ('KHI', 'SUK') 
					 AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'KHI')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'SUK')
					 AND t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                
                WHEN t.City_Edition IN ('LHE', 'FSB', 'GUJ', 'SGD') 
					 AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'LHE')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'FSB')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'GUJ')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'SGD')
					 AND t.City_Edition = 'LHE' THEN t.Size_CM * t.Col_Size
                
                WHEN t.City_Edition IN ('MUX', 'RYK') 
					 AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'MUX')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'RYK')
                     AND t.City_Edition = 'MUX' THEN t.Size_CM * t.Col_Size
                
                ELSE 0
            END
       -- END OF t.Publication = 10000004
       
       -- FOR t.Publication =10000005
        WHEN t.Publication = 10000005 THEN
            CASE 
                WHEN t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 10000005
        
        -- FOR t.Publication =10000038
        WHEN t.Publication = 10000038 THEN
            CASE 
                WHEN t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 10000038
        
        -- FOR t.Publication =10000039
        WHEN t.Publication = 10000039 THEN
            CASE 
                WHEN t.City_Edition = 'HYD' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 10000039
        
        -- FOR t.Publication =10000016
        WHEN t.Publication = 10000016 THEN
            CASE 
                WHEN t.City_Edition = 'LHE' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'ISB' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 10000016
        
        -- FOR t.Publication =10000017
        WHEN t.Publication = 10000017 THEN
            CASE 
                WHEN t.City_Edition = 'LHE' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition IN ('ISB', 'PEW') 
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'ISB')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'PEW')
                     AND t.City_Edition = 'ISB' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 10000017
        
        -- FOR t.Publication =10000018
        WHEN t.Publication = 10000018 THEN
            CASE 
                WHEN t.City_Edition = 'LHE' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'ISB' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
        -- END OF t.Publication = 10000018
        
        --FOR Publication = 10000034
        WHEN t.Publication = 10000034 THEN
            CASE 
                WHEN t.City_Edition IN ('LHE', 'FSB') 
					 AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'LHE')
                     AND EXISTS (SELECT 1 FROM Transactions WHERE City_Edition = 'FSB')
					 AND t.City_Edition = 'LHE' THEN t.Size_CM * t.Col_Size
                
                WHEN t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'ISB' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'QTA' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
       -- END OF t.Publication = 10000034
       
       --FOR Publication = 10000035
        WHEN t.Publication = 10000035 THEN
            CASE 
                WHEN t.City_Edition = 'KHI' THEN t.Size_CM * t.Col_Size
                WHEN t.City_Edition = 'LHE' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
       -- END OF t.Publication = 10000035
       
       --FOR Publication = 10000036
        WHEN t.Publication = 10000036 THEN
            CASE 
                WHEN t.City_Edition = 'HYD' THEN t.Size_CM * t.Col_Size
                ELSE 0
            END
       -- END OF t.Publication = 10000036
       
        ELSE 0
        
    END AS Total
FROM 
    Transactions t
INNER JOIN 
    ClientCompanies cc ON t.Client_Company = cc.Id
INNER JOIN 
    GroupComps gc ON cc.Edition_Responsible = gc.GroupComp_Id
INNER JOIN 
    Publications p ON t.Publication = p.Id
INNER JOIN 
    MainCategories mcat ON t.Main_Category = mcat.Id
INNER JOIN 
    SubCategories scat ON t.Sub_Category = scat.Id
LEFT JOIN 
    Types ON t.Type_Id = Types.Id
LEFT JOIN 
    Brands ON t.Brand = Brands.Id


	--where Publication_Date BETWEEN '2024-02-01' AND '2024-02-28' 
GO
