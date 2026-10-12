CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_mstr_report_to_metric (report_id
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
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `KEEPS THE INFORMATION WHICH METRICS WILL BE PRESENTED ON WHICH REPORT`) AS SELECT MAIN.report_id
 ,
 MAIN.metric_id,
 MAIN.metric_offset,
 MET.metric_name,
 MET.format_type_cd,
 MET.calculation_type_cd,
 MAIN.dwh_created_tmsp,
 MAIN.dwh_updated_tmsp,
 MAIN.dwh_load_id,
 MAIN.dwh_node_cd
FROM ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_report_to_metric AS MAIN
 INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_metric AS MET ON MAIN.metric_id = MET.metric_id;