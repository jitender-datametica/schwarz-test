 CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_TIME_TYPE_HIST_1
( CLIENT_ID                           
,TIME_TYPE_SID                         
,TIME_TYPE_SHORT_DESCR              
,TIME_TYPE_DESCR                    
,PRESENCE_FG                         
,PERFORMANCE_RELEVANT_FG   
,ACTIVE_FROM_DT       
,ACTIVE_TO_DT                        
,DELETED_FG                          
,DWH_VALID_FROM                     
,DWH_VALID_TO                    
,DWH_LOAD_ID                   
,DWH_CREATED                     
,DWH_UPDATED                   
)
AS
   SELECT    CLIENT_ID                           
,TIME_TYPE_SID                          
,TIME_TYPE_SHORT_DESCR              
,TIME_TYPE_DESCR                    
,PRESENCE_FG                         
,PERFORMANCE_RELEVANT_FG   
,ACTIVE_FROM_DT       
,ACTIVE_TO_DT                        
,DELETED_FG                          
,DWH_VALID_FROM                     
,DWH_VALID_TO                    
,DWH_LOAD_ID                   
,DWH_CREATED                     
,DWH_UPDATED                   
  FROM P_LEW_CORE.T_TIME_TYPE_HIST_1 ;