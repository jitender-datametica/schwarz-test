CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_correlation_buyer_name AS SELECT manager_desc,
 manager_login,
 buyer_desc,
 buyer_short_desc,
 buyer_login
FROM ldl_p_lew_core_ac.v_wawi_ref_correlation_buyer_name AS RCV;