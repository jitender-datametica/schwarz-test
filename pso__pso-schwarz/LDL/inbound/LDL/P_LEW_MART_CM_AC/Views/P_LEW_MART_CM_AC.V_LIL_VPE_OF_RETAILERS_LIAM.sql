CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_VPE_OF_RETAILERS_LIAM
(
  client_id
  , per_id
  , liam_clnt_cat_id
  , liam_parnt_clnt_cat_id
  , ValuePotential
  , VPE
  , IsLidl
  , rtl_id
  , Rnk_id
  , Rnk_desc
  , max_raw_buyer
  , rtl_tp_id
  , currency_iso_cd
)
AS
SELECT 
  client_id
  , per_id
  , liam_clnt_cat_id
  , liam_parnt_clnt_cat_id
  , ValuePotential
  , VPE
  , IsLidl
  , rtl_id
  , Rnk_id
  , Rnk_desc
  , max_raw_buyer
  , rtl_tp_id
  , currency_iso_cd
FROM P_LEW_MART_CM.V_LIL_VPE_OF_RETAILERS_LIAM;
