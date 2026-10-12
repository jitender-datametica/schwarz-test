CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_RETAILER_TYPE_1
(
   rtl_tp_id
  ,rtl_tp_desc
  ,rtl_tp_desc_EN
  ,rtl_tp_other
  ,rtl_tp_other_EN
  ,rtl_tp_total_of_selected
  ,rtl_tp_total_of_selected_EN
) AS
SELECT
   rtl_tp_id
  ,rtl_tp_desc
  ,rtl_tp_desc_EN
  ,rtl_tp_other
  ,rtl_tp_other_EN
  ,rtl_tp_total_of_selected
  ,rtl_tp_total_of_selected_EN
FROM P_LEW_MART_CM.V_LIL_RETAILER_TYPE_1 ;
