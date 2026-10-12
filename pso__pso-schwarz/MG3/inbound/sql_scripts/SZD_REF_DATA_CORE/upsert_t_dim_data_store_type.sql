DELETE 
FROM CORE.T_DIM_DATA_STORE_TYPE;

INSERT INTO CORE.T_DIM_DATA_STORE_TYPE (       
                            DATA_STORE_TYPE_CD
                            ,DATA_STORE_TYPE_NAME
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
)
SELECT                      
                            DATA_STORE_TYPE_CD
                            ,DATA_STORE_TYPE_NAME
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
FROM ETL.T_DIM_DATA_STORE_TYPE_TEMP
WHERE DATA_STORE_TYPE_CD IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY DATA_STORE_TYPE_CD ORDER BY  DWH_CREATED_TMSP DESC) = 1;

COMMIT;
