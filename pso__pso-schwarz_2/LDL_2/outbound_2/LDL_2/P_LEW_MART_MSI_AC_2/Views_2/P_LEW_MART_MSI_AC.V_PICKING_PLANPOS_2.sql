/* #DescStart#
#$Revision: 12961 $, $LastChangedBy: umeister $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_picking_planpos_2 (client_id, wh_id, picking_receipt_nr,
picking_receipt_index_nr, picking_sequence, picking_area_nr_pp, origin_picking_receipt_nr, origin_planning_pos_index,
order_nr, planning_status, planning_hoststatus, planning_pos_nr, performance_statistic_cd, material_item_nr,
item_desc_pp, position_field, position_storage_rack, position_aisle_nr, position_column_nr, position_level_nr,
protocol_nr, thm_cd, thm_fg, primary_thm_fg, target_pos_nr, picking_mode, means_of_transport_id, dat_picking_start,
timestamp_picking_start, timestamp_picking_end, timestamp_picking_lead, timestamp_picking_lag, case_unit, eve_unit,
le2_unit, le3_unit, te_unit, qty_empties_actual_he, qty_origin_target, qty_target, qty_actual, qty_booking,
qty_origin_target_weight, qty_target_weight, qty_actual_weight, qty_booking_weight, origin_target_eve_he_factor,
target_eve_he_factor, actual_eve_he_factor, booking_eve_he_factor, origin_target_he_le2_factor, target_he_le2_factor,
actual_he_le2_factor, booking_he_le2_factor, origin_target_he_le3_factor, target_he_le3_factor, actual_he_le3_factor,
booking_he_le3_factor, origin_target_he_te_factor, target_he_te_factor, actual_he_te_factor, booking_he_te_factor,
avg_weight_eve, target_te_id, qty_target_te, target_time, lead_time, lag_time, break_time, cnt_break, dat_dayend,
load_id) AS SELECT *
FROM ldl_p_lew_mart_msi.v_picking_planpos_2;