CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_storevat_sveh_processed_2 AS SELECT client_id,
 loc_sid_store,
 vat_exception,
 item_sid,
 vat_pct,
 dwh_valid_from,
 dwh_valid_to,
 dwh_created
FROM ldl_p_lew_process.t_storevat_sveh_processed_2;