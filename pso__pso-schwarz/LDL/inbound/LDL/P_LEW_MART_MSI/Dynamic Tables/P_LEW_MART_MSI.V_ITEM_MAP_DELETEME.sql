
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITEM_MAP_DELETEME(  
     client_id 
,          item_sid  
,          item_id   
,          parent_client_id    /* Note: the client_id and parent_client_id should be the same or something has gone very wrong */   
,          parent_item_sid 
,          parent_item_id  
)  

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS 
   (/*  could fix a missing parent by coalescing with the child but we don't want to mask the error  */  
        SELECT      ItmC.client_id          AS client_id,   
   ItmC.item_sid           AS item_sid,   
   ItmC.item_id            AS item_id, 
   ItmP.client_id          AS parent_client_id, 
   ItmC.parent_item_sid    AS parent_item_sid,  
   ItmP.item_id            AS parent_item_id 
FROM p_lew_mart_msi.v_item_map_direct_DeleteMe    AS ItmC    /* Child */   
   LEFT OUTER JOIN p_lew_mart_msi.v_item_map_direct_DeleteMe    AS ItmP    /* Parent */   
   ON 
   ItmC.parent_item_sid = ItmP.item_sid   
)  
;
