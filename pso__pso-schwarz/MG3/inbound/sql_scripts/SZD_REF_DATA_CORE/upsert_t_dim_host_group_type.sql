DELETE 
FROM CORE.T_DIM_HOST_GROUP_TYPE;

INSERT INTO CORE.T_DIM_HOST_GROUP_TYPE (       
                            HOST_GROUP_TYPE_ID
                            ,HOST_GROUP_TYPE_NAME
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
)
SELECT                      
                            HOST_GROUP_TYPE_ID
                            ,HOST_GROUP_TYPE_NAME
                            ,DWH_CREATED_TMSP
                            ,DWH_UPDATED_TMSP
FROM ETL.T_DIM_HOST_GROUP_TYPE_TEMP
WHERE HOST_GROUP_TYPE_ID IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY HOST_GROUP_TYPE_ID ORDER BY DWH_CREATED_TMSP DESC) = 1;

COMMIT;
