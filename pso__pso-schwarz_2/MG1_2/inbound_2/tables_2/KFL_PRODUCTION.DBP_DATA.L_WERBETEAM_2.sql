create or replace TABLE KFL_PRODUCTION.DBP_DATA.L_WERBETEAM_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WERBETEAM_CD VARCHAR(100) NOT NULL COMMENT 'Code des Werbeteams',
	WERBEBEREICH_CD VARCHAR(100) COMMENT 'Code des Werbebereichs',
	WERBETEAM_BEZ VARCHAR(100) COMMENT 'Werbeteam - Bezeichnung',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_L_WERBETEAM primary key (MANDANT_ID, WERBETEAM_CD)
)COMMENT='Fachlich verantwortliche Personen (auch Planer genannt) die für eine_2 Kategorie an Artikel_2 die über die WGs identifziert werden, die Werbungen in Deutschland planen.\n             '
;