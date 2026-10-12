create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CHARGE_IST_QA_CHECK_DET_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SEQ_NR NUMBER(38,0) NOT NULL COMMENT 'Laufende Nummer, wird bei mehreren Meldungen zur selben Charge in SAP einfach hochgezählt',
	CHARGE_NR_QA VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Chargennummer, die bei einer QS-Meldung erzeugt wird  / QA steht für O&G, PF für Pflanzen, FL für Fleischwerk -> aber nicht zwingend - Feld CHARG_QA',
	QA_MANGEL_ID VARCHAR(3) COMMENT 'QA-Mangel (z. B. 001 = Frischemangel)',
	QA_DEKLARATIONSFEHLER_ID VARCHAR(3) COMMENT 'QA-Deklarationsfehler (, z. B. 002 = Etikett fehlt)',
	KOMMENTAR_QA_TXT VARCHAR(500) COMMENT 'User-Kommentar QA',
	KOMMENTAR_EK_TXT VARCHAR(500) COMMENT 'User-Kommentar Einkauf',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CHARGE_IST_QA_CHECK_DET primary key (MANDANT_ID, SEQ_NR, CHARGE_NR_QA)
)COMMENT='Detailinformationen zu QA-Prüfungen Obst & Gemüse -  fasst Meldungen zu Qualitäts- und Deklarationsmängeln + Kommentare seitens QA und Einkauf zusammen'
;
