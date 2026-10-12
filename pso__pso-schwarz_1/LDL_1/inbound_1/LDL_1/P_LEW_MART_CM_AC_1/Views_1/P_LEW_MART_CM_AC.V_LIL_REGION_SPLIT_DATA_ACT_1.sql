CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_REGION_SPLIT_DATA_ACT_1
(
  client_id
, rtl_id
, rtl_lvl
, per_id
, lift_cat_id
, prom_id
, region_split_id
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
)
AS
SELECT
  client_id
, rtl_id
, rtl_lvl
, per_id
, lift_cat_id
, prom_id
, region_split_id
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
FROM P_LEW_MART_CM.V_LIL_REGION_SPLIT_DATA_ACT_1;

