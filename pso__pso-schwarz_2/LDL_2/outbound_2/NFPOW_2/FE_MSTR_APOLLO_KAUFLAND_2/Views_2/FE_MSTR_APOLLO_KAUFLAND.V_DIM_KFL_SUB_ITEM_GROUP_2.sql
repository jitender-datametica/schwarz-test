CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_dim_kfl_sub_item_group_2 (kfl_client_id, kfl_sub_item_grp_id,
kfl_item_grp_id, kfl_major_item_grp_id, kfl_main_item_grp_id, kfl_department_id, kfl_sub_item_grp_name,
kfl_item_grp_name, kfl_major_item_grp_name, kfl_main_item_grp_name, kfl_department_name) AS SELECT kfl_client_id,
 kfl_sub_item_grp_id,
 kfl_item_grp_id,
 kfl_major_item_grp_id,
 kfl_main_item_grp_id,
 kfl_department_id,
 kfl_sub_item_grp_name,
 kfl_item_grp_name,
 kfl_major_item_grp_name,
 kfl_main_item_grp_name,
 kfl_department_name
FROM nfpow_core.t_dim_kfl_sub_item_group_2;