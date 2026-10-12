CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_1 AS SELECT ITEM.client_id,
 ITEM.item_sid,
 ITEM.src_matnr,
 ITEM.src_orig_item_nr,
 ITEM.src_dat_valid_from,
 ITEM.src_case_size,
 ITEM.item_name,
 ITEMH.item_fam_grp_sid,
 SITMGH_ASIS.sub_item_grp_sid AS sub_item_grp_sid_asis,
 SITMGH_ASIS.item_grp_int_sid AS item_grp_int_sid_asis,
 ITEMH.item_type_sid,
 ITEMH.item_grp_sid,
 ITEMH.pack_type_sid,
 ITEMH.uom_sid_base,
 ITEMH.uom_sid_sales,
 ITEMH.brand_sid,
 ITEMH.uom_cd_base,
 ITEMH.uom_cd_sales,
 ITEMH.gross_content_val,
 ITEMH.pack_cont_qty,
 ITEM.config_item_cd,
 ITEMH.state_bges_cd,
 ITEMH.hazardous_material_cd,
 ITEM.log_var_cd,
 ITEMH.pricing_ref_item_cd,
 ITEMH.uom_sid_packaging,
 ITEMH.uom_cd_packaging,
 ITEMH.deleted_fg,
 ITEMH.dwh_valid_from,
 ITEMH.dwh_valid_to,
  CASE
  WHEN CURRENT_DATE BETWEEN ITEMH.dwh_valid_from AND ITEMH.dwh_valid_to
  THEN 1
  ELSE 0
  END AS dwh_actual_fg,
  CASE
  WHEN ITEMH.deleted_fg = 0 AND CURRENT_DATE >= ITEM.src_dat_valid_from
  THEN 1
  ELSE 0
  END AS active_fg,
  CASE
  WHEN CURRENT_DATE < ITEM.src_dat_valid_from
  THEN 0
  ELSE 1
  END AS active_future_fg,
 ITEM.dwh_updated,
 ITEM.dwh_created,
 ITEM.dwh_load_id
FROM ldl_p_lew_core_ac.v_item_1 AS ITEM_1
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS ITEMH ON ITEM.client_id = ITEMH.client_id AND ITEM.item_sid = ITEMH.item_sid
   
 LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup_hist_1 AS ITMFGH_ASIS ON ITEMH.client_id = ITMFGH_ASIS.client_id AND ITEMH
    .item_fam_grp_sid = ITMFGH_ASIS.item_fam_grp_sid AND CURRENT_DATE BETWEEN ITMFGH_ASIS.dwh_valid_from AND ITMFGH_ASIS
   .dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_subitemgroup_hist_1 AS SITMGH_ASIS ON ITMFGH_ASIS.client_id = SITMGH_ASIS.client_id AND
    ITMFGH_ASIS.sub_item_grp_sid = SITMGH_ASIS.sub_item_grp_sid AND CURRENT_DATE BETWEEN SITMGH_ASIS.dwh_valid_from AND
   SITMGH_ASIS.dwh_valid_to;