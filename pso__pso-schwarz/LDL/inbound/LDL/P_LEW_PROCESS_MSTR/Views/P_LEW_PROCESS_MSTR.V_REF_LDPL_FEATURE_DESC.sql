create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR.V_REF_LDPL_FEATURE_DESC(
	FEATURE_ID COMMENT 'Feature identifier',
	FEATURE_DESC COMMENT 'Feature description per language',
	LANG_CD COMMENT 'Language code',
	DWH_LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row insert time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT='Lidl Plus Feature Description'
 as
SELECT
 feature_id
,feature_desc
,lang_cd
,dwh_load_id
,dwh_created
,dwh_updated
FROM P_LEW_PROCESS_MSTR.T_REF_LDPL_FEATURE_DESC;
