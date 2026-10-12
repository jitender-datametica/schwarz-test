CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_price_label_display_assignment_2 (price_label_sid, price_label_event_type_cd,
price_label_event_display_type_cd, item_sid, event_grp_nr, prev_event_grp_nr, event_tmsp, next_event_tmsp, dwh_load_id,
dwh_created, dwh_updated) AS SELECT price_label_sid,
 price_label_event_type_cd,
 price_label_event_display_type_cd,
 item_sid,
 event_grp_nr,
 prev_event_grp_nr,
 event_tmsp,
 next_event_tmsp,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_price_label_display_assignment_2;