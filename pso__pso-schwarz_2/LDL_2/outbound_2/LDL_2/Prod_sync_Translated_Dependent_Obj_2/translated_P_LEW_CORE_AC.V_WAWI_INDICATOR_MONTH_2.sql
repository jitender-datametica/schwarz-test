CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_indicator_month_2 (client_id, org_type_id, org_unit_nr, indicator_id,
indicator_type_id, cy, month_id, val_indicator, timestamp_fn, dat_dayend, load_id) AS SELECT *
FROM ldl_p_lew_core.t_wawi_indicator_month_2;