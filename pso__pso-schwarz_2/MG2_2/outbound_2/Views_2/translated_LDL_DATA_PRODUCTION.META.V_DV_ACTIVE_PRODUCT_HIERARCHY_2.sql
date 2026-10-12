CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_active_product_hierarchy_2 (prod_sid, prod_dwh_valid_from_tmsp,
prod_dwh_valid_to_tmsp, prod_nr, prod_name, prod_descr, prod_creation_dt, prod_type_cd, prod_type_descr, item_type_cd,
item_type_descr, item_fam_sid, fam_dwh_valid_from_tmsp, fam_dwh_valid_to_tmsp, item_fam_nr, item_fam_name,
sub_item_grp_sid, sig_dwh_valid_from_tmsp, sig_dwh_valid_to_tmsp, sub_item_grp_nr, sub_item_grp_name, int_item_grp_sid,
iig_dwh_valid_from_tmsp, iig_dwh_valid_to_tmsp, int_item_grp_nr, int_item_grp_name, failed_item_family_consistent,
failed_sub_item_group_consistent, failed_int_item_group_consistent, total)
OPTIONS(DESCRIPTION = `ACTIVE PRODUCTS FROM LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_PRODUCT_2 AND RELATED HIERARCHIES (ITEM_2 FAMILY, SUB ITEM_2 GROUP, INTERNATIONAL ITEM_2 GROUP)\\NINPUT DATASETS:\\NCORE_DIM.T_DIM_PRODUCT_2\\NCORE_DIM.T_DIM_ITEM_FAMILY_2\\NCORE_DIM.T_DIM_SUB_ITEM_GROUP_2\\NCORE_DIM.T_DIM_INTERNATIONAL_ITEM_GROUP_2`)
AS SELECT prod.prod_sid,
 prod.dwh_valid_from_tmsp AS prod_dwh_valid_from_tmsp,
 prod.dwh_valid_to_tmsp AS prod_dwh_valid_to_tmsp,
 prod.prod_nr,
 prod.prod_name,
 prod.prod_descr,
 prod.prod_creation_dt,
 prod.prod_type_cd,
 prod.prod_type_descr,
 prod.item_type_cd,
 prod.item_type_descr,
 fam.item_fam_sid,
 fam.dwh_valid_from_tmsp AS fam_dwh_valid_from_tmsp,
 fam.dwh_valid_to_tmsp AS fam_dwh_valid_to_tmsp,
 fam.item_fam_nr,
 fam.item_fam_name,
 sig.sub_item_grp_sid,
 sig.dwh_valid_from_tmsp AS sig_dwh_valid_from_tmsp,
 sig.dwh_valid_to_tmsp AS sig_dwh_valid_to_tmsp,
 sig.sub_item_grp_nr,
 sig.sub_item_grp_name,
 iig.int_item_grp_sid,
 iig.dwh_valid_from_tmsp AS iig_dwh_valid_from_tmsp,
 iig.dwh_valid_to_tmsp AS iig_dwh_valid_to_tmsp,
 iig.int_item_grp_nr,
 iig.int_item_grp_name,
  CASE
  WHEN fam.item_fam_sid = - 1 OR fam.item_fam_sid IS NULL
  THEN 1
  ELSE 0
  END AS failed_item_family_consistent,
  CASE
  WHEN sig.sub_item_grp_sid = - 1 OR sig.sub_item_grp_sid IS NULL
  THEN 1
  ELSE 0
  END AS failed_sub_item_group_consistent,
  CASE
  WHEN iig.int_item_grp_sid = - 1 OR iig.int_item_grp_sid IS NULL
  THEN 1
  ELSE 0
  END AS failed_int_item_group_consistent,
 1 AS total
FROM ldl_data_production_core_dim.t_dim_product_2 AS prod
 LEFT JOIN ldl_data_production_core_dim.t_dim_item_family_2 AS fam ON prod.item_fam_sid = fam.item_fam_sid AND fam.dwh_valid_fg
  
 LEFT JOIN ldl_data_production_core_dim.t_dim_sub_item_group_2 AS sig ON fam.sub_item_grp_sid = sig.sub_item_grp_sid AND
  sig.dwh_valid_fg
 LEFT JOIN ldl_data_production_core_dim.t_dim_international_item_group_2 AS iig ON sig.int_item_grp_sid = iig.int_item_grp_sid
    AND iig.dwh_valid_fg
WHERE prod.prod_sid <> - 1
 AND prod.dwh_valid_fg;