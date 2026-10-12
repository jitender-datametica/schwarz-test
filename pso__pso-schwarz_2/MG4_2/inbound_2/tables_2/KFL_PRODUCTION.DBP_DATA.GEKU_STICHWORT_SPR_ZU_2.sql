create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_STICHWORT_SPR_ZU_2 (
	GEKU_STICHWORT_UID NUMBER(18,0) NOT NULL COMMENT 'eindeutige ID des Stichworts aus dem GEKU-System',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
	GEKU_STICHWORT_BEZ VARCHAR(255) COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des MZK-Stichworts',
	QUELLE_SPR_ID NUMBER(38,0) COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_STICHWORT_SPR_ZU primary key (GEKU_STICHWORT_UID, SPR_ID)
)COMMENT='GEKU -Sprachabhängiger Text  des GEKU - MZK-Stichworts'
;