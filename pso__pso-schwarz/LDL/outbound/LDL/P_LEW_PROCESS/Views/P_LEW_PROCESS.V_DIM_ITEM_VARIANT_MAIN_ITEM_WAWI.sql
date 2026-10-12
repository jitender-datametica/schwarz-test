CREATE OR REPLACE VIEW ldl_p_lew_process.v_dim_item_variant_main_item_wawi AS
/* 23.05.2019 added fields for hierarchy */ /* 23.05.2019 added sk for family group */
/* changed from INNER JOIN to LEFT  JOIN */
/* to get links to main item for Wawi item variants in Austria, Northern Ireland, Serbia, USA */
/* 23.05.2019 added CROSS JOIN to family group table in BIL */ SELECT core_item.client_id,
 core_item.item_sid AS item_variant_sid,
  LPAD(TRIM(RTRIM(core_item.src_orig_item_nr, '.')), 7, '0') || LPAD(TRIM(SUBSTR(CAST(CAST(COALESCE(WAWI_ITEM.case_size_dec, WAWI_ITEM.case_size) AS BIGNUMERIC) AS STRING), 1, 39)), 4, '0') AS item_variant_nr,
 COALESCE(WAWI_ITEM.dat_valid_from, core_item.src_dat_valid_from) AS item_variant_creation_dt,
 COALESCE(WAWI_ITEM.case_size_dec, WAWI_ITEM.case_size) AS case_size_qty,
  CASE
  WHEN core_item.deleted_fg = 1
  THEN 'del'
  WHEN CAST(TRIM(SUBSTR(CAST(WAWI_ITEM.status_id_hq AS STRING), 1, 39)) AS INTEGER) IN (1, 2, 4, 15)
  THEN TRIM(SUBSTR(CAST(WAWI_ITEM.status_id_hq AS STRING), 1, 39))
  ELSE '@' /* 27.08.2019 changed */
  END AS item_status_cd,
 WAWI_ITEM.package_qty AS container_size_qty,
 COALESCE(SUBSTR(CAST(WAWI_ITEM.listing_type_id AS STRING), 1, 5), '@') AS assortment_type_cd,
 COALESCE(V_ASSORT_TYPE.assortment_type_descr, 'unknown') AS assortment_type_descr,
 COALESCE(ITEM_NAME.item_name, 'unknown') AS item_variant_name,
 ITEM_NAME.item_name_de AS item_variant_name_de,
 ITEM_NAME.item_name_en AS item_variant_name_en,
 ITEM_NAME.item_name_bg AS item_variant_name_bg,
 ITEM_NAME.item_name_cs AS item_variant_name_cs,
 ITEM_NAME.item_name_da AS item_variant_name_da,
 ITEM_NAME.item_name_el AS item_variant_name_el,
 ITEM_NAME.item_name_es AS item_variant_name_es,
 ITEM_NAME.item_name_fi AS item_variant_name_fi,
 ITEM_NAME.item_name_fr AS item_variant_name_fr,
 ITEM_NAME.item_name_hr AS item_variant_name_hr,
 ITEM_NAME.item_name_hu AS item_variant_name_hu,
 ITEM_NAME.item_name_it AS item_variant_name_it,
 ITEM_NAME.item_name_lt AS item_variant_name_lt,
 ITEM_NAME.item_name_nl AS item_variant_name_nl,
 ITEM_NAME.item_name_pl AS item_variant_name_pl,
 ITEM_NAME.item_name_pt AS item_variant_name_pt,
 ITEM_NAME.item_name_ro AS item_variant_name_ro,
 ITEM_NAME.item_name_sh AS item_variant_name_sh,
 ITEM_NAME.item_name_sk AS item_variant_name_sk,
 ITEM_NAME.item_name_sl AS item_variant_name_sl,
 ITEM_NAME.item_name_sv AS item_variant_name_sv,
 COALESCE(WAWI_MAIN_ITEM.item_sid, item_conf.item_sid, - core_item.client_id) AS main_item_sid,
  CASE
  WHEN COALESCE(WAWI_MAIN_ITEM.item_sid, item_conf.item_sid, - core_item.client_id) = - core_item.client_id
  THEN NULL
  ELSE TRIM(RTRIM(core_item.src_orig_item_nr, '.'))
  END AS main_item_nr,
  CASE
  WHEN COALESCE(WAWI_MAIN_ITEM.item_sid, item_conf.item_sid, - core_item.client_id) = - core_item.client_id
  THEN NULL
  ELSE COALESCE(WAWI_ITEM.dat_valid_from, core_item.src_dat_valid_from)
  END AS main_item_creation_dt,
 COALESCE(dim_brand.brand_sid, - core_item.client_id) AS brand_sid,
 COALESCE(WAWI_ITEM.brand, 'unknown') AS brand_name,
 WAWI_ITEM.buying_list_orderset_nr AS report_display_seq,
 COALESCE(dim_packing_type.packing_type_sid, - core_item.client_id) AS packing_type_sid,
 COALESCE(WAWI_ITEM.packing, 'unknown') AS packing_type_descr,
 COALESCE(logistic_unit.logistic_unit_desc, '@') AS logistic_unit_cd,
 COALESCE(logistic_unit.logistic_unit_desc, 'unknown') AS logistic_unit_descr,
  CASE
  WHEN dim_brand_type.brand_type_desc = 'Dummy-Markenart'
  THEN '@'
  ELSE dim_brand_type.brand_type_desc
  END AS brand_type_cd,
  CASE
  WHEN dim_brand_type.brand_type_desc = 'Dummy-Markenart'
  THEN 'unknown'
  WHEN dim_brand_type.brand_type_desc = 'M'
  THEN 'Marke'
  WHEN dim_brand_type.brand_type_desc = 'HM'
  THEN 'Handelsmarke'
  WHEN dim_brand_type.brand_type_desc = 'EM'
  THEN 'Eigenmarke'
  ELSE 'unknown'
  END AS brand_type_descr,
 BIL_FAMILY_GROUP.item_grp_int_sid,
 BIL_FAMILY_GROUP.item_grp_int_nr,
 BIL_FAMILY_GROUP.item_grp_int_name,
 BIL_FAMILY_GROUP.sub_item_grp_sid,
 BIL_FAMILY_GROUP.sub_item_grp_nr,
 BIL_FAMILY_GROUP.sub_item_grp_name,
 BIL_FAMILY_GROUP.item_fam_grp_sid,
 BIL_FAMILY_GROUP.item_fam_grp_nr,
 BIL_FAMILY_GROUP.item_fam_grp_name,
 BIL_FAMILY_GROUP.main_item_grp_sid,
 BIL_FAMILY_GROUP.main_item_grp_nr,
 BIL_FAMILY_GROUP.main_item_grp_name,
 WAWI_ITEM.dur_shelflife_day_cust AS min_consumption_day_cnt,
 WAWI_ITEM.dur_shelflife_day_store AS min_shelflife_to_store_day_cnt,
 WAWI_ITEM.dur_shelflife_day_wh AS min_shelflife_to_wh_day_cnt,
 WAWI_ITEM.weight_fg AS weight_based_item_fg,
 WAWI_ITEM.orig_item_nr_int AS ian_nr,
 WAWI_ITEM.item_plu_nr AS plu_nr
