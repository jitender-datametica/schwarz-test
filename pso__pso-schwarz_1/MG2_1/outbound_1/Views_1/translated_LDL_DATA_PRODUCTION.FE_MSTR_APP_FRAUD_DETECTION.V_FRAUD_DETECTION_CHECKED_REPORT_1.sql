CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_checked_report_1 (store_sid
OPTIONS(description='The unique identifier (surrogate key) for the internal organizatio (store or sales_1 company/VGES)'),
request_tmsp OPTIONS(description='The point in time when this record requested by the MicroStrategy-User.'), report_id
OPTIONS(description='The unique identifier of MicroStrategy Report'), checked_by_user_name
OPTIONS(description='The end user, who sets the audit flag'), comment_by_user
OPTIONS(description='The comment of the user'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')) AS
SELECT int_org_sid AS store_sid,
 request_tmsp,
 report_id,
 checked_by_user_name,
 comment_by_user,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_checked_report_1 AS main;