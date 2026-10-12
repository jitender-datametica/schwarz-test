CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_parameter_value_1 (param_id
OPTIONS(description='The unique identifier of parameter (thereshold) of a scenario'), country_org_sid
OPTIONS(description='The unique identifier of the related business country. (The business country_1 is not identical to a political country_1'),
country_org_cd
OPTIONS(description='The code of the related business country. (The business country_1 is not identical to a political country_1'),
param_status_cd OPTIONS(description='The status_1 of a parameter value if it is approved, requested or denied.'),
dwh_valid_from_tmsp OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
param_val_qty OPTIONS(description='The value of scenario parameter, which is provided by end user.'),
requestor_user_name OPTIONS(description='The MSTR-User who enters the value to the system'), request_tmsp
OPTIONS(description='The point of the time, when the entry is done.'), approver_user_name
OPTIONS(description='The MSTR-User who approves the value entered to the system'), approved_tmsp
OPTIONS(description='The point of the time when the entry is approved.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `A PARAMETER CAN HAVE A VALUE WHICH THEN IMPACT THE SCENARIO RESULT`) AS SELECT main.param_id,
 org.country_org_sid,
 main.country_org_cd,
 main.param_status_cd,
 main.dwh_valid_from_tmsp,
 main.dwh_valid_to_tmsp,
 main.dwh_valid_fg,
 main.param_val_qty,
 main.requestor_user_name,
 main.request_tmsp,
 main.approver_user_name,
 main.approved_tmsp,
 main.dwh_created_tmsp,
 main.dwh_updated_tmsp,
 main.dwh_load_id,
 main.dwh_node_cd
FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_parameter_value_1 AS main
 INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_1 AS org ON main.country_org_cd = org.country_org_cd
   AND org.is_country_org_fg AND org.dwh_valid_fg;