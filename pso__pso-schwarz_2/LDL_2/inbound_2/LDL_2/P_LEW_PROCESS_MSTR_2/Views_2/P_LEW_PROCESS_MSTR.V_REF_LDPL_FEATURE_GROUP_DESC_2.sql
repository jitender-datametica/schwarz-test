create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR.V_REF_LDPL_FEATURE_GROUP_DESC_2(
	FEATURE_GROUP_ID COMMENT 'Feature group identifier',
	FEATURE_GROUP_DESC COMMENT 'Feature group description per language',
	LANG_CD COMMENT 'Language code',
	DWH_LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row insert time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT='Lidl Plus Feature Group Description'
 as
SELECT
 feature_group_id
,feature_group_desc
,lang_cd
,dwh_load_id
,dwh_created
,dwh_updated
FROM P_LEW_PROCESS_MSTR.T_REF_LDPL_FEATURE_GROUP_DESC_2;
