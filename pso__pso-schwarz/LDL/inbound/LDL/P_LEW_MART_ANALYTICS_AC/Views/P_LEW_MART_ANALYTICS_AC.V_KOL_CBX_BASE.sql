CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_KOL_CBX_BASE
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
    , barcode
    , barcode_clean
    , src_style_uniqids_cd
    , style_names
    , size_name
    , src_size_cd
    , set_multipack_fg
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
    , range_advertise_from_dt
    , range_advertise_to_dt
    , sup_nr
    , sup_name
    , buyer_cd
    , dwh_updated
    , pack_list_calc_qty
    , sort_val
    , sort_ean_size_val
    , sort_ean_style_val
    , proportion_ean_size_qty
    , proportion_ean_style_qty
    , ean_equals_ian_fg
    , pack_list_carton_equals_calc_fg
)
AS
   SELECT
         client_id,
   client_id_order,
   client_cd,
   client_block_cd,
   mdm_item_sid,
   item_ian,
   mdm_item_name,
   cbx_item_doc_status,
   src_familygrp_cd,
   sub_item_grp_cd,
   cy_week_advertise,
   client_order_total_qty,
   barcode,
   barcode_clean,
   src_style_uniqids_cd,
   style_names,
   size_name,
   src_size_cd,
   set_multipack_fg,
   item_cnt,
   pack_assort_type,
   src_pack_type_cd,
   pack_method,
   src_pack_method_cd,
   pack_list_name,
   pack_list_carton_qty,
   pack_list_pos_pack_qty,
   ad_theme_cd,
   ad_theme_name,
   range_plan_cd,
   range_advertise_from_dt,
   range_advertise_to_dt,
   sup_nr,
   sup_name,
   buyer_cd,
   dwh_updated,
   pack_list_calc_qty,
   sort_val,
   sort_ean_size_val,
   sort_ean_style_val,
   proportion_ean_size_qty,
   proportion_ean_style_qty,
   ean_equals_ian_fg,
   pack_list_carton_equals_calc_fg
  FROM p_lew_mart_analytics.t_kol_cbx_base
;