CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_MISS_REASON_MAP_2(	
client_id	
, elwis_itm_miss_reason_cd	
, wawi_itm_miss_reason_cd	
)	
AS	
   SELECT	
  client_id,	
   missing_reason_cd,	
   mis_item_missing_reason_cd	
  FROM p_lew_core_ac.v_map_mis_item_missing_reason_2	
;