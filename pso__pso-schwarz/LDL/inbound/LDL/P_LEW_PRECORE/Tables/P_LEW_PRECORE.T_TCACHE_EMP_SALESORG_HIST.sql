/*

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2025-05-20 Pawel Wieczorek         AP0172232 747581 Init version
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE P_LEW_PRECORE.T_TCACHE_EMP_SALESORG_HIST (
	CLIENT_ID NUMBER(38,0) NOT NULL,
	COUNTRY VARCHAR(20) NOT NULL COLLATE 'en-ci',
	STORENO VARCHAR(20) NOT NULL COLLATE 'en-ci',
	LOC_SID_STORE NUMBER(38,0),
	WAREHOUSE VARCHAR(20) NOT NULL COLLATE 'en-ci',
	SALES_MANAGER_ID VARCHAR(20) COLLATE 'en-ci' NOT NULL,
	SALES_MANAGER_NAME VARCHAR(100) COLLATE 'en-ci' NOT NULL,
	ACCOUNT_MANAGER_ID VARCHAR(20) COLLATE 'en-ci' NOT NULL,
	ACCOUNT_MANAGER_NAME VARCHAR(100) COLLATE 'en-ci' NOT NULL,
	STORE_MANAGER_ID VARCHAR(20) COLLATE 'en-ci',
	STORE_MANAGER_NAME VARCHAR(100) COLLATE 'en-ci',
	GENERAL_MANAGER_ID VARCHAR(20) COLLATE 'en-ci',
	GENERAL_MANAGER_NAME VARCHAR(100) COLLATE 'en-ci',
	SALESAREA VARCHAR(100) COLLATE 'en-ci',
	VALIDFROM DATE,
	DELETED_FG NUMBER(38,0) NOT NULL,
	DWH_VALID_FROM DATE NOT NULL,
	DWH_VALID_TO DATE NOT NULL,
	DWH_LOAD_ID NUMBER(38,0) NOT NULL,
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
	CONSTRAINT pk_tcache_emp_salesorg_hist PRIMARY KEY (COUNTRY, WAREHOUSE, STORENO, DWH_VALID_FROM)
);
