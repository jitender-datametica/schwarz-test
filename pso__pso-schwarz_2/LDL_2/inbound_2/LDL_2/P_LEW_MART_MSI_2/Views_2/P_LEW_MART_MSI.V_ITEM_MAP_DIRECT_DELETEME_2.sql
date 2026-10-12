CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITEM_MAP_DIRECT_DELETEME_2(	
     client_id	
,          item_sid	
,          item_id	
,          parent_item_sid	
)	
AS	
   (	
        SELECT      
        client_id                                                  AS client_id	
        ,item_sid                                                   AS item_sid	
        ,Coalesce(wawi_dwh_item_id, elwis_dwh_itm_sid, item_sid)    AS item_id
        ,Coalesce(item_sid_map, item_sid)                           AS parent_item_sid	
FROM p_lew_core_ac.v_item_map_key_2	
)	
;