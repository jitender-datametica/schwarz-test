create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_STATUS_SPR_ZU_2 (
	GEKU_STATUS_ID NUMBER(38,0) NOT NULL COMMENT 'eindeutige ID des Ticketstatus (erledigt, eskaliert, in Arbeit, überfällig)',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
	GEKU_STATUS_BEZ VARCHAR(60) COMMENT 'Bezeichnung des Ticketstatus z.Bsp. (erledigt, eskaliert, in Arbeit, überfällig)',
	QUELLE_SPR_ID NUMBER(38,0) COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_STATUS_SPR_ZU primary key (GEKU_STATUS_ID, SPR_ID)
)COMMENT='GEKU - Sprachabhängige Bezeichnungen des GEKU Ticketstatus'
;