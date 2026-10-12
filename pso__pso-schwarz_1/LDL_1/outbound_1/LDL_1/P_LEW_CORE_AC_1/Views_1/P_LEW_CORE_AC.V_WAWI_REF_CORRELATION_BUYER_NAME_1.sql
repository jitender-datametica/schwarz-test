CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_correlation_buyer_name_1 (manager_desc, manager_login, buyer_desc,
buyer_short_desc, buyer_login, timestamp_fn, dat_dayend, load_id) AS SELECT manager_desc,
 manager_login,
 buyer_desc,
 buyer_short_desc,
 buyer_login,
 timestamp_fn,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_correlation_buyer_name_1;