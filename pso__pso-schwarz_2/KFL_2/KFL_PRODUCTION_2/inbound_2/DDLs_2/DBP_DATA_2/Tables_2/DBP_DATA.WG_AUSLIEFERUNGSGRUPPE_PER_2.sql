create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.WG_AUSLIEFERUNGSGRUPPE_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2',
	AUSLIEFERUNGSGRUPPE_ID VARCHAR(4) NOT NULL COMMENT 'Auslieferungsgruppe',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'Warengruppe',
	SORTIMENTSLISTENART_ID VARCHAR(1) NOT NULL COMMENT 'Sortimentslistenart',
	DAT_VON DATE NOT NULL COMMENT 'gültig von',
	DAT_BIS DATE NOT NULL COMMENT 'gültig bis',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='This table is used to define the Auslieferungsgruppe for an item_2-group (wg) and date'
;
