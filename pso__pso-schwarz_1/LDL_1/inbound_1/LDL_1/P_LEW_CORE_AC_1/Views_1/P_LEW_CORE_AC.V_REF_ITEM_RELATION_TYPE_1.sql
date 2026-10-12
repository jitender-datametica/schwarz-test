create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE_AC.V_REF_ITEM_RELATION_TYPE_1(
	ITEM_REL_TYPE_CD COMMENT 'Source relationship type number, which identifies the type of the relationship between the parent item_1 and the child item.',
	ITEM_REL_TYPE_GRP_CD COMMENT 'The relationship type group code that arranges the relationship types for a combining property, like source system or table.',
	ITEM_REL_TYPE_DESCR COMMENT 'Descriptioin of the relationship type of the relation between the parent item_1 and the child item.',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table constains the relationship type of the relation between the Parent Item_1 with the Child Item.\nManually filled with values derived from the source.'
 as SELECT
   item_rel_type_cd
  ,item_rel_type_grp_cd
  ,item_rel_type_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_ITEM_RELATION_TYPE_1
;
