CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_VPE_OF_RETAILERS_LIFT
(
    rtl_id
    , lift_cat_id
    , VALUEPOTENTIAL
    , VPE
    , IsLidl
    , client_id
    , per_id
    , currency_iso_cd
    , Rnk_id
    , Rnk_desc
    , Max_Raw_buyer
    , rtl_tp_id
)
AS
SELECT   
    rtl_id
    , lift_cat_id
    , VALUEPOTENTIAL
    , VPE
    , IsLidl
    , client_id
    , per_id
    , currency_iso_cd
    , Rnk_id
    , Rnk_desc
    , Max_Raw_buyer
    , rtl_tp_id
FROM P_LEW_MART_CM.V_LIL_VPE_OF_RETAILERS_LIFT;
