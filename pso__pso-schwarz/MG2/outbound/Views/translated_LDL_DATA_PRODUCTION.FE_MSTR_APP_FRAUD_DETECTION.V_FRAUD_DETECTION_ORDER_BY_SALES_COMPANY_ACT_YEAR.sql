CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_order_by_sales_company_act_year
(sales_company_sid OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE INTERNAL ORGANIZATION.'),
revision_fg_cnt OPTIONS(description='NUMBER OF AUDITING HAPPENED FOR THE SALES COMPANY'), active_analysis_fg
OPTIONS(description='CURRENTLY REQUIRED OR NOT'), order_frequency_per_year
OPTIONS(description='MAXIMUM ORDER ALLOWED PER YEAR')) AS SELECT org.int_org_sid AS sales_company_sid,
 SUM(CASE
   WHEN ord_param.int_org_sid = org.int_org_sid
   THEN 1
   ELSE 0
   END) AS revision_fg_cnt,
 MAX(CASE
   WHEN ord_param.order_parameter_status_cd = 'RV'
   THEN 1
   ELSE 0
   END) AS active_analysis_fg,
 MAX(max_order.param_country_val_qty) AS order_frequency_per_year
FROM ldl_data_production_core_dim.t_dim_internal_organization AS org
 LEFT JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_order AS ord_param ON org.int_org_sid =
    ord_param.int_org_sid AND EXTRACT(YEAR FROM ord_param.audit_tmsp) = EXTRACT(YEAR FROM CURRENT_DATE) AND ord_param.order_parameter_status_cd
    IN ('RV', 'END')
 LEFT JOIN ldl_data_production_core_app_fraud_detection.v_fraud_detection_parameter_current_value AS max_order ON org.country_org_cd
    = max_order.country_org_cd AND max_order.param_id = 133
WHERE org.int_org_type_cd = 'COMPANY'
 AND org.dwh_valid_fg
 AND org.is_sales_company_fg
GROUP BY sales_company_sid
HAVING revision_fg_cnt < IFNULL(order_frequency_per_year, 999);