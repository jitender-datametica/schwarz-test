CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_complaint_case_related_hist_1 (client_id, cust_complaint_sid,
cust_complaint_rel_type_cd, cust_complaint_sid_related, deleted_fg, main_cust_complaint_status_cd, dwh_valid_from,
dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 cust_complaint_sid,
 cust_complaint_rel_type_cd,
 cust_complaint_sid_related,
 deleted_fg,
 main_cust_complaint_status_cd,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_complaint_case_related_hist_1;