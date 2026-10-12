create or replace view LDL_DATA_PRODUCTION.META.V_TENANT_2(
	TENANT_CD COMMENT 'The code identifying the tenant, i.e. the organizational unit_2 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.',
	TENANT_NAME COMMENT 'The name of the tenant, i.e. the organizational unit_2 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='The tenant describes an organizational unit_2 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.'
 as SELECT
   tenant_cd
  ,tenant_name
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_TENANT_2
UNION
SELECT '@', 'Unknown tenant', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;