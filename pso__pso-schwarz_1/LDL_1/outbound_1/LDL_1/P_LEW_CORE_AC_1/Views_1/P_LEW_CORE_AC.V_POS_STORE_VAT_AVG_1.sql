CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_pos_store_vat_avg_1 (client_id, loc_sid, dwh_cal_dt, avg_pct_vat, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 loc_sid,
 dwh_cal_dt,
 avg_pct_vat,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_pos_store_vat_avg_1;