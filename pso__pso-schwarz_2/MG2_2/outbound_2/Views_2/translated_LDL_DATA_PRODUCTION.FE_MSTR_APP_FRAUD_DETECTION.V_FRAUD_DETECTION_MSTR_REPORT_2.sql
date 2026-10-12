CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_mstr_report_2 (report_id
OPTIONS(description='The unique identifier of MicroStrategy Report'), report_grp_id
OPTIONS(description='The unique identifier of fraud detection scenario group.'), report_name
OPTIONS(description='The name of the report which will be used by the navigation.'), report_descr
OPTIONS(description='Describes the report.'), report_type_cd
OPTIONS(description='Type of report, code which defines if it is developed for manual or automatic for different layers'),
report_offset OPTIONS(description='The sequence number of the report, in which order it will be displayed'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `KEEPS THE FRAUD DETECTION METRICS FOR MICROSTRATEGY DYNAMIC DASHBOARDS `) AS SELECT report_id,
 report_grp_id,
 report_name,
 report_descr,
 report_type_cd,
 report_offset,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_report_2 AS main;