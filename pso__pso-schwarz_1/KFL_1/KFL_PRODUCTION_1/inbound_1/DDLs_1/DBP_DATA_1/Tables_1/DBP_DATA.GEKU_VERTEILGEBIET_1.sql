create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.GEKU_VERTEILGEBIET_1 (
	VERTEILGEBIET_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID des Verteilgebiets',
	GEBIETSLEITER_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID des Gebietsleiters aus pc_nr',
	VERTEILGEBIET_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Bezeichnung des Verteilgebiets',
	MANDANT_ID NUMBER(38,0) COMMENT 'Mandant_1 im DWH. Gehört zum NILS Verteilgebiet',
	NILS_VERTEILGEBIET_ID NUMBER(38,0) COMMENT 'Verteilgebiet ID aus dem System NILS. Wird per Transaction Service oder GEKU-SST gepflegt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_VERTEILGEBIET primary key (VERTEILGEBIET_UID)
)COMMENT='GEKU - Lookup-Tabelle der Verteilgebiete aus wmd_vg_out'
;
