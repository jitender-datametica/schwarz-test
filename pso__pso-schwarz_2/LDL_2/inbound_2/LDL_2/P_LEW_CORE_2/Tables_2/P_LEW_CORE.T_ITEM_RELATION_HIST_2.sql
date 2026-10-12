create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_ITEM_RELATION_HIST_2 (
	ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Artikel_2; FK auf ITEM_2; SAP-Retail: makt.matnr; SAP-BW: t_bw_0material_text.matnr',
	REL_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key for the related ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg).',
	ITEM_REL_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'Source relationship type number, which identifies the type of the relationship between the parent item_2 and the child item.',
	ITEM_REL_TYPE_GRP_CD VARCHAR(100) NOT NULL COMMENT 'The relationship type group code that arranges the relationship types for a combining property, like source system or table.',
	ITEM_REL_RATE NUMBER(38,5) COMMENT 'Item_2 relationship rate between the item_2 and the related items. e.g. Quantity of pieces (child items) inside of the item_2 multipack / case (parent item_2).',
	DELETED_FG NUMBER(38,0) NOT NULL COMMENT 'The record is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.',
	DWH_VALID_FROM DATE NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
	DWH_VALID_TO DATE NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_ITEM_RELATION_HIST primary key (ITEM_SID, REL_ITEM_SID, ITEM_REL_TYPE_CD, ITEM_REL_TYPE_GRP_CD, DWH_VALID_FROM)
)COMMENT='This table contains the relationship between two items, I.e. a multpack and its set of included items, which can help calculate accurate quantities of pieces sold, considering the real quantity inside the pack instead of counting only one piece per pack.\n             Sources:\n             WAWI Table: T218_CONS_ITEM_LINKS_2'
;
