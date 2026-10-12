create or replace view LDL_DATA_PRODUCTION.META.V_DATA_QUALITY_RULE_CRITICALITY_LEVEL_1(
	DQ_RULE_CRITICALITY_LVL_CD COMMENT 'The code identifying the criticality level for a data quality rule. E.g. high, medium, low.',
	DQ_RULE_CRITICALITY_LVL_DESCR COMMENT 'A textual description for the criticality level for a data quality rule. E.g. high, medium, low.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor entity defines the criticality level for a data quality rule. E.g. high, medium, low.'
 as
SELECT
   dq_rule_criticality_lvl_cd
  ,dq_rule_criticality_lvl_descr
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_DATA_QUALITY_RULE_CRITICALITY_LEVEL_1
UNION
SELECT '@', 'Unknown criticality', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;