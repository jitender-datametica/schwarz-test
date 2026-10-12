CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_qr_tot_mkt_corr (client_id, rtl_id, per_id, currency_iso_cd,
corr_val_k, corr_py_val_k) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_qr_tot_mkt_corr;