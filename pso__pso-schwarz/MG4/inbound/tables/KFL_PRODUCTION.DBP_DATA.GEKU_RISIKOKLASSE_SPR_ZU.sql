create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_RISIKOKLASSE_SPR_ZU (
	GEKU_RISIKOKLASSE_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Risikoklasse',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
	GEKU_RISIKOKLASSE_BEZ VARCHAR(255) COLLATE 'en-ci' COMMENT 'Bezeichnung der Risikoklasse (z.Bsp. Risikoklasse 1)',
	QUELLE_SPR_ID NUMBER(38,0) COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_RISIKOKLASSE_SPR_ZU primary key (GEKU_RISIKOKLASSE_ID, SPR_ID)
)COMMENT='GEKU - Sprachabhängige Bezeichnungen der GEKU Risikoklasse'
;