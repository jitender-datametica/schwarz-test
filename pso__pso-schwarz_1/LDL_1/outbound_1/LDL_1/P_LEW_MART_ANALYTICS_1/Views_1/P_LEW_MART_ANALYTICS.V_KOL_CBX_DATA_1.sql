CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_kol_cbx_data_1 (client_id, client_id_order, client_cd, client_block_cd,
mdm_item_sid, item_ian, mdm_item_name, cbx_item_doc_status, src_familygrp_cd, sub_item_grp_cd, cy_week_advertise,
client_order_total_qty, src_style_uniqids_cd, set_multipack_fg, style_names, barcode, barcode_clean, size_name,
src_size_cd, item_cnt, pack_assort_type, src_pack_type_cd, pack_method, src_pack_method_cd, pack_list_name,
pack_list_carton_qty, pack_list_pos_pack_qty, ad_theme_cd, ad_theme_name, range_plan_cd, cy_week_range_advertise_from,
cy_week_range_advertise_to, range_advertise_from_dt, range_advertise_to_dt, sup_nr, sup_name, buyer_cd, dwh_updated) AS
/* COALESCE(collate(sku_var.barcode,''), collate(sku_nonvar.barcode,'')) */ -- pakme.pack_assort_type

-- pakme.src_pack_type_cd
 -- pakme.pack_method
 SELECT ITM.client_id,
 ICO.client_id_order,
 ICO.client_cd,
 CLBLK.client_block_cd,
 ITM.mdm_item_sid,
 ITM.item_ian,
 ITM.mdm_item_name,
 ITM_H.cbx_item_doc_status,
 ITM_FG.src_familygrp_cd,
 ITM_FGH.sub_item_grp_cd,
 ICO_H.cy_week_advertise,
 ICO_H.client_order_total_qty,
 ISET.src_style_uniqids_cd,
 ISET.set_multipack_fg,
 ISET_H.style_names,
 sku_var.barcode -- COALESCE(sku_var.barcode, sku_nonvar.barcode) AS barcode
,
 ROUND(CAST(TRIM(LTRIM(REGEXP_REPLACE(COLLATE(sku_var.barcode, ''), '[^0-9]', ''), '0')) AS BIGNUMERIC), 0) AS
 barcode_clean,
 sku_var.size_name -- COALESCE(sku_var.size_name, sku_nonvar.size_name) AS size_name
,
 sku_var.src_size_cd -- COALESCE(sku_var.src_size_cd, sku_nonvar.src_size_cd) AS src_size_cd
,
 icnt.item_cnt,
 MIC.mdm_item_composition_txt AS pack_assort_type,
 ITM_H.mdm_case_composition_cd AS src_pack_type_cd,
 MCC.mdm_case_composition_txt AS pack_method,
 PAKL.src_pack_method_cd,
 PAKL.pack_list_name,
 PAKL.pack_list_carton_qty,
 PAKL_PH.pack_list_pos_pack_qty,
 ADVT.ad_theme_cd,
 ADVT.ad_theme_name,
 RANGSEL.range_plan_cd,
 RANGSEL_H.cy_week_range_advertise_from,
 RANGSEL_H.cy_week_range_advertise_to,
 RANGCAL_FROM.cal_dt AS range_advertise_from_dt,
 RANGCAL_TO.cal_dt AS range_advertise_to_dt,
 SUPLY.sup_nr,
 SUPLY.sup_name,
 BUYER.buyer_cd,
 ITM_H.dwh_updated
