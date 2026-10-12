create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR.V_REF_LDPL_FEATURE_SUBGROUP_2(
	FEATURE_SUBGROUP_ID COMMENT 'Feature subgroup identifier',
	FEATURE_SUBGROUP_DESC COMMENT 'Feature subgroup description',
	FEATURE_GROUP_ID COMMENT 'Feature_group identifier',
	ACTIVE_FG COMMENT 'Activity Flag',
	DWH_LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row insert time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT='Lidl Plus feature subgroup'
 as
SELECT
 feature_subgroup_id
,feature_subgroup_desc
,feature_group_id
,active_fg
,dwh_load_id
,dwh_created
,dwh_updated
FROM P_LEW_PROCESS_MSTR.T_REF_LDPL_FEATURE_SUBGROUP_2;
