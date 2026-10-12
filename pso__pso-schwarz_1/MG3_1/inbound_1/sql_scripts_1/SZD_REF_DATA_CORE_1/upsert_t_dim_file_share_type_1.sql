DELETE 
FROM CORE.T_DIM_FILE_SHARE_TYPE;

INSERT INTO CORE.T_DIM_FILE_SHARE_TYPE (       
                            FILE_SHARE_TYPE_CD
                            ,FILE_SHARE_TYPE_DESCR
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
)
SELECT                      
                            FILE_SHARE_TYPE_CD
                            ,FILE_SHARE_TYPE_DESCR
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
FROM ETL.T_DIM_FILE_SHARE_TYPE_TEMP
WHERE FILE_SHARE_TYPE_CD IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY FILE_SHARE_TYPE_CD ORDER BY DWH_CREATED_TMSP DESC) = 1;

COMMIT;
