create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE_AC.V_REF_ITEM_RELATION_TYPE_GROUP_1(
	ITEM_REL_TYPE_GRP_CD COMMENT 'The relationship type group code that arranges the relationship types for a combining property, like source system or table.',
	ITEM_REL_TYPE_GRP_DESCR COMMENT 'The relationship type group description for arranged relationship types.',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='The relationship type group arranges the relationship types via a combining property, like source system or table.\nManually filled.'
 as SELECT
   item_rel_type_grp_cd
  ,item_rel_type_grp_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_ITEM_RELATION_TYPE_GROUP_1
;
