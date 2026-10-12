create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR.V_REF_LDPL_FEATURE_2(
	FEATURE_ID COMMENT 'Feature identifier',
	FEATURE_DESC COMMENT 'Feature description',
	FEATURE_SUBGROUP_ID COMMENT 'Feature subgroup description',
	DWH_LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row insert time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT='Lidl Plus Feature'
 as
SELECT
 feature_id
,feature_desc
,feature_subgroup_id
,dwh_load_id
,dwh_created
,dwh_updated
FROM P_LEW_PROCESS_MSTR.T_REF_LDPL_FEATURE_2;
