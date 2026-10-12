CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_lil_retailer_2 (rtl_id, rtl_desc, rpt_delta_sym) AS SELECT rtl_id,
 rtl_desc,
 '\\u0394' AS rpt_delta_sym
FROM ldl_p_lew_core_ac.v_wawi_lil_retailer_2;