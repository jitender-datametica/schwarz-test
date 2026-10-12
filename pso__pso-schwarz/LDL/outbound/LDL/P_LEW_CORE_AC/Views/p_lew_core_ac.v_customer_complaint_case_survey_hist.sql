CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_complaint_case_survey_hist (client_id, cust_complaint_sid,
cust_complaint_survey_dt, cust_complaint_feedback_val, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 cust_complaint_sid,
 cust_complaint_survey_dt,
 cust_complaint_feedback_val,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_complaint_case_survey_hist;