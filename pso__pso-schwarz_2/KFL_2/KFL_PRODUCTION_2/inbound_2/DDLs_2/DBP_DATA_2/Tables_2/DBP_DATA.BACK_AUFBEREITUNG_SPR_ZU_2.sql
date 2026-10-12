create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BACK_AUFBEREITUNG_SPR_ZU_2 (
	BACK_AUFBEREITUNG_ID NUMBER(38,0) NOT NULL COMMENT 'eindeutige ID der Back-Aufbereitung aus dem Quellfeld ID, z.Bsp. 1',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	BACK_AUFBEREITUNG_BEZ VARCHAR(255) COLLATE 'en-ci' COMMENT 'Bezeichnung der Aufbereitung aus dem Quellfeld bake_refining, z.Bsp. \""Mit Salz bestreuen\""',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BACK_AUFBEREITUNG_SPR_ZU primary key (BACK_AUFBEREITUNG_ID, SPR_ID, MANDANT_ID)
)COMMENT='VIS Backshop - Sprachabhängige Bezeichnungen zur Back-Aufbereitung aus der SAP Z-Tabelle zek_bake_refin'
;
