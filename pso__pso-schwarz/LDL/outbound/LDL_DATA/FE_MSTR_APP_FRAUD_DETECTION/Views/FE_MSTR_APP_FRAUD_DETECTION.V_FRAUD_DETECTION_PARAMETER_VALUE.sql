CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_parameter_value (param_id
OPTIONS(description='The unique identifier of parameter (thereshold) of a scenario'), country_org_sid
OPTIONS(description='The unique identifier of the related business country. (The business country is not identical to a political country'),
country_org_cd
OPTIONS(description='The code of the related business country. (The business country is not identical to a political country'),
param_status_cd OPTIONS(description='The status of a parameter value if it is approved, requested or denied.'),
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
OPTIONS(DESCRIPTION = `A PARAMETER CAN HAVE A VALUE WHICH THEN IMPACT THE SCENARIO RESULT`) AS SELECT MAIN.param_id,
 ORG.country_org_sid,
 MAIN.country_org_cd,
 MAIN.param_status_cd,
 MAIN.dwh_valid_from_tmsp,
 MAIN.dwh_valid_to_tmsp,
 MAIN.dwh_valid_fg,
 MAIN.param_val_qty,
 MAIN.requestor_user_name,
 MAIN.request_tmsp,
 MAIN.approver_user_name,
 MAIN.approved_tmsp,
 MAIN.dwh_created_tmsp,
 MAIN.dwh_updated_tmsp,
 MAIN.dwh_load_id,
 MAIN.dwh_node_cd
FROM ldl_data_core_app_fraud_detection.t_fraud_detection_parameter_value AS MAIN
 INNER JOIN ldl_data_core_dim.t_dim_internal_organization AS ORG ON MAIN.country_org_cd = ORG.country_org_cd AND ORG.is_country_org_fg
    AND ORG.dwh_valid_fg;