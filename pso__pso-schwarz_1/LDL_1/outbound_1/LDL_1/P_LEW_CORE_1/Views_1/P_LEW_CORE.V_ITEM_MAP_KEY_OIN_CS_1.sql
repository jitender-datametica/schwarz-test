CREATE OR REPLACE VIEW ldl_p_lew_core.v_item_map_key_oin_cs_1 AS SELECT client_id,
 item_sid,
 item_sid_map,
 COALESCE(wawi_dwh_orig_item_nr, dwh_orig_item_nr) AS src_orig_item_nr,
 COALESCE(wawi_dwh_case_size, dwh_case_size, 0) AS src_case_size,
 COALESCE(wawi_dwh_dat_valid_from, DATE '1900-01-01') AS wawi_dwh_dat_valid_from,
 active_fg,
 dummy_fg,
 source_cd
FROM ldl_p_lew_core.t_item_map_key_1
WHERE COALESCE(wawi_dwh_case_size, dwh_case_size, 0) > 0
QUALIFY (ROW_NUMBER() OVER (PARTITION BY client_id, CAST(COALESCE(wawi_dwh_orig_item_nr, dwh_orig_item_nr) AS STRING),
      COALESCE(wawi_dwh_case_size, dwh_case_size, 0) ORDER BY active_fg IS NULL, active_fg, COALESCE(dummy_fg, 0)
      IS NULL, COALESCE(dummy_fg, 0), COALESCE(wawi_dwh_dat_valid_from, DATE '1900-01-01') IS NULL, COALESCE(wawi_dwh_dat_valid_from
       , DATE '1900-01-01'), wawi_dwh_item_id IS NULL, wawi_dwh_item_id, item_sid IS NULL, item_sid)) = 1;