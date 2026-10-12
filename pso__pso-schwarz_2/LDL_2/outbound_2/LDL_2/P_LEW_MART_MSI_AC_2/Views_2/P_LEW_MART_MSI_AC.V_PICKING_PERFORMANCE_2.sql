/* #DescStart#
#$Revision: 12961 $, $LastChangedBy: umeister $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_picking_performance_2 (client_id, wh_id, picking_receipt_nr,
performance_type_cd, performance_cd, picking_area_nr_pp, dat_performance, timestamp_performance, means_of_transport_id,
performance_grp, qty_sum_target_time, qty_sum_working_time, qty_sum_lead_time, qty_sum_lag_time, qty_sum_extra_time,
qty_sum_break_time, cnt_days, cnt_hours, cnt_staff, cnt_order, cnt_te, cnt_pick_position, cnt_pick_case,
qty_sum_gross_weight, qty_sum_net_weight, qty_sum_break, cnt_pick_te, cnt_target_case, cnt_pick_handhe,
cnt_pick_entry_thm, cnt_pick_orig_thm, load_id) AS SELECT *
FROM ldl_p_lew_mart_msi.v_picking_performance_2;