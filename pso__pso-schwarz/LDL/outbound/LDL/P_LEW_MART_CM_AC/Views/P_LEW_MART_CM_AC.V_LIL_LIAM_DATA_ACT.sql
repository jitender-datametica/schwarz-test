CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_liam_data_act (client_id, clnt_rtl_id, rtl_id, rtl_lvl, per_id,
liam_parnt_clnt_cat_id, liam_clnt_cat_id, prom_id, raw_buyer_id, currency_iso_cd, meas_id, meas_tp_id, val, py_val,
pq_val, data_avbl_fg, prot_fg) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_liam_data_act;