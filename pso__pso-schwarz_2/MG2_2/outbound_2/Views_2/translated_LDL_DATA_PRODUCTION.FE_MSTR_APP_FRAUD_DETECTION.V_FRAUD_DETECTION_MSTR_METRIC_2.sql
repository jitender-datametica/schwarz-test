CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_mstr_metric_2 (metric_id
OPTIONS(description='The unique identifier of microstratey metric'), scenario_id
OPTIONS(description='The unique identifier of fraud detection scenario'), metric_name
OPTIONS(description='The name of the microstrategy metric presented at frontend.'), metric_descr
OPTIONS(description='Describes the MicroStrategy Metric.'), calculation_type_cd
OPTIONS(description='Type of calculation, code which defines type of calculation like SUM, weighted Average, count'),
format_type_cd OPTIONS(description='Type of format, code which defines metric format like integer, percent, currency'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `KEEPS THE FRAUD DETECTION METRICS FOR MICROSTRATEGY DYNAMIC DASHBOARDS `) AS SELECT metric_id,
 scenario_id,
 metric_name,
 metric_descr,
 calculation_type_cd,
 format_type_cd,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 AS main;