create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_FV_SPR_ZU_2 (
	FV_FG NUMBER(38,0) NOT NULL COMMENT 'Flag für Eigen/Fremdverteilung. Wert = 1 ist FV',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
	FV_BEZ VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung für Fremd-/Eigenverteilung',
	QUELLE_SPR_ID NUMBER(38,0) COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_FV_SPR_ZU primary key (FV_FG, SPR_ID)
)COMMENT='GEKU - Sprachabhängige Bezeichnung für Fremd-/Eigenverteilung - manuell befüllt'
;