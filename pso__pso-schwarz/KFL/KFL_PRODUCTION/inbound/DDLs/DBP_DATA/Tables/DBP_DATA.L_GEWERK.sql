create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.L_GEWERK (
	GEWERK_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	FINANZ_GRUPPE_NR VARCHAR(20) NOT NULL COMMENT 'Alphanumerische Nummer der Finanzgruppe. Jedes Gewerk besitzt genau eine dazugehörige Finanzgruppe. Über diese Nummer kann bspw. das Budget zum Projekt gemapped werden.',
	constraint PK_L_GEWERK primary key (GEWERK_ID, MANDANT_ID)
)COMMENT='IMS - Lookup-Tabelle der Gewerke (entspricht der letzten Stelle eines PSP-Elements). Manuell im DWH versorgt'
;
