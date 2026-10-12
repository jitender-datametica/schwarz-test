create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_MZK_GRUND_SPR_ZU (
	GEKU_MZK_GRUND_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige Id für den Meldezettel-Grund',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
	GEKU_MZK_GRUND_BEZ VARCHAR(255) COLLATE 'en-ci' COMMENT 'Bezeichnung des MZK-Grundes',
	QUELLE_SPR_ID NUMBER(38,0) COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_MZK_GRUND_SPR_ZU primary key (GEKU_MZK_GRUND_UID, SPR_ID)
)COMMENT='GEKU - Sprachabhängige Bezeichnungen der MZK - Gründe'
;