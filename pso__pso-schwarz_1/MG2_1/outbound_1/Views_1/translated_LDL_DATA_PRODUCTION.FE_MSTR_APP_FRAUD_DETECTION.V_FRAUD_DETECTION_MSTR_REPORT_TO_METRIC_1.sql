CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_mstr_report_to_metric_1 (report_id
OPTIONS(description='The unique identifier of MicroStrategy Report'), metric_id
OPTIONS(description='The unique identifier of microstratey metric'), metric_offset
OPTIONS(description='The display order of the metric on the report'), metric_name
OPTIONS(description='The Name of the metric'), format_type_cd
OPTIONS(description='Type of format, code which defines metric format like integer, percent, currency'),
calculation_type_cd
OPTIONS(description='Type of calculation, code which defines type of calculation like SUM, weighted Average, count'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')) AS
SELECT main.report_id,
 main.metric_id,
 main.metric_offset,
 met.metric_name,
 met.format_type_cd,
 met.calculation_type_cd,
 main.dwh_created_tmsp,
 main.dwh_updated_tmsp,
 main.dwh_load_id,
 main.dwh_node_cd
FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_report_to_metric_1 AS main
 INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_1 AS met ON main.metric_id = met.metric_id;