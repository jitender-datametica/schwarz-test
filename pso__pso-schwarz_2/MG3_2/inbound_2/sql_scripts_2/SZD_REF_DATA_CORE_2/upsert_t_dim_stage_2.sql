DELETE 
FROM CORE.T_DIM_STAGE;

INSERT INTO CORE.T_DIM_STAGE (       
                            STAGE_CD
                            ,STAGE_DESCR
                            ,STAGE_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
)
SELECT                      
                            STAGE_CD
                            ,STAGE_DESCR
                            ,STAGE_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
FROM ETL.T_DIM_STAGE_TEMP_2
WHERE STAGE_CD IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY STAGE_CD ORDER BY  DWH_CREATED_TMSP DESC) = 1;

COMMIT;
