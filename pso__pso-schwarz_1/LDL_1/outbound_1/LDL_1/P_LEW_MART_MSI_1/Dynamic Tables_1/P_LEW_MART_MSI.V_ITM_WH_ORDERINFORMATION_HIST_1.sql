CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_itm_wh_orderinformation_hist_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
/* Gesellschaft */ SELECT O.client_id,
 WH.src_wh_id AS wh_id,
 O.item_sid AS item_id,
 O.dat_rec_end,
 O.dat_rec_start,
 O.dispo_unit_id,
 O.dispo_group_id,
 O.weight,
 O.weight_fg,
 O.delivery_time,
 O.min_order_week,
 O.order_item_fg,
 O.dispo_cd,
 O.dispo_period,
 O.dispo_add_information,
 O.best_before_fg,
 O.pallet_note,
 O.automatic_order_fg,
 O.direct_delivery_fg,
 O.load_id
FROM ldl_p_lew_core_ac.v_wawi_itm_wh_orderinformation_1 AS O
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON O.client_id = WH.client_id AND O.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1;