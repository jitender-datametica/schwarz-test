CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_LIFT_DATA_ACT_2
(
client_id
, rtl_id
, rtl_lvl
, per_id
, period_year
, lift_cat_id
, prom_id
, raw_buyer_id
, currency_iso_cd
, meas_id
, val
, py_val
, mat_latest_fg
, per_desc
, per_desc_EN
, py_per_desc
, py_per_desc_EN
, prot_fg
)
AS
SELECT
client_id
, rtl_id
, rtl_lvl
, per_id
, period_year
, lift_cat_id
, prom_id
, raw_buyer_id
, currency_iso_cd
, meas_id
, val
, py_val
, mat_latest_fg
, per_desc
, per_desc_EN
, py_per_desc
, py_per_desc_EN
, prot_fg
FROM P_LEW_MART_CM.V_LIL_LIFT_DATA_ACT_2;
