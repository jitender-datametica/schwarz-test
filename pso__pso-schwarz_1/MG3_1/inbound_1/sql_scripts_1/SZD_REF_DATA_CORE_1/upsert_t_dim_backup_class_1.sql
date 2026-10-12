DELETE 
FROM CORE.T_DIM_BACKUP_CLASS;

INSERT INTO CORE.T_DIM_BACKUP_CLASS (       
                            BACKUP_CLASS_ID
                            ,BACKUP_CLASS_DESCR
                            ,BACKUP_CLASS_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
)
SELECT                      
                            BACKUP_CLASS_ID
                            ,BACKUP_CLASS_DESCR
                            ,BACKUP_CLASS_DESCR_DE
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
FROM ETL.T_DIM_BACKUP_CLASS_TEMP
WHERE BACKUP_CLASS_ID IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY BACKUP_CLASS_ID ORDER BY  DWH_CREATED_TMSP DESC) = 1;

COMMIT;
