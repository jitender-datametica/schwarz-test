CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_LCSD_DATA_ACT
(
client_id
, clnt_rtl_id
, rtl_id
, rtl_lvl
, per_id
, lift_cat_id
, prom_id
, lcsd_id
, raw_buyer_id
, currency_iso_cd
, meas_id
, val
, py_val
, per_desc
, per_desc_EN
, py_per_desc
, py_per_desc_EN
, prot_fg
) AS
SELECT
client_id
, clnt_rtl_id
, rtl_id
, rtl_lvl
, per_id
, lift_cat_id
, prom_id
, lcsd_id
, raw_buyer_id
, currency_iso_cd
, meas_id
, val
, py_val
, per_desc
, per_desc_EN
, py_per_desc
, py_per_desc_EN
, prot_fg
FROM P_LEW_MART_CM.V_LIL_LCSD_DATA_ACT ;
