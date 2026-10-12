create or replace view LDL_DATA_PRODUCTION.META.V_DATA_QUALITY_RULE_TYPE_1(
	DQ_RULE_TYPE_CD COMMENT 'A code for the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.',
	DQ_RULE_TYPE_DESCR COMMENT 'A textual description for the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor entity defines the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.'
 as
SELECT
   dq_rule_type_cd
  ,dq_rule_type_descr
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_DATA_QUALITY_RULE_TYPE_1
UNION
SELECT '@', 'Unknown rule type', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;