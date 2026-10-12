CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_item_1 (client_id, item_sid, src_matnr,
src_orig_item_nr, src_dat_valid_from, src_case_size, item_sid_config, item_name, log_var_cd, config_item_cd, item_eks_cd
, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_sid,
 src_matnr,
 src_orig_item_nr,
 src_dat_valid_from,
 src_case_size,
 item_sid_config,
 item_name,
 log_var_cd,
 config_item_cd,
 item_eks_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_1;