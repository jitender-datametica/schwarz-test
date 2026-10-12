CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITEM_2_WAWI_ITEM as
   SELECT	
     a.client_id,	
   a.item_sid AS item_id,	
   a.item_sid_map AS wawi_item_id	
   FROM p_lew_core_ac.v_item_map_key AS a	
   WHERE (a.wawi_dwh_orig_item_nr IS NULL OR a.wawi_dwh_case_size = -1) -- Case_size -1 fuer die Dummyartikel aus WAWI DWH ERJ Verarbeitung. 	
     AND a.item_sid_map IS NOT NULL	
;