create or replace view LDL_DATA_PRODUCTION.META.V_DATA_QUALITY_RULE_TEMPLATE_1(
	DQ_RULE_TEMPLATE_SID COMMENT 'The unique identifier (surrogate key) for the template for formal data quality rules.',
	DQ_RULE_TEMPLATE_NAME COMMENT 'The name of the template script which was used to generate a formal data quality rule.',
	DQ_RULE_TEMPLATE_DESCR COMMENT 'A free text describing the purpose and structure of the template for formal data quality rules.',
	TEMPLATE_SQL_TXT COMMENT 'The SQL template for the data quality check.',
	DQ_RULE_TYPE_CD COMMENT 'A code for the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='Formal data quality checks can generated based on a template.'
 as
SELECT
   dq_rule_template_sid
  ,dq_rule_template_name
  ,dq_rule_template_descr
  ,template_sql_txt
  ,dq_rule_type_cd
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_DATA_QUALITY_RULE_TEMPLATE_1
UNION
SELECT -1, 'Unknown template', 'Unknown template', 'Unknown template', '@', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;