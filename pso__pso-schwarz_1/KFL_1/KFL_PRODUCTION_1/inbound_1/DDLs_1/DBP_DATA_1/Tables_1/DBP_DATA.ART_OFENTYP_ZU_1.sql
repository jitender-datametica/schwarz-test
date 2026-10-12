create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ART_OFENTYP_ZU_1 (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'DWH Artikelnummer',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	OFEN_TYP_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'ID des Ofentyps aus dem Quellfeld oventype, z.Bsp. A.',
	BLECH_BELEGUNG NUMBER(38,0) NOT NULL COMMENT 'optimale Anzahl des Artikels pro Backblech',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_OFENTYP_ZU primary key (ART_ID, MANDANT_ID, OFEN_TYP_ID)
)COMMENT='VIS Backshop - Diese Tabelle ordnet den Artikeln die Ofentypen zu. Quelle ist die SAP-Klassenbibliothek'
;
