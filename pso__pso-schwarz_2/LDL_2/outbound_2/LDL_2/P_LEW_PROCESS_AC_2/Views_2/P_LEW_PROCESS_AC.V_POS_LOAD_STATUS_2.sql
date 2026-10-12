CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_pos_load_status_2 (client_id, loc_sid, global_loc_id, receipt_dt,
receipts_transfered_tmsp, cntlr_transfered_tmsp, source_deleted_tmsp, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 loc_sid,
 global_loc_id,
 receipt_dt,
 receipts_transfered_tmsp,
 cntlr_transfered_tmsp,
 source_deleted_tmsp,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process.t_pos_load_status_2;