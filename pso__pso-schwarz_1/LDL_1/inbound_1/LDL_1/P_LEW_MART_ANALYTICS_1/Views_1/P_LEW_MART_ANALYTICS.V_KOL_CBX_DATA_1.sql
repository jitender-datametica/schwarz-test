CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_KOL_CBX_DATA_1
(
      client_id
    , client_id_order
    , client_cd
    , client_block_cd
    , mdm_item_sid
    , item_ian
    , mdm_item_name
    , cbx_item_doc_status
    , src_familygrp_cd
    , sub_item_grp_cd
    , cy_week_advertise
    , client_order_total_qty
    , src_style_uniqids_cd
    , set_multipack_fg
    , style_names
    , barcode
    , barcode_clean
    , size_name
    , src_size_cd
    , item_cnt
    , pack_assort_type
    , src_pack_type_cd
    , pack_method
    , src_pack_method_cd
    , pack_list_name
    , pack_list_carton_qty
    , pack_list_pos_pack_qty
    , ad_theme_cd
    , ad_theme_name
    , range_plan_cd
    , cy_week_range_advertise_from
    , cy_week_range_advertise_to
    , range_advertise_from_dt
    , range_advertise_to_dt
    , sup_nr
    , sup_name
    , buyer_cd
    , dwh_updated
)
AS
   SELECT
         itm.client_id
   , ico.client_id_order
   , ico.client_cd
   , clblk.client_block_cd
   , itm.mdm_item_sid
   , itm.item_ian
   , itm.mdm_item_name
   , itm_h.cbx_item_doc_status
   , itm_fg.src_familygrp_cd
   , itm_fgh.sub_item_grp_cd
   , ico_h.cy_week_advertise
   , ico_h.client_order_total_qty
   , iset.src_style_uniqids_cd
   , iset.set_multipack_fg
   , iset_h.style_names
   , sku_var.barcode  --COALESCE(sku_var.barcode, sku_nonvar.barcode) AS barcode
   , TO_NUMBER(TRIM(LTRIM(RegExp_Replace(collate(sku_var.barcode,'') /*COALESCE(collate(sku_var.barcode,''), collate(sku_nonvar.barcode,''))*/, '[^0-9]', ''),'0'))) AS barcode_clean
   , sku_var.size_name --COALESCE(sku_var.size_name, sku_nonvar.size_name) AS size_name
   , sku_var.src_size_cd --COALESCE(sku_var.src_size_cd, sku_nonvar.src_size_cd) AS src_size_cd
   , icnt.item_cnt
   , mic.mdm_item_composition_txt AS pack_assort_type --pakme.pack_assort_type
   , itm_h.mdm_case_composition_cd AS src_pack_type_cd --pakme.src_pack_type_cd
   , mcc.mdm_case_composition_txt AS pack_method --pakme.pack_method
   , pakl.src_pack_method_cd
   , pakl.pack_list_name
   , pakl.pack_list_carton_qty
   , pakl_ph.pack_list_pos_pack_qty
   , advt.ad_theme_cd
   , advt.ad_theme_name
   , rangsel.range_plan_cd
   , rangsel_h.cy_week_range_advertise_from
   , rangsel_h.cy_week_range_advertise_to
   , rangcal_from.cal_dt AS range_advertise_from_dt
   , rangcal_to.cal_dt AS range_advertise_to_dt
   , suply.sup_nr
   , suply.sup_name
   , buyer.buyer_cd
   , itm_h.dwh_updated

  FROM p_lew_core_ac.v_mdm_item_1 AS itm
   INNER JOIN p_lew_core_ac.v_mdm_item_hist_1 AS itm_h
   ON itm_h.client_id = itm.client_id
   AND itm_h.mdm_item_sid = itm.mdm_item_sid
   AND itm_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN itm_h.dwh_valid_from AND itm_h.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_item_client_order_1 AS ico
   ON ico.client_id = itm.client_id
   AND ico.mdm_item_sid = itm.mdm_item_sid
   INNER JOIN p_lew_core_ac.v_mdm_item_client_order_hist_1 AS ico_h
   ON ico_h.mdm_item_sid = ico.mdm_item_sid
   AND ico_h.client_id_order = ico.client_id_order
   AND ico_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN ico_h.dwh_valid_from AND ico_h.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_client_block_1 AS clblk
   ON clblk.client_block_id = ico.client_block_id_order
   LEFT JOIN p_lew_core_ac.v_item_familygroup_1 AS itm_fg
   ON itm_fg.client_id = itm_h.client_id
   AND itm_fg.item_fam_grp_sid = itm_h.item_fam_grp_sid
   INNER JOIN p_lew_core_ac.v_item_familygroup_hist_1 AS itm_fgh
   ON itm_fgh.client_id = itm_fg.client_id
   AND itm_fgh.item_fam_grp_sid = itm_fg.item_fam_grp_sid
   AND itm_fgh.deleted_fg = 0
   AND CURRENT_DATE BETWEEN itm_fgh.dwh_valid_from AND itm_fgh.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_item_set_1 AS iset
   ON iset.client_id = itm.client_id
   AND iset.mdm_item_sid = itm.mdm_item_sid
   INNER JOIN p_lew_core_ac.v_mdm_item_set_hist_1 AS iset_h
   ON iset_h.client_id = iset.client_id
   AND iset_h.mdm_item_set_sid = iset.mdm_item_set_sid
   AND iset_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN iset_h.dwh_valid_from AND iset_h.dwh_valid_to
   LEFT JOIN
   (
       SELECT
             sku.client_id
   , var_ch.client_id_recipient
   , var.mdm_item_sid
   , sku.mdm_item_set_sid
   , sku.mdm_item_sku_sid
   , sku.mdm_item_size_sid
   , sku_eh.barcode
   , isize.size_name
   , isize.src_size_cd
      FROM p_lew_core_ac.v_mdm_item_sku_1 AS sku
   INNER JOIN p_lew_core_ac.v_mdm_item_variant_1 AS var
   ON var.client_id = sku.client_id
   AND var.mdm_item_variant_sid = sku.mdm_item_variant_sid
   AND var.mdm_item_sid = sku.mdm_item_sid
   INNER JOIN p_lew_core_ac.v_mdm_item_variant_client_hist_1 AS var_ch
   ON var_ch.client_id = sku.client_id
   AND var_ch.mdm_item_variant_sid = var.mdm_item_variant_sid
   AND var_ch.deleted_fg = 0
   AND CURRENT_DATE BETWEEN var_ch.dwh_valid_from AND var_ch.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_item_sku_ean_hist_1 AS sku_eh
   ON sku_eh.client_id = sku.client_id
   AND sku_eh.mdm_item_sku_sid = sku.mdm_item_sku_sid
   AND sku_eh.deleted_fg = 0
   AND CURRENT_DATE BETWEEN sku_eh.dwh_valid_from AND sku_eh.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_item_size_1 AS isize
   ON isize.client_id = sku.client_id
   AND isize.mdm_item_size_sid = sku.mdm_item_size_sid
   AND isize.mdm_item_sid = sku.mdm_item_sid
   WHERE sku.src_variant_cd <> '@'
   AND sku_eh.barcode IS NOT NULL
) AS sku_var
   ON sku_var.client_id = itm.client_id
   AND sku_var.client_id_recipient = ico.client_id_order
   AND sku_var.mdm_item_set_sid = iset_h.mdm_item_set_sid
