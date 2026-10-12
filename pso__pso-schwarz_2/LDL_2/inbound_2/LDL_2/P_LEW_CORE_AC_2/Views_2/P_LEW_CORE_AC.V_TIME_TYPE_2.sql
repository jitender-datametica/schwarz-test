CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_TIME_TYPE_2
( CLIENT_ID                    
,TIME_TYPE_SID               
,SRC_WH_ID                   
,SRC_TIME_TYPE_ID            
,SRC_TIME_TYPE_CD           
,SOURCE_SYSTEM               
,DWH_LOAD_ID               
,DWH_CREATED             
,DWH_UPDATED 
)
AS
   SELECT
     CLIENT_ID                    
	,TIME_TYPE_SID               
	,SRC_WH_ID                   
	,SRC_TIME_TYPE_ID            
	,SRC_TIME_TYPE_CD           
	,SOURCE_SYSTEM               
	,DWH_LOAD_ID               
	,DWH_CREATED             
	,DWH_UPDATED 
  FROM P_LEW_CORE.T_TIME_TYPE_2  ;