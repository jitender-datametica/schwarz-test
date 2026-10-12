CREATE OR REPLACE VIEW p_lew_core_ac.v_customer_complaint_service_center_area_relation_hist_1 (
	client_id
	,cust_complaint_srv_center_cd
	,cust_complaint_srv_area_cd
	,deleted_fg
	,dwh_valid_from
	,dwh_valid_to
	,dwh_load_id
	,dwh_created
	,dwh_updated
) AS SELECT
	client_id
	,cust_complaint_srv_center_cd
	,cust_complaint_srv_area_cd
	,deleted_fg
	,dwh_valid_from
	,dwh_valid_to
	,dwh_load_id
	,dwh_created
	,dwh_updated
FROM p_lew_core.t_customer_complaint_service_center_area_relation_hist_1;