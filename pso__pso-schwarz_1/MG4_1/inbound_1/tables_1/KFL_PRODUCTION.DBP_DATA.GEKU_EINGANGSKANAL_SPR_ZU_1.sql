create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_EINGANGSKANAL_SPR_ZU_1 (
	GEKU_EINGANGSKANAL_ID NUMBER(38,0) NOT NULL COMMENT 'GeKu Eingangskanal, z.Bsp. Fax, Telefon',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
	GEKU_EINGANGSKANAL_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Bezeichnung des GeKu-Eingangskanals, z.Bsp. Brief; Fax',
	QUELLE_SPR_ID NUMBER(38,0) COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_EINGANGSKANAL_SPR_ZU primary key (GEKU_EINGANGSKANAL_ID, SPR_ID)
)COMMENT='GEKU - Sprachabhängige Bezeichnungen der Eingangskanäle'
;