FROM (SELECT a.client_id,
   a.item_sid,
   a.src_matnr,
   a.src_orig_item_nr,
   a.src_dat_valid_from,
   a.config_item_cd,
   B.deleted_fg,
   B.item_fam_grp_sid
  FROM (SELECT client_id,
     item_sid,
     src_matnr,
     src_orig_item_nr,
     src_dat_valid_from,
     config_item_cd
    FROM ldl_p_lew_core_ac.v_item
    WHERE COALESCE(CAST(log_var_cd AS BIGNUMERIC), - 1) <> 1) AS a
   LEFT JOIN ldl_p_lew_core_ac.v_item_hist AS B ON a.client_id = B.client_id AND a.item_sid = B.item_sid AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to) AS core_item
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act AS WAWI_ITEM ON core_item.client_id = WAWI_ITEM.client_id AND core_item.item_sid = WAWI_ITEM.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_map_key AS WAWI_MAIN_ITEM ON core_item.client_id = WAWI_MAIN_ITEM.client_id AND WAWI_MAIN_ITEM.wawi_dwh_orig_item_nr = CAST(core_item.src_orig_item_nr AS FLOAT64) AND core_item.src_dat_valid_from = WAWI_MAIN_ITEM.wawi_dwh_dat_valid_from AND COALESCE(CAST(WAWI_MAIN_ITEM
      .dwh_log_var_id AS BIGNUMERIC), - 1) = 1 AND WAWI_MAIN_ITEM.client_id NOT IN (1, 21, 33, 34)
 LEFT JOIN (SELECT client_id,
   item_sid,
   src_matnr
  FROM ldl_p_lew_core_ac.v_item
  WHERE client_id IN (1, 21, 33, 34)
   AND CAST(log_var_cd AS FLOAT64) = 1) AS item_conf ON core_item.client_id = item_conf.client_id AND LTRIM(item_conf.src_matnr, '0') = core_item.src_orig_item_nr
 LEFT JOIN (SELECT client_id,
   MAX(brand_sid) AS brand_sid,
   brand_name
  FROM ldl_p_lew_core_ac.v_brand
  GROUP BY client_id,
   brand_name) AS dim_brand ON WAWI_ITEM.brand = dim_brand.brand_name AND WAWI_ITEM.client_id = dim_brand.client_id
 LEFT JOIN (SELECT client_id,
   MAX(packing_type_sid) AS packing_type_sid,
   packing_type_descr
  FROM ldl_p_lew_bil_ac.v_dim_packing_type
  GROUP BY client_id,
   packing_type_descr) AS dim_packing_type ON WAWI_ITEM.client_id = dim_packing_type.client_id AND WAWI_ITEM.packing = dim_packing_type.packing_type_descr
 LEFT JOIN (SELECT DISTINCT brand_type_id,
   brand_type_desc
  FROM ldl_p_lew_core_ac.v_wawi_ref_itm_list_type
  WHERE language_id = 23) AS dim_brand_type ON WAWI_ITEM.brand_type_id = dim_brand_type.brand_type_id
 LEFT JOIN ldl_p_lew_process.v_item_name AS ITEM_NAME ON core_item.client_id = ITEM_NAME.client_id AND core_item.item_sid = ITEM_NAME.item_sid
 LEFT JOIN (SELECT DISTINCT client_id,
   logistic_unit_cd,
   logistic_unit_desc
  FROM ldl_p_lew_core_ac.v_wawi_ref_itm_logist_unit) AS logistic_unit ON WAWI_ITEM.client_id = logistic_unit.client_id AND WAWI_ITEM.logistic_unit_cd = logistic_unit.logistic_unit_cd
 LEFT JOIN ldl_p_lew_process.v_assortment_type AS V_ASSORT_TYPE ON CAST(V_ASSORT_TYPE.assortment_type_cd AS FLOAT64) = WAWI_ITEM.listing_type_id
 LEFT JOIN ldl_p_lew_bil_ac.v_dim_item_family_group AS BIL_FAMILY_GROUP ON core_item.client_id = BIL_FAMILY_GROUP.client_id AND core_item.item_fam_grp_sid = BIL_FAMILY_GROUP.item_fam_grp_sid
WHERE core_item.src_matnr IS NULL;