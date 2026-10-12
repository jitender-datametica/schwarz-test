CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_checked_report_by_store_1 (store_sid
OPTIONS(description='The unique identifier (surrogate key) for the internal organizatio (store or sales_1 company/VGES)'),
request_tmsp OPTIONS(description='The point in time when this record requested by the MicroStrategy-User.'), report_id
OPTIONS(description='The unique identifier of MicroStrategy Report'), report_status_cd
OPTIONS(description='The unique code indicating the status_1 of the checked report (e.g. OPEN, COMMENTED, APPROVED ).'),
is_rep_checked OPTIONS(description='If there is a comment on report or not'), checked_by_user_name
OPTIONS(description='The end user, who sets the audit flag'), comment_by_user
OPTIONS(description='The comment of the user'), analysis_period_start_dt
OPTIONS(description='The begin date of the period which receipts of the internal organization will be analysed'),
analysis_period_end_dt
OPTIONS(description='The end date of the period which receipts of the internal organization will be analysed'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THE COMMENTS OF ANALYSIS AT STORE`) AS SELECT ORG.int_org_sid AS store_sid,
 ORD.request_tmsp,
 REP.report_id,
 COALESCE(MAIN.report_status_cd, 'OP') AS report_status_cd,
  CASE
  WHEN COALESCE(MAIN.report_status_cd, 'OP') = 'OP'
  THEN 'offen'
  WHEN COALESCE(MAIN.report_status_cd, 'OP') = 'WO'
  THEN 'in Bearbeitung'
  ELSE 'geprüft'
  END AS is_rep_checked,
 COALESCE(MAIN.checked_by_user_name, ' ') AS checked_by_user_name,
 COALESCE(MAIN.comment_by_user, ' ') AS comment_by_user,
 ORD.analysis_period_start_dt,
 ORD.analysis_period_end_dt,
 COALESCE(MAIN.dwh_created_tmsp, CURRENT_TIMESTAMP()) AS dwh_created_tmsp,
 COALESCE(MAIN.dwh_updated_tmsp, CURRENT_TIMESTAMP()) AS dwh_updated_tmsp,
 COALESCE(MAIN.dwh_load_id, 10) AS dwh_load_id,
 COALESCE(MAIN.dwh_node_cd, 'MANUAL') AS dwh_node_cd
FROM ldl_data_core_dim.t_dim_internal_organization_1 AS ORG
 INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_order_1 AS ORD ON ORG.int_org_sid = ORD.int_org_sid
 INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_mstr_report_1 AS REP ON TRUE
 LEFT JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_checked_report_1 AS MAIN ON ORG.int_org_sid = MAIN.int_org_sid
     AND REP.report_id = MAIN.report_id AND ORD.request_tmsp = MAIN.request_tmsp
WHERE ORD.order_parameter_status_cd = 'RV'
 AND ORG.dwh_valid_fg
 AND ORG.int_org_type_cd = 'STORE';