/*
   LEFT JOIN
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
      FROM p_lew_core_ac.v_mdm_item_sku_1 AS sku
   INNER JOIN p_lew_core_ac.v_mdm_item_variant_1 AS var
   ON var.client_id = sku.client_id
   AND var.mdm_item_variant_sid = sku.mdm_item_variant_sid
   AND var.mdm_item_sid = sku.mdm_item_sid
   LEFT JOIN p_lew_core_ac.v_mdm_item_sku_ean_list_hist AS sku_elh
   ON sku_elh.client_id = sku.client_id
   AND sku_elh.mdm_item_sku_sid = sku.mdm_item_sku_sid
   AND sku_elh.deleted_fg = 0
   AND CURRENT_DATE BETWEEN sku_elh.dwh_valid_from AND sku_elh.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_item_size_1 AS isize
   ON isize.client_id = sku.client_id
   AND isize.mdm_item_size_sid = sku.mdm_item_size_sid
   AND isize.mdm_item_sid = sku.mdm_item_sid
   WHERE sku.src_variant_cd = '@'
   AND sku_elh.barcode IS NOT NULL
) AS sku_nonvar
   ON sku_nonvar.client_id = itm.client_id
   AND sku_nonvar.mdm_item_set_sid = iset_h.mdm_item_set_sid
*/   LEFT JOIN
   (
       SELECT
             client_id
   ,mdm_item_sid
   ,COUNT(*) AS item_cnt
      FROM p_lew_core_ac.v_mdm_item_set_1
      GROUP BY 1,2
  ) AS icnt
   ON icnt.client_id = itm.client_id
   AND icnt.mdm_item_sid = itm.mdm_item_sid
