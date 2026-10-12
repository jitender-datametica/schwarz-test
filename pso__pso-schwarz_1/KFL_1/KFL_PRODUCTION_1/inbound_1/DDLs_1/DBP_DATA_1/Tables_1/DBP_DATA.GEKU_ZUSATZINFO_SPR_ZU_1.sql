create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.GEKU_ZUSATZINFO_SPR_ZU_1 (
	ZUSATZINFO_ID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID einer Zusatzinfo',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
	ZUSATZINFO_BEZ VARCHAR(255) COLLATE 'en-ci' COMMENT 'Bezeichnung der Zusatzinfo, z.Bsp. FLW Frische',
	QUELLE_SPR_ID NUMBER(38,0) COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_ZUSATZINFO_SPR_ZU primary key (ZUSATZINFO_ID, SPR_ID)
)COMMENT='GEKU - Sprachabhängige Bezeichnungen der GEKU-Zusatzinfos aus s1_dwh_case_add_info_out'
;
