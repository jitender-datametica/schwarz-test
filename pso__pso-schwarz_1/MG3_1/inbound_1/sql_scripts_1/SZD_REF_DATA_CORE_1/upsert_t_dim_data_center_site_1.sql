DELETE 
FROM CORE.T_DIM_DATA_CENTER_SITE;

INSERT INTO CORE.T_DIM_DATA_CENTER_SITE (       
                            SITE_CD
                            ,COUNTRY_POL_CD
                            ,SITE_NAME
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
)
SELECT                      
                            SITE_CD
                            ,COUNTRY_POL_CD
                            ,SITE_NAME
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
FROM ETL.T_DIM_DATA_CENTER_SITE_TEMP
WHERE SITE_CD IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY SITE_CD ORDER BY DWH_CREATED_TMSP DESC) = 1;

COMMIT;
