CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_customer_complaint_category (client_id, cust_complaint_cat_sid,
cust_complaint_srv_center_cd, src_cust_complaint_cat_nr, cust_complaint_cat_nr, cust_complaint_cat_name, src_name,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 cust_complaint_cat_sid,
 cust_complaint_srv_center_cd,
 src_cust_complaint_cat_nr,
 cust_complaint_cat_nr,
 cust_complaint_cat_name,
 src_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_customer_complaint_category;