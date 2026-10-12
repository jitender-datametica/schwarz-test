CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_CNTL_DDL_RESULT_TMP_2
AS
SELECT
      dll.SF_SCHEMA                       
    , dll.NAME_SCHEMA                    
    , dll.TABLE_TYPE  
    , dll.SF_NAME    
    , dll.SQL_GETDDL                    
    , dll.SQL_DESCRIBE                    
    , dll.SQL_DROP                      
    , dll.RecNbr                        
    , dll.OWNER                            
    , dll.DESCRIPTION                   
    , dll.ANNOTATION                    
    , dll.CREATED_TS                    
        
    , dll.SQL_RESULT                     
      
    -- Technical fields
    , dll.REJECT_FG                     
    , dll.REJECT_REASON_ID              
    , dll.SOURCE_SYSTEM_ID              
    , dll.DELETED_FG                    
    , dll.DWH_CREATED_TS                
    , dll.DWH_UPDATED_TS                
    , dll.LOAD_ID   

    , ROW_NUMBER() OVER (PARTITION BY dll.SF_SCHEMA, dll.NAME_SCHEMA, dll.TABLE_TYPE ORDER BY DWH_CREATED_TS DESC) AS  _ROWNUMBER
    
    , (DENSE_RANK () OVER (PARTITION BY dll.SF_SCHEMA, dll.NAME_SCHEMA, dll.TABLE_TYPE ORDER BY DWH_CREATED_TS DESC) -1 ) * (-1) MOVING_RUN_ID_FROM_CURRENT
    
FROM P_LEW_MART_PIT_ONPREM.T_CNTL_DLL_RESULT_TMP_2 dll
WHERE TRUE     
    AND dll.DELETED_FG = 0
ORDER BY dll.SF_SCHEMA, dll.NAME_SCHEMA, dll.TABLE_TYPE;