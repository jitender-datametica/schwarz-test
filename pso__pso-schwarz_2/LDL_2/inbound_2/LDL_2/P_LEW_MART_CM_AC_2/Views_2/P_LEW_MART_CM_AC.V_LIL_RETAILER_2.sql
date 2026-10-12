CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_RETAILER_2
(
   rtl_id
  ,rtl_desc
  ,rtl_desc_EN
  ,rpt_delta_sym
  ,rtl_desc_delta_py_perc 
  ,rtl_desc_delta_py_perc_EN
) AS
SELECT
   rtl_id
  ,rtl_desc
  ,rtl_desc_EN
  ,rpt_delta_sym
  ,rtl_desc_delta_py_perc 
  ,rtl_desc_delta_py_perc_EN
FROM P_LEW_MART_CM.V_LIL_RETAILER_2 ;

