
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_SYS_INTERFACE_LOG_2   
/*
#DescStart#    
#$Revision: 11751 $, $LastChangedBy: mahdi $ 
#SubjectAreas#: Systemtabellen     
#DescEnd# 
*/   
(    
     client_id 
,          wh_id    
,          wh_desc  
,          store_id 
,          store_desc    
,          orig_store_nr 
,          system_key    
,          system_desc   
,          interface_key 
,          interface_desc     
,          dat_dayend    
,          mcc_fg   
,          mail_rows     
,          conv_rows     
,          load_rows     
,          mload_rows    
,          target_rows   
,          trans_fg 
,          timestamp_load     
,          timestamp_mod 
,          source_sent_tmsp   
,          mail_in_tmsp  
)    

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS   
   ( 
        SELECT      WLsp.client_id                             AS client_id,    
   COALESCE(Wh.src_wh_id, WLsp.wh_loc_sid)    AS wh_id,     
   WLsp.wh_desc                               AS wh_desc,   
   WLsp.st_loc_sid                            AS store_id,  
   WLsp.store_desc                            AS store_desc,     
   WLsp.orig_store_nr                         AS orig_store_nr,  
   WLsp.system_key                            AS system_key,     
   WLsp.system_desc                           AS system_desc,    
   WLsp.interface_key                         AS interface_key,  
   WLsp.interface_desc                        AS interface_desc, 
   WLsp.dat_dayend                            AS dat_dayend,     
   WLsp.mcc_fg                                AS mcc_fg,    
   WLsp.mail_rows                             AS mail_rows, 
   WLsp.conv_rows                             AS conv_rows, 
   WLsp.load_rows                             AS load_rows, 
   WLsp.mload_rows                            AS mload_rows,     
   WLsp.target_rows                           AS target_rows,    
   WLsp.trans_fg                              AS trans_fg,  
   WLsp.timestamp_load                        AS timestamp_load, 
   WLsp.timestamp_mod                         AS timestamp_mod,  
   WLsp.source_sent_tmsp                      AS source_sent_tmsp,    
   WLsp.mail_in_tmsp                          AS mail_in_tmsp    
FROM p_lew_core_ac.v_wawi_sys_load_status_present_2    AS WLsp     
   INNER JOIN p_lew_bil_ac.v_warehouse_2           AS Wh 
   ON     WLsp.client_id = Wh.client_id 
   AND    
    WLsp.wh_loc_sid = Wh.loc_sid_wh     
   AND    
    Wh.dwh_actual_fg = 1 
)    
;
