create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_DIM_REPORTING_COUNTRY_2(
	REPORTING_COUNTRY_CD COMMENT 'The code which identifies the reporting country.',
	REPORTING_COUNTRY_NAME COMMENT 'The name the reporting country. (i.e. a country_2 definition which is different from a geographical country_2) The name in in group lanuage, i.e. in German. (Name in group language, i.e. in German)',
	REPORTING_COUNTRY_NAME_DE COMMENT 'The name the reporting country. (i.e. a country_2 definition which is different from a geographical country_2) The name in in group lanuage, i.e. in German. (Name in German)',
	REPORTING_COUNTRY_NAME_EN COMMENT 'The name the reporting country. (i.e. a country_2 definition which is different from a geographical country_2) The name in in group lanuage, i.e. in German. (Name in English)',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='A country_2, as required for reporting, i.e. not identical to a geographical country.'
 as SELECT
main.reporting_country_cd AS reporting_country_cd
,main.reporting_country_name AS reporting_country_name
,main.reporting_country_name_de AS reporting_country_name_de
,main.reporting_country_name_en AS reporting_country_name_en
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_REPORTING_COUNTRY_2 main;