CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_despatch_advice (client_id, loc_sid_wh, despatch_advice_id, sup_sid,
est_deliv_dt, shipping_dt, despatch_advice_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 loc_sid_wh,
 despatch_advice_id,
 sup_sid,
 est_deliv_dt,
 shipping_dt,
 despatch_advice_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_despatch_advice;