DELETE 
FROM CORE.T_DIM_DB_DELIVERY_STATE;

INSERT INTO CORE.T_DIM_DB_DELIVERY_STATE (       
                            DB_DELIVERY_STATE_ID
                            ,DB_DELIVERY_STATE_DESCR
                            ,DB_DELIVERY_STATE_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
)
SELECT                      
                            DB_DELIVERY_STATE_ID
                            ,DB_DELIVERY_STATE_DESCR
                            ,DB_DELIVERY_STATE_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
FROM ETL.T_DIM_DB_DELIVERY_STATE_TEMP
WHERE DB_DELIVERY_STATE_ID IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY DB_DELIVERY_STATE_ID ORDER BY  DWH_CREATED_TMSP DESC) = 1;

COMMIT;
