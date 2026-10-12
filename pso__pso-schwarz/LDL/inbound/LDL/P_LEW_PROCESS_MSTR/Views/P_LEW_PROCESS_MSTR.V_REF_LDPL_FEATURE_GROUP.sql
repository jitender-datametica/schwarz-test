create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR.V_REF_LDPL_FEATURE_GROUP(
	LOYALTY_ID COMMENT 'Loyalty atrtibute identifier',
	FEATURE_GROUP_ID COMMENT 'Feature_group identifier',
	FEATURE_GROUP_DESC COMMENT 'Feature_group description',
	ACTIVE_FG COMMENT 'Activity Flag',
	DWH_LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row insert time',
	DWH_UPDATED COMMENT 'Row update time'
) as
SELECT
 loyalty_id
,feature_group_id
,feature_group_desc
,active_fg
,dwh_load_id
,dwh_created
,dwh_updated
FROM P_LEW_PROCESS_MSTR.T_REF_LDPL_FEATURE_GROUP;
