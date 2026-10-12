create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE_AC.V_ITEM_RELATION_HIST_1(
	ITEM_SID COMMENT 'Artikel_1; FK auf ITEM_1; SAP-Retail: makt.matnr; SAP-BW: t_bw_0material_text.matnr',
	REL_ITEM_SID COMMENT 'Surrogate Key for the related ITEM_1 (eindeutig ueber alle Laender/Mandanten hinweg).',
	ITEM_REL_TYPE_CD COMMENT 'Source relationship type number, which identifies the type of the relationship between the parent item_1 and the child item.',
	ITEM_REL_TYPE_GRP_CD COMMENT 'The relationship type group code that arranges the relationship types for a combining property, like source system or table.',
	ITEM_REL_RATE COMMENT 'Item_1 relationship rate between the item_1 and the related items. e.g. Quantity of pieces (child items) inside of the item_1 multipack / case (parent item_1).',
	DELETED_FG COMMENT 'The record is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.',
	DWH_VALID_FROM COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
	DWH_VALID_TO COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
	CLIENT_ID COMMENT 'DWH-Mandant_1; FK auf CLIENT',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the relationship between two items, I.e. a multpack and its set of included items, which can help calculate accurate quantities of pieces sold, considering the real quantity inside the pack instead of counting only one piece per pack.\nSources:\nWAWI Table: T218_CONS_ITEM_LINKS_1'
 as SELECT
   item_sid
  ,rel_item_sid
  ,item_rel_type_cd
  ,item_rel_type_grp_cd
  ,item_rel_rate
  ,deleted_fg
  ,dwh_valid_from
  ,dwh_valid_to
  ,client_id
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_ITEM_RELATION_HIST_1
;
