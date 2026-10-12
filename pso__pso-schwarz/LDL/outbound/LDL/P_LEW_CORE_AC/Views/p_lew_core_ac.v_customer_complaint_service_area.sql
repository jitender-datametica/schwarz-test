CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_complaint_service_area (cust_complaint_srv_area_cd,
cust_complaint_srv_area_desc, dwh_load_id, dwh_created, dwh_updated) AS SELECT cust_complaint_srv_area_cd,
 cust_complaint_srv_area_desc,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_complaint_service_area;