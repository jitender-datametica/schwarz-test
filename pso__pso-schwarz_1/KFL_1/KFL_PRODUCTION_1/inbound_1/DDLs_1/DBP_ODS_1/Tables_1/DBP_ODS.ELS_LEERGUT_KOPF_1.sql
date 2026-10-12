create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_ODS.ELS_LEERGUT_KOPF_1 (
	BARCODE_LEERGUT VARCHAR(100) NOT NULL COMMENT 'Barcode des Leergut-Bons',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land_1',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft',
	NB_ID NUMBER(38,0) COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	BON_DAT DATE NOT NULL COMMENT 'Datum des Pfandbons (End-Datum bei Bon-Erstellung)',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
	BON_TMSP TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel des Pfandbons (End-Zeitstempel bei Bon-Erstellung)',
	BON_NR NUMBER(38,0) COMMENT 'Bon Nummer',
	SYSTEM_BEZ VARCHAR(100) COMMENT 'System Software, mit welcher der Pfandbon erstellt wurde',
	SYSTEM_TYP_BEZ VARCHAR(100) COMMENT 'Technischer Typ-Name des Systems',
	SYSTEM_HERSTELLER_BEZ VARCHAR(100) COMMENT 'Hersteller des Pfandautomaten, z.Bsp.: Tomra',
	BON_WERT NUMBER(38,4) NOT NULL DEFAULT 0 COMMENT 'Wert des gesamten Bons',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ELS_LEERGUT_KOPF primary key (BARCODE_LEERGUT, MANDANT_ID)
)COMMENT='ELS - Kopfdaten von den am Pfandautomaten erstellten Leergutbons. Daten werden über SIB, SOLACE in Queue bereitgestellt.'
;
