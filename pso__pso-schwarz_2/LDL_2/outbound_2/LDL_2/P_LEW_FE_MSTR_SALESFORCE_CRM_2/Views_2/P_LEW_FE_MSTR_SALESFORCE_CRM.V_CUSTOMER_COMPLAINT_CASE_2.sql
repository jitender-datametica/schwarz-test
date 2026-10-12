CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_salesforce_crm.v_customer_complaint_case_2 (client_id, cust_complaint_sid,
src_cust_complaint_nr, cust_complaint_nr, case_open_dt, src_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core_ac.v_customer_complaint_case_2;