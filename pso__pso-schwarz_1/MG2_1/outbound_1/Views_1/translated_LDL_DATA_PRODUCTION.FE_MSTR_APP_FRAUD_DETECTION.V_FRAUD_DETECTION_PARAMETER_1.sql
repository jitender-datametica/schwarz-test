CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_parameter_1 (scenario_id
OPTIONS(description='The unique identifier of fraud detection scenario.'), param_id
OPTIONS(description='The unique identifier of parameter (thereshold) of a scenario'), param_name
OPTIONS(description='The name of a scenario parameter'), param_descr
OPTIONS(description='The description of scenario paramter.'), param_default_val_qty
OPTIONS(description='The default value of a scenario parameter.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `ONE SCENARIO DEFINES ONE OR SEVERAL PARAMETERS.SEVERAL SCENARIOS CAN USE PARAMETERS WITH THE SAME NAME.`)
AS SELECT scenario_id,
 param_id,
 param_name,
 param_descr,
 param_default_val_qty,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_parameter_1 AS main;