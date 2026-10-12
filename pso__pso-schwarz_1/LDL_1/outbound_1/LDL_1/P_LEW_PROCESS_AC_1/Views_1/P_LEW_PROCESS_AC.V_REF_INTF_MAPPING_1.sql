CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_ref_intf_mapping_1 (app_name, pset, interface_key, system_key) AS SELECT
 app_name,
 pset,
 interface_key,
 system_key
FROM ldl_p_lew_process.t_ref_intf_mapping_1;