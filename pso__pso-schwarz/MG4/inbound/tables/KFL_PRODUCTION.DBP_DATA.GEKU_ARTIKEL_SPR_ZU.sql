create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_ARTIKEL_SPR_ZU (
	GEKU_ARTIKEL_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID eines GEKU-Artikels aus workflow_uid. Der GEKU-Artikel besitzt keine Referenz zum Kaufland-Artikel',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
	GEKU_ARTIKEL_BEZ VARCHAR(250) COLLATE 'en-ci' COMMENT 'Bezeichnung des GeKu-Artikels aus code_name, z.Bsp. Einkaufswagen',
	QUELLE_SPR_ID NUMBER(38,0) COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_ARTIKEL_SPR_ZU primary key (GEKU_ARTIKEL_UID, SPR_ID)
)COMMENT='GEKU - Sprachabhängige Bezeichnung der GeKu-Artikel aus s1_dwh_workflow_out'
;