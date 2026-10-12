CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_itm_wh_orderinformation AS
SELECT A.client_id,
 WH.src_wh_id AS wh_id,
 A.dat_rec_end,
 A.dat_rec_start,
 A.delivery_time,
 A.automatic_order_fg,
 A.best_before_fg,
 A.direct_delivery_fg,
 A.dispo_add_information,
 A.dispo_cd,
 A.dispo_group_id,
 A.dispo_period,
 A.dispo_unit_id,
 A.item_sid AS item_id,
 A.min_order_week,
 A.order_item_fg,
 A.pallet_note,
 A.weight,
 A.weight_fg,
 A.load_id
FROM ldl_p_lew_core_ac.v_wawi_itm_wh_orderinformation AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON A.client_id = WH.client_id AND A.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
WHERE CURRENT_DATE BETWEEN A.dat_rec_start AND A.dat_rec_end;