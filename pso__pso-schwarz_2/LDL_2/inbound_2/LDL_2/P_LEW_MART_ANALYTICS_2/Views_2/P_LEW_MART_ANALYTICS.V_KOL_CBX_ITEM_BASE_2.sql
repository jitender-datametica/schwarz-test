CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_KOL_CBX_ITEM_BASE_2
(
      client_id
    , client_id_order
    , client_cd
    , client_block_cd
    , item_ian
    , mdm_item_sid
    , mdm_item_name
    , cy_week_advertise
    , client_order_total_qty
    , item_sid
    , item_name
    , src_orig_item_nr
    , config_item_cd
    , src_matnr
    , range_plan_cd
    , range_advertise_from_dt
    , range_advertise_to_dt
    , pre_item_ian
    , pre_mdm_item_sid
    , pre_mdm_item_name
    , pre_range_plan_cd
    , pre_range_advertise_from_dt
    , pre_range_advertise_to_dt
    , dwh_updated
)
AS
   SELECT
         client_id,
   client_id_order,
   client_cd,
   client_block_cd,
   item_ian,
   mdm_item_sid,
   mdm_item_name,
   cy_week_advertise,
   client_order_total_qty,
   item_sid,
   item_name,
   src_orig_item_nr,
   config_item_cd,
   src_matnr,
   range_plan_cd,
   range_advertise_from_dt,
   range_advertise_to_dt,
   pre_item_ian,
   pre_mdm_item_sid,
   pre_mdm_item_name,
   pre_range_plan_cd,
   pre_range_advertise_from_dt,
   pre_range_advertise_to_dt,
   dwh_updated
  FROM p_lew_mart_analytics.t_kol_cbx_item_base_2
;