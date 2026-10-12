create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ZB_PROJEKT_BESTELLUNG_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	BESTELL_BELEG_NR NUMBER(38,0) NOT NULL COMMENT 'Belegnummer der Bestellung.',
	DAT_ERSTELLUNG DATE NOT NULL COMMENT 'Erstelldatum der Bestellung.',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	EINKAUFSORGANISATION_ID NUMBER(38,0) COMMENT 'ID der Einkaufsorganisation aus ekorg',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_PROJEKT_BESTELLUNG primary key (MANDANT_ID, BESTELL_BELEG_NR)
)COMMENT='Enhält die erstellten Bestellungen (Kopfinformationen), die innerhalb von Projekten aus den Zentralbereichen erstellt werden.'
;
