create or replace TABLE UGS_ARIS_PRODUCTION.CORE.T_DIM_TENANT_1 (
	DWH_TENANT_CD VARCHAR(8) NOT NULL COMMENT 'The code for the data warehoue tenant.',
	DWH_TENANT_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the data warehouse tenant in group language (German).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.'
)COMMENT='In terms of a multi-tenancy concept a tenant is the \"high-level\" client, defining the major line of business. Currently these are:\n                                     - Kaufland\n                                     - Lidl\n                                     - Greencycle\n                                     - Production companies (e.g. MEG)\n                                     - SDL / SZD (S-Gesellschaften)'
;