FROM ldl_p_lew_core_ac.v_mdm_item_1 AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_mdm_item_hist_1 AS ITM_H ON ITM.client_id = ITM_H.client_id AND ITM.mdm_item_sid = ITM_H.mdm_item_sid
      AND ITM_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN ITM_H.dwh_valid_from AND ITM_H.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_item_client_order_1 AS ICO ON ITM.client_id = ICO.client_id AND ITM.mdm_item_sid = ICO
   .mdm_item_sid
 INNER JOIN ldl_p_lew_core_ac.v_mdm_item_client_order_hist_1 AS ICO_H ON ICO.mdm_item_sid = ICO_H.mdm_item_sid AND ICO.client_id_order
      = ICO_H.client_id_order AND ICO_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN ICO_H.dwh_valid_from AND ICO_H.dwh_valid_to
   
 LEFT JOIN ldl_p_lew_core_ac.v_client_block_1 AS CLBLK ON ICO.client_block_id_order = CLBLK.client_block_id
 LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup_1 AS ITM_FG ON ITM_H.client_id = ITM_FG.client_id AND ITM_H.item_fam_grp_sid
    = ITM_FG.item_fam_grp_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist_1 AS ITM_FGH ON ITM_FG.client_id = ITM_FGH.client_id AND ITM_FG.item_fam_grp_sid
      = ITM_FGH.item_fam_grp_sid AND ITM_FGH.deleted_fg = 0 AND CURRENT_DATE BETWEEN ITM_FGH.dwh_valid_from AND ITM_FGH
   .dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_item_set_1 AS ISET ON ITM.client_id = ISET.client_id AND ITM.mdm_item_sid = ISET.mdm_item_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_mdm_item_set_hist_1 AS ISET_H ON ISET.client_id = ISET_H.client_id AND ISET.mdm_item_set_sid
      = ISET_H.mdm_item_set_sid AND ISET_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN ISET_H.dwh_valid_from AND ISET_H.dwh_valid_to
   
 LEFT JOIN (SELECT SKU.client_id,
   VAR_CH.client_id_recipient,
   VAR.mdm_item_sid,
   SKU.mdm_item_set_sid,
   SKU.mdm_item_sku_sid,
   SKU.mdm_item_size_sid,
   SKU_EH.barcode,
   ISIZE.size_name,
   ISIZE.src_size_cd
  FROM ldl_p_lew_core_ac.v_mdm_item_sku_1 AS SKU
   INNER JOIN ldl_p_lew_core_ac.v_mdm_item_variant_1 AS VAR ON SKU.client_id = VAR.client_id AND SKU.mdm_item_variant_sid
      = VAR.mdm_item_variant_sid AND SKU.mdm_item_sid = VAR.mdm_item_sid
   INNER JOIN ldl_p_lew_core_ac.v_mdm_item_variant_client_hist_1 AS VAR_CH ON SKU.client_id = VAR_CH.client_id AND VAR.mdm_item_variant_sid
        = VAR_CH.mdm_item_variant_sid AND VAR_CH.deleted_fg = 0 AND CURRENT_DATE BETWEEN VAR_CH.dwh_valid_from AND
     VAR_CH.dwh_valid_to
   LEFT JOIN ldl_p_lew_core_ac.v_mdm_item_sku_ean_hist_1 AS SKU_EH ON SKU.client_id = SKU_EH.client_id AND SKU.mdm_item_sku_sid
        = SKU_EH.mdm_item_sku_sid AND SKU_EH.deleted_fg = 0 AND CURRENT_DATE BETWEEN SKU_EH.dwh_valid_from AND SKU_EH.dwh_valid_to
     
   LEFT JOIN ldl_p_lew_core_ac.v_mdm_item_size_1 AS ISIZE ON SKU.client_id = ISIZE.client_id AND SKU.mdm_item_size_sid =
      ISIZE.mdm_item_size_sid AND SKU.mdm_item_sid = ISIZE.mdm_item_sid
  WHERE SKU.src_variant_cd <> '@'
   AND SKU_EH.barcode IS NOT NULL) AS sku_var ON ITM.client_id = sku_var.client_id AND ICO.client_id_order = sku_var.client_id_recipient
     AND ISET_H.mdm_item_set_sid
   /* LEFT JOIN
   (
       SELECT
             sku.client_id
   , var.mdm_item_sid
   , sku.mdm_item_set_sid
   , sku.mdm_item_sku_sid
   , sku.mdm_item_size_sid
   , sku_elh.barcode
   , isize.size_name
   , isize.src_size_cd
      FROM LDL.p_lew_core_ac.v_mdm_item_sku_1 AS sku
   INNER JOIN LDL.p_lew_core_ac.v_mdm_item_variant_1 AS var
   ON var.client_id = sku.client_id
   AND var.mdm_item_variant_sid = sku.mdm_item_variant_sid
   AND var.mdm_item_sid = sku.mdm_item_sid
   LEFT JOIN LDL.p_lew_core_ac.v_mdm_item_sku_ean_list_hist AS sku_elh
   ON sku_elh.client_id = sku.client_id
   AND sku_elh.mdm_item_sku_sid = sku.mdm_item_sku_sid
   AND sku_elh.deleted_fg = 0
   AND CURRENT_DATE BETWEEN sku_elh.dwh_valid_from AND sku_elh.dwh_valid_to
   LEFT JOIN LDL.p_lew_core_ac.v_mdm_item_size_1 AS isize
   ON isize.client_id = sku.client_id
   AND isize.mdm_item_size_sid = sku.mdm_item_size_sid
   AND isize.mdm_item_sid = sku.mdm_item_sid
   WHERE sku.src_variant_cd = '@'
   AND sku_elh.barcode IS NOT NULL
) AS sku_nonvar
   ON sku_nonvar.client_id = itm.client_id
   AND sku_nonvar.mdm_item_set_sid = iset_h.mdm_item_set_sid */
   = sku_var.mdm_item_set_sid
 LEFT JOIN (SELECT client_id,
   mdm_item_sid,
   COUNT(*) AS item_cnt
  FROM ldl_p_lew_core_ac.v_mdm_item_set_1
  GROUP BY client_id,
   mdm_item_sid) AS icnt ON ITM.client_id = icnt.client_id AND ITM.mdm_item_sid
   /* LEFT JOIN LDL.p_lew_core_ac.v_mdm_packing_method AS pakme
   ON pakme.client_id = itm_h.client_id
   AND pakme.pack_method_sid = itm_h.pack_method_sid */
   -- select packing method information
 = icnt.mdm_item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_ref_mdm_item_composition_1 AS MIC ON ITM_H.mdm_item_composition_cd = MIC.mdm_item_composition_cd
  
 LEFT JOIN ldl_p_lew_core_ac.v_ref_mdm_case_composition_1 AS MCC ON ITM_H.mdm_case_composition_cd = MCC.mdm_case_composition_cd
  
 LEFT JOIN ldl_p_lew_mart_analytics.v_kol_cbx_packing_list_1 AS PAKL ON ITM.client_id = PAKL.client_id AND ITM.mdm_item_sid
     = PAKL.mdm_item_sid AND ICO.client_id_order = PAKL.client_id_recipient
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_item_packing_list_pos_hist_1 AS PAKL_PH ON PAKL.client_id = PAKL_PH.client_id AND PAKL
       .mdm_pack_list_sid = PAKL_PH.mdm_pack_list_sid AND ISET_H.mdm_item_set_sid = PAKL_PH.mdm_item_set_sid AND sku_var
     .mdm_item_size_sid -- COALESCE(sku_var.mdm_item_size_sid, sku_nonvar.mdm_item_size_sid)
 = PAKL_PH.mdm_item_size_sid
      AND PAKL_PH.deleted_fg = 0 AND CURRENT_DATE BETWEEN PAKL_PH.dwh_valid_from AND PAKL_PH.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_ad_theme_item_hist_1 AS ITM_AD ON ITM.client_id = ITM_AD.client_id AND ITM.mdm_item_sid
      = ITM_AD.mdm_item_sid AND ITM_AD.deleted_fg = 0 AND CURRENT_DATE BETWEEN ITM_AD.dwh_valid_from AND ITM_AD.dwh_valid_to
   
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_advertise_theme_1 AS ADVT ON ITM_AD.client_id = ADVT.client_id AND ITM_AD.mdm_ad_theme_sid
    = ADVT.mdm_ad_theme_sid
 INNER JOIN ldl_p_lew_core_ac.v_mdm_advertise_theme_hist_1 AS ADVT_H ON ADVT.client_id = ADVT_H.client_id AND ADVT.mdm_ad_theme_sid
      = ADVT_H.mdm_ad_theme_sid AND ADVT_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN ADVT_H.dwh_valid_from AND ADVT_H.dwh_valid_to
   
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_range_selection_1 AS RANGSEL ON ADVT_H.client_id = RANGSEL.client_id AND ADVT_H.mdm_range_sel_sid
    = RANGSEL.mdm_range_sel_sid
 INNER JOIN ldl_p_lew_core_ac.v_mdm_range_selection_hist_1 AS RANGSEL_H ON RANGSEL.client_id = RANGSEL_H.client_id AND
     RANGSEL.mdm_range_sel_sid = RANGSEL_H.mdm_range_sel_sid AND RANGSEL_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN
   RANGSEL_H.dwh_valid_from AND RANGSEL_H.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS RANGCAL_FROM ON RANGSEL_H.cy_week_range_advertise_from = RANGCAL_FROM
   .cy_week AND RANGCAL_FROM.day_of_week = 1
 LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS RANGCAL_TO ON RANGSEL_H.cy_week_range_advertise_to = RANGCAL_TO.cy_week
    AND RANGCAL_TO.day_of_week = 7
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_supplier_1 AS SUPLY ON ITM_H.client_id = SUPLY.client_id AND ITM_H.mdm_sup_sid = SUPLY
   .mdm_sup_sid
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_item_buyer_role_hist_1 AS BUYER_H ON ITM.client_id = BUYER_H.client_id AND ITM.mdm_item_sid
       = BUYER_H.mdm_item_sid AND BUYER_H.role_type_cd = 'EKL' AND BUYER_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN
   BUYER_H.dwh_valid_from AND BUYER_H.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_buyer_1 AS BUYER ON BUYER_H.client_id = BUYER.client_id AND BUYER_H.buyer_sid = BUYER.buyer_sid;