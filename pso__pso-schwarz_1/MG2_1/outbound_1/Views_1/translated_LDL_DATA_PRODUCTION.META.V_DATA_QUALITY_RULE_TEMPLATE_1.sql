CREATE OR REPLACE VIEW ldl_data_production_meta.v_data_quality_rule_template_1 (dq_rule_template_sid
OPTIONS(description='The unique identifier (surrogate key) for the template for formal data quality rules.'),
dq_rule_template_name
OPTIONS(description='The name of the template script which was used to generate a formal data quality rule.'),
dq_rule_template_descr
OPTIONS(description='A free text describing the purpose and structure of the template for formal data quality rules.'),
template_sql_txt OPTIONS(description='The SQL template for the data quality check.'), dq_rule_type_cd
OPTIONS(description='A code for the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `FORMAL DATA QUALITY CHECKS CAN GENERATED BASED ON A TEMPLATE.`) AS SELECT dq_rule_template_sid,
 dq_rule_template_name,
 dq_rule_template_descr,
 template_sql_txt,
 dq_rule_type_cd,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_data_quality_rule_template_1
UNION DISTINCT
SELECT - 1,
 'Unknown template',
 'Unknown template',
 'Unknown template',
 '@',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';