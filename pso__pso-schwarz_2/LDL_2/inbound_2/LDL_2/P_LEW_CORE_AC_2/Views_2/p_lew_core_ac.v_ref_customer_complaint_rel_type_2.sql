CREATE OR REPLACE VIEW p_lew_core_ac.v_ref_customer_complaint_rel_type_2 (
	cust_complaint_rel_type_cd
	,cust_complaint_rel_type_desc
	,dwh_load_id
	,dwh_created
	,dwh_updated
) AS SELECT
	cust_complaint_rel_type_cd
	,cust_complaint_rel_type_desc
	,dwh_load_id
	,dwh_created
	,dwh_updated
FROM p_lew_core.t_ref_customer_complaint_rel_type_2;