CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_item_2_wawi_item_2 AS
-- Case_size -1 fuer die Dummyartikel aus WAWI DWH ERJ Verarbeitung.
 SELECT client_id,
 item_sid AS item_id,
 item_sid_map AS wawi_item_id
FROM ldl_p_lew_core_ac.v_item_map_key_2 AS A
WHERE (wawi_dwh_orig_item_nr IS NULL OR wawi_dwh_case_size = - 1)
 AND item_sid_map IS NOT NULL;