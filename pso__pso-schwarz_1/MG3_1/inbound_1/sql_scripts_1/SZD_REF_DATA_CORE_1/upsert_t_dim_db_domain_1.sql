DELETE 
FROM CORE.T_DIM_DB_DOMAIN;

INSERT INTO CORE.T_DIM_DB_DOMAIN (       
                            DB_DOMAIN_ID
                            ,DB_DOMAIN_NAME
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
)
SELECT                      
                            DB_DOMAIN_ID
                            ,DB_DOMAIN_NAME
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
FROM ETL.T_DIM_DB_DOMAIN_TEMP
WHERE DB_DOMAIN_ID IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY DB_DOMAIN_ID ORDER BY  DWH_CREATED_TMSP DESC) = 1;

COMMIT;