/*
   LEFT JOIN p_lew_core_ac.v_mdm_packing_method AS pakme
   ON pakme.client_id = itm_h.client_id
   AND pakme.pack_method_sid = itm_h.pack_method_sid
*/
-- select packing method information

   LEFT OUTER JOIN p_lew_core_ac.v_ref_mdm_item_composition_1 AS mic
     ON mic.mdm_item_composition_cd=itm_h.mdm_item_composition_cd
	 
   LEFT OUTER JOIN p_lew_core_ac.v_ref_mdm_case_composition_1 AS mcc
     ON mcc.mdm_case_composition_cd=itm_h.mdm_case_composition_cd
	 
	 
   LEFT JOIN p_lew_mart_analytics.v_kol_cbx_packing_list_1 AS pakl
   ON pakl.client_id = itm.client_id
   AND pakl.mdm_item_sid = itm.mdm_item_sid
   AND pakl.client_id_recipient = ico.client_id_order
   LEFT JOIN p_lew_core_ac.v_mdm_item_packing_list_pos_hist_1 AS pakl_ph
   ON pakl_ph.client_id = pakl.client_id
   AND pakl_ph.mdm_pack_list_sid = pakl.mdm_pack_list_sid
   AND pakl_ph.mdm_item_set_sid = iset_h.mdm_item_set_sid
   AND pakl_ph.mdm_item_size_sid = sku_var.mdm_item_size_sid --COALESCE(sku_var.mdm_item_size_sid, sku_nonvar.mdm_item_size_sid)
   AND pakl_ph.deleted_fg = 0
   AND CURRENT_DATE BETWEEN pakl_ph.dwh_valid_from AND pakl_ph.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_ad_theme_item_hist_1 AS itm_ad
   ON itm_ad.client_id = itm.client_id
   AND itm_ad.mdm_item_sid = itm.mdm_item_sid
   AND itm_ad.deleted_fg = 0
   AND CURRENT_DATE BETWEEN itm_ad.dwh_valid_from AND itm_ad.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_advertise_theme_1 AS advt
   ON advt.client_id = itm_ad.client_id
   AND advt.mdm_ad_theme_sid = itm_ad.mdm_ad_theme_sid
   INNER JOIN p_lew_core_ac.v_mdm_advertise_theme_hist_1 AS advt_h
   ON advt_h.client_id = advt.client_id
   AND advt_h.mdm_ad_theme_sid = advt.mdm_ad_theme_sid
   AND advt_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN advt_h.dwh_valid_from AND advt_h.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_range_selection_1 AS rangsel
   ON rangsel.client_id = advt_h.client_id
   AND rangsel.mdm_range_sel_sid = advt_h.mdm_range_sel_sid
   INNER JOIN p_lew_core_ac.v_mdm_range_selection_hist_1 AS rangsel_h
   ON rangsel_h.client_id = rangsel.client_id
   AND rangsel_h.mdm_range_sel_sid = rangsel.mdm_range_sel_sid
   AND rangsel_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN rangsel_h.dwh_valid_from AND rangsel_h.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_cal_calendarday_1 AS rangcal_from
   ON rangcal_from.cy_week = rangsel_h.cy_week_range_advertise_from
   AND rangcal_from.day_of_week = 1
   LEFT JOIN p_lew_core_ac.v_cal_calendarday_1 AS rangcal_to
   ON rangcal_to.cy_week = rangsel_h.cy_week_range_advertise_to
   AND rangcal_to.day_of_week = 7
   LEFT JOIN p_lew_core_ac.v_mdm_supplier_1 AS suply
   ON suply.client_id = itm_h.client_id
   AND suply.mdm_sup_sid = itm_h.mdm_sup_sid
   LEFT JOIN p_lew_core_ac.v_mdm_item_buyer_role_hist_1 AS buyer_h
   ON buyer_h.client_id = itm.client_id
   AND buyer_h.mdm_item_sid = itm.mdm_item_sid
   AND buyer_h.role_type_cd = 'EKL'
   AND buyer_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN buyer_h.dwh_valid_from AND buyer_h.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_buyer_1 AS buyer
   ON buyer.client_id = buyer_h.client_id
   AND buyer.buyer_sid = buyer_h.buyer_sid
   ;