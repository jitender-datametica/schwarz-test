CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_order_by_store_act_year_2 (store_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE INTERNAL ORGANIZATION.'), revision_fg_cnt
OPTIONS(description='NUMBER OF AUDITING HAPPENED FOR THE SALES_2 COMPANY'), active_analysis_fg
OPTIONS(description='CURRENTLY REQUIRED OR NOT'))
OPTIONS(DESCRIPTION = `THE COMPLETED OR RUNNING ANALYSIS FOR THE CURRENT YEAR`) AS SELECT ORG.int_org_sid AS store_sid,
 SUM(CASE
   WHEN ORD_PARAM.int_org_sid = ORG.int_org_sid
   THEN 1
   ELSE 0
   END) AS revision_fg_cnt,
 MAX(CASE
   WHEN ORD_PARAM.order_parameter_status_cd = 'RV'
   THEN 1
   ELSE 0
   END) AS active_analysis_fg
FROM ldl_data_core_dim.t_dim_internal_organization_2 AS ORG
 LEFT JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_order_2 AS ORD_PARAM ON ORG.int_org_sid = ORD_PARAM.int_org_sid
     AND EXTRACT(YEAR FROM ORD_PARAM.audit_tmsp) = EXTRACT(YEAR FROM CURRENT_DATE) AND ORD_PARAM.order_parameter_status_cd
    IN ('RV', 'END')
WHERE ORG.int_org_type_cd = 'STORE'
 AND ORG.dwh_valid_fg
GROUP BY store_sid;