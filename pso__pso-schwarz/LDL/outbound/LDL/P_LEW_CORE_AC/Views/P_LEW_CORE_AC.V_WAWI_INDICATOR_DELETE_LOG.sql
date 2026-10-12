CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_indicator_delete_log (client_id, org_type_id, org_unit_nr, indicator_id
, indicator_type_id, cy, dat_formdate_from, dat_formdate_until, cal_week_from, cal_week_until, month_id_from,
month_id_until, timestamp_fn, dat_dayend, load_id) AS SELECT client_id,
 org_type_id,
 org_unit_nr,
 indicator_id,
 indicator_type_id,
 cy,
 dat_formdate_from,
 dat_formdate_until,
 cal_week_from,
 cal_week_until,
 month_id_from,
 month_id_until,
 timestamp_fn,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_indicator_delete_log;