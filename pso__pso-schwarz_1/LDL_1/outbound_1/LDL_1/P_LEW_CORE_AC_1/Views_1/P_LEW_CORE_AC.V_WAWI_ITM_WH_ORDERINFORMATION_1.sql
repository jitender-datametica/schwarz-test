CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_wh_orderinformation_1 (client_id, wh_loc_sid, item_sid, dat_rec_end,
dat_rec_start, dispo_unit_id, dispo_group_id, weight, weight_fg, delivery_time, min_order_week, order_item_fg, dispo_cd
, dispo_period, dispo_add_information, best_before_fg, pallet_note, automatic_order_fg, direct_delivery_fg, load_id) AS
SELECT client_id,
 wh_loc_sid,
 item_sid,
 dat_rec_end,
 dat_rec_start,
 dispo_unit_id,
 dispo_group_id,
 weight,
 weight_fg,
 delivery_time,
 min_order_week,
 order_item_fg,
 dispo_cd,
 dispo_period,
 dispo_add_information,
 best_before_fg,
 pallet_note,
 automatic_order_fg,
 direct_delivery_fg,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_wh_orderinformation_1;