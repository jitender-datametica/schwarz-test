DELETE 
FROM CORE.T_DIM_DB_TYPE;

INSERT INTO CORE.T_DIM_DB_TYPE (       
                            DB_TYPE_ID
                            ,DB_TYPE_DESCR
                            ,DB_TYPE_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
)
SELECT                      
                            DB_TYPE_ID
                            ,DB_TYPE_DESCR
                            ,DB_TYPE_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
FROM ETL.T_DIM_DB_TYPE_TEMP
WHERE DB_TYPE_ID IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY DB_TYPE_ID ORDER BY  DWH_CREATED_TMSP DESC) = 1;

COMMIT;
