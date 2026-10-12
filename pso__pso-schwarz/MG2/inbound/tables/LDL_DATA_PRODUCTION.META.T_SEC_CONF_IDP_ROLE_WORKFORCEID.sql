create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_IDP_ROLE_WORKFORCEID (
	IDP_ARRAY_FULL_NAME ARRAY NOT NULL COMMENT 'Value represents the full string exported from IdP includung container & role name',
	IDP_CONTAINER_NAME VARCHAR(100) NOT NULL COMMENT 'Container name being created in IdP like snow / l-mstr-leadenterprise / l-mstr-leadreporting4u. Convention => 1 l-mstr Role per MSTR-Project (environment independent!) & 1 snow-xx Role per database/division & scope (e.g. country level)',
	IDP_FULL_ROLE_NAME VARCHAR(100) COMMENT 'Full IdP (e.g. SIAM) role name generated via MERGE from Components',
	WORKFORCE_ID NUMBER(38,0) NOT NULL COMMENT 'Overarching IDs extracted from IDP for a global (SIT wide) identification of roles',
	DWH_CREATE_TMSP TIMESTAMP_LTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'The point in time when this record was inserted into the table. In case of role bundling data is added manually & filled with default values',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.).  In case of role bundling data is added manually & filled with default values'
)COMMENT='Table contains technical Idp container & role name with applicable tech workforce ID'
;