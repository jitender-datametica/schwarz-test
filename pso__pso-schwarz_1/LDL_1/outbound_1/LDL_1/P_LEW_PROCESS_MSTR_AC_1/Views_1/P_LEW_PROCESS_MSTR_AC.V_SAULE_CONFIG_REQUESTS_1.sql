CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_saule_config_requests_1 (req_id, status_id, req_date, requestor,
approver, status_desc) AS SELECT req_id,
 status_id,
 req_date,
 requestor,
 approver,
 status_desc
FROM ldl_p_lew_process_mstr.t_saule_config_requests_1;