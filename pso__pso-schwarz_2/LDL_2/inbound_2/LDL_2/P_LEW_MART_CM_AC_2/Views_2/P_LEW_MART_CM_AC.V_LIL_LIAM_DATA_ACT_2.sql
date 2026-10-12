CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_LIAM_DATA_ACT_2
(
client_id
, clnt_rtl_id
, rtl_id
, rtl_lvl
, per_id
, liam_parnt_clnt_cat_id
, liam_clnt_cat_id
, prom_id
, raw_buyer_id
, currency_iso_cd
, meas_id
, meas_tp_id
, val
, py_val
, pq_val
, data_avbl_fg
, prot_fg
) AS
SELECT
client_id
, clnt_rtl_id
, rtl_id
, rtl_lvl
, per_id
, liam_parnt_clnt_cat_id
, liam_clnt_cat_id
, prom_id
, raw_buyer_id
, currency_iso_cd
, meas_id
, meas_tp_id
, val
, py_val
, pq_val
, data_avbl_fg
, prot_fg
FROM P_LEW_MART_CM.V_LIL_LIAM_DATA_ACT_2 ;
