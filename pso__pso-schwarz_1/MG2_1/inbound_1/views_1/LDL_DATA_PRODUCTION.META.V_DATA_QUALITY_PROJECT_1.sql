create or replace view LDL_DATA_PRODUCTION.META.V_DATA_QUALITY_PROJECT_1(
	DQ_PROJECT_CD COMMENT 'The code identifying the data quality project.',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DQ_PROJECT_NAME COMMENT 'The name by which the data quality project is known.',
	TENANT_CD COMMENT 'The code identifying the tenant, i.e. the organizational unit_1 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='A data quality project is an initiative to improve the quality of certain data areas. A data quality project is specific to a tenant.'
 as
SELECT
   dq_project_cd
  ,dwh_valid_from_tmsp
  ,dwh_valid_to_tmsp
  ,dwh_valid_fg
  ,dq_project_name
  ,tenant_cd
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_DATA_QUALITY_PROJECT_1
UNION
SELECT '@', '1900-01-01 00:00:00.000 +0100', '9999-12-31 23:59:00.000 +0100', TRUE, 'Unknown project', 'Unknown tenant', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;