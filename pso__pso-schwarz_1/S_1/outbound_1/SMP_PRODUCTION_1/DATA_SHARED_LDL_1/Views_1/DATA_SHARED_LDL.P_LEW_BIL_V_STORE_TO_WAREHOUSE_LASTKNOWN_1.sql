CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_bil_v_store_to_warehouse_lastknown_1 (client_id, loc_sid_store
, loc_sid_wh, src_wh_id, src_orig_store_nr, dwh_valid_from, dwh_valid_to, dwh_actual_fg, active_fg, future_active_fg) AS
SELECT client_id,
 loc_sid_store,
 loc_sid_wh,
 src_wh_id,
 src_orig_store_nr,
 dwh_valid_from,
 dwh_valid_to,
 dwh_actual_fg,
 active_fg,
 future_active_fg
FROM ldl_p_lew_bil.v_store_to_warehouse_lastknown_1;