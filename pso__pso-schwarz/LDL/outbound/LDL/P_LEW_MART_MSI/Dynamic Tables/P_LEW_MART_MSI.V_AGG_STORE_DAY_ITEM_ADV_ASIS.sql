CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_agg_store_day_item_adv_asis
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT A.client_id,
 WH.src_wh_id AS wh_id,
 A.st_loc_sid AS store_id,
 A.dat_adv,
 A.itemgroup_int_id,
 A.item_sid AS item_id,
 A.dat_formdate,
 A.qty_sales,
 A.qty_piece_ejr AS qty_piece_ejr_asis,
 A.qty_weight_ejr AS qty_weight_ejr_asis,
 A.qty_return_ejr AS qty_return_ejr_asis,
 A.qty_delivery,
 A.qty_stc_real
FROM ldl_p_lew_core_ac.v_wawi_agg_store_day_item_adv_asis AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON A.client_id = WH.client_id AND A.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1;