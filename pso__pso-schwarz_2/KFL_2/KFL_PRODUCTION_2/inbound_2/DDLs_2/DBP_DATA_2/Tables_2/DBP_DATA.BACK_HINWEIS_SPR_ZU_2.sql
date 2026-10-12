create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BACK_HINWEIS_SPR_ZU_2 (
	BACK_HINWEIS_ID NUMBER(38,0) NOT NULL COMMENT 'eindeutige ID für den Back-Hinweis aus dem Quellfeld ID',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	BACK_HINWEIS_BEZ VARCHAR(100) COLLATE 'en-ci' COMMENT 'Bezeichnung für den Back-Hinweis aus dem Quellfeld bake_info, z.Bsp. \""Tiefgekühlt backen\""',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BACK_HINWEIS_SPR_ZU primary key (BACK_HINWEIS_ID, SPR_ID, MANDANT_ID)
)COMMENT='VIS Backshop - Sprachabhängige Bezeichnungen der Back-Hinweise aus der SAP Z-Tabelle zek_bake_info'
;
