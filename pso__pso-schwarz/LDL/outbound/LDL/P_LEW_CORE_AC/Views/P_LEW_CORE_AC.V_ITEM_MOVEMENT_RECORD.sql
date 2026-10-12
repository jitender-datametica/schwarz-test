CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_movement_record (client_id, item_movement_record_year,
item_movement_record_id, doc_dt, event_type_cd, acct_rec_entry_tmsp, dwh_cal_dt, dwh_load_id, dwh_created, dwh_updated)
AS SELECT client_id,
 item_movement_record_year,
 item_movement_record_id,
 doc_dt,
 event_type_cd,
 acct_rec_entry_tmsp,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_movement_record;