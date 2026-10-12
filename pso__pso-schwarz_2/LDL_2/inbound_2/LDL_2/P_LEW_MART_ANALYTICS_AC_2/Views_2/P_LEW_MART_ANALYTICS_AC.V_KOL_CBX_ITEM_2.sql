CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_KOL_CBX_ITEM_2
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
    , cy_week_range_advertise_from
    , cy_week_range_advertise_to
    , range_advertise_from_dt
    , range_advertise_to_dt
    , pre_item_ian
    , pre_mdm_item_sid
    , pre_mdm_item_name
    , pre_range_plan_cd
    , pre_cy_week_range_advertise_from
    , pre_cy_week_range_advertise_to
    , pre_range_advertise_from_dt
    , pre_range_advertise_to_dt
    , dwh_updated
)
AS
   SELECT
         cbx_itm.client_id,
   cbx_itm.client_id_order,
   cbx_itm.client_cd,
   cbx_itm.client_block_cd,
   cbx_itm.item_ian,
   cbx_itm.mdm_item_sid,
   cbx_itm.mdm_item_name,
   cbx_itm.cy_week_advertise,
   cbx_itm.client_order_total_qty,
   cbx_itm.item_sid,
   cbx_itm.item_name,
   cbx_itm.src_orig_item_nr,
   cbx_itm.config_item_cd,
   cbx_itm.src_matnr,
   cbx_itm.range_plan_cd,
   cbx_itm.cy_week_range_advertise_from,
   cbx_itm.cy_week_range_advertise_to,
   cbx_itm.range_advertise_from_dt,
   cbx_itm.range_advertise_to_dt,
   cbx_itm.pre_item_ian,
   cbx_itm.pre_mdm_item_sid,
   cbx_itm.pre_mdm_item_name,
   cbx_itm.pre_range_plan_cd,
   cbx_itm.pre_cy_week_range_advertise_from,
   cbx_itm.pre_cy_week_range_advertise_to,
   cbx_itm.pre_range_advertise_from_dt,
   cbx_itm.pre_range_advertise_to_dt,
   cbx_itm.dwh_updated
  FROM p_lew_mart_analytics.v_kol_cbx_item_2 AS cbx_itm
;