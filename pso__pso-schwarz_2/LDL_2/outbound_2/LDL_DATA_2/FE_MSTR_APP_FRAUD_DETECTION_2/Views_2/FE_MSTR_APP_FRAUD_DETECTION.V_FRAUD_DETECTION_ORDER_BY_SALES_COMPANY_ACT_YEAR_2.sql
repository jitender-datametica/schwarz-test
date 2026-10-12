CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_order_by_sales_company_act_year_2 (sales_company_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE INTERNAL ORGANIZATION.'), revision_fg_cnt
OPTIONS(description='NUMBER OF AUDITING HAPPENED FOR THE SALES_2 COMPANY'), active_analysis_fg
OPTIONS(description='CURRENTLY REQUIRED OR NOT'), order_frequency_per_year
OPTIONS(description='MAXIMUM ORDER ALLOWED PER YEAR'))
OPTIONS(DESCRIPTION = `THE COMPLETED OR RUNNING ANALYSIS FOR THE CURRENT YEAR`) AS SELECT ORG.int_org_sid AS
 sales_company_sid,
 SUM(CASE
   WHEN ORD_PARAM.int_org_sid = ORG.int_org_sid
   THEN 1
   ELSE 0
   END) AS revision_fg_cnt,
 MAX(CASE
   WHEN ORD_PARAM.order_parameter_status_cd = 'RV'
   THEN 1
   ELSE 0
   END) AS active_analysis_fg,
 MAX(MAX_ORDER.param_country_val_qty) AS order_frequency_per_year
FROM ldl_data_core_dim.t_dim_internal_organization_2 AS ORG
 LEFT JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_order_2 AS ORD_PARAM ON ORG.int_org_sid = ORD_PARAM.int_org_sid
     AND EXTRACT(YEAR FROM ORD_PARAM.audit_tmsp) = EXTRACT(YEAR FROM CURRENT_DATE) AND ORD_PARAM.order_parameter_status_cd
    IN ('RV', 'END')
 LEFT JOIN ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value_2 AS MAX_ORDER ON ORG.country_org_cd
    = MAX_ORDER.country_org_cd AND MAX_ORDER.param_id = 133
WHERE ORG.int_org_type_cd = 'COMPANY'
 AND ORG.dwh_valid_fg
 AND ORG.is_sales_company_fg
GROUP BY sales_company_sid
HAVING revision_fg_cnt < IFNULL(order_frequency_per_year, 999);