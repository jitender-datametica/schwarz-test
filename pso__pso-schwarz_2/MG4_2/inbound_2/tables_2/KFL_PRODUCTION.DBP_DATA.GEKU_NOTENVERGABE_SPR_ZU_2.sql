create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_NOTENVERGABE_SPR_ZU_2 (
	GEKU_NOTENVERGABE_DURCH_ID NUMBER(18,0) NOT NULL COMMENT 'ID der Notenvergeber',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
	GEKU_NOTENVERGABE_DURCH_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Bezeichnung des Notenvergebers, z.Bsp \"MZK1 Überschrieben\"',
	QUELLE_SPR_ID NUMBER(38,0) COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_NOTENVERGABE_SPR_ZU primary key (GEKU_NOTENVERGABE_DURCH_ID, SPR_ID)
)COMMENT='GEKU - Sprachabhängige Bezeichnungen der Notenvergeber aus geku_text'
;