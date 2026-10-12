CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_checked_report_by_store_2 (store_sid
OPTIONS(description='The unique identifier (surrogate key) for the internal organizatio (store or sales_2 company/VGES)'),
request_tmsp OPTIONS(description='The point in time when this record requested by the MicroStrategy-User.'), report_id
OPTIONS(description='The unique identifier of MicroStrategy Report'), is_rep_checked
OPTIONS(description='If there is a comment on report or not'), checked_by_user_name
OPTIONS(description='The end user, who sets the audit flag'), comment_by_user
OPTIONS(description='The comment of the user'), analysis_period_start_dt
OPTIONS(description='The begin date of the period which receipts of the internal organization will be analysed'),
analysis_period_end_dt
OPTIONS(description='The end date of the period which receipts of the internal organization will be analysed'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')) AS
SELECT org.int_org_sid AS store_sid,
 ord.request_tmsp,
 rep.report_id,
  CASE
  WHEN COALESCE(main.int_org_sid, - 99) = - 99
  THEN 'offen'
  ELSE 'geprüft'
  END AS is_rep_checked,
 COALESCE(main.checked_by_user_name, ' ') AS checked_by_user_name,
 COALESCE(main.comment_by_user, ' ') AS comment_by_user,
 ord.analysis_period_start_dt,
 ord.analysis_period_end_dt,
 COALESCE(main.dwh_created_tmsp, CURRENT_TIMESTAMP()) AS dwh_created_tmsp,
 COALESCE(main.dwh_updated_tmsp, CURRENT_TIMESTAMP()) AS dwh_updated_tmsp,
 COALESCE(main.dwh_load_id, 10) AS dwh_load_id,
 COALESCE(main.dwh_node_cd, 'MANUAL') AS dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_internal_organization_2 AS org
 INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_order_2 AS ord ON org.int_org_sid = ord.int_org_sid
  
 INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_report_2 AS rep ON TRUE
 LEFT JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_checked_report_2 AS main ON org.int_org_sid =
    main.int_org_sid AND rep.report_id = main.report_id AND ord.request_tmsp = main.request_tmsp
WHERE ord.order_parameter_status_cd = 'RV'
 AND org.dwh_valid_fg
 AND org.int_org_type_cd = 'STORE';