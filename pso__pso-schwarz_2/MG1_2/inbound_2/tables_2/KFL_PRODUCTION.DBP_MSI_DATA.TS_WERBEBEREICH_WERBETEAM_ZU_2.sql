create or replace TABLE KFL_PRODUCTION.DBP_MSI_DATA.TS_WERBEBEREICH_WERBETEAM_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe.',
	WERBEBEREICH_CD VARCHAR(100) COMMENT 'Code des Werbebereichs.',
	WERBETEAM_CD VARCHAR(100) COMMENT 'Code des Werbeteams',
	WERBETEAM_BEZ VARCHAR(100) COMMENT 'Werbeteam - Bezeichnung',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_WERBEBEREICH_WERBETEAM_ZU primary key (MANDANT_ID, WG_ID)
)COMMENT='Transaktionservice Tabelle mit Informationen über Werbebereich und Werbeteam einer Warengruppe.'
;