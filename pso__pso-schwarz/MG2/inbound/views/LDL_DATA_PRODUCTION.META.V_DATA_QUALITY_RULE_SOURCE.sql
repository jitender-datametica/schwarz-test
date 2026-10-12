create or replace view LDL_DATA_PRODUCTION.META.V_DATA_QUALITY_RULE_SOURCE(
	DQ_RULE_SRC_CD COMMENT 'The code identifying the origin of the data quality rule. A rule may be defined by business or by the data modelling team or because of a formal guideline, such as checking all foreign keys for referential integrity violations. (Note that the origin of a data quality rule is independent from the way how it is implemented, i.e. as a generated rule, a parametrized rule or as a business rule.)',
	DQ_RULE_SRC_DESCR COMMENT 'A textual description for the origin of the data quality rule.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor entity defines the origin of the data quality rule. A rule may be defined by business or by the data modelling team or because of a formal guideline, such as checking all foreign keys for referential integrity violations. (Note that the origin of a data quality rule is independent from the way how it is implemented, i.e. as a generated rule, a parametrized rule or as a business rule.)'
 as
SELECT
   dq_rule_src_cd
  ,dq_rule_src_descr
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_DATA_QUALITY_RULE_SOURCE
UNION
SELECT '@', 'Unknown source', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;