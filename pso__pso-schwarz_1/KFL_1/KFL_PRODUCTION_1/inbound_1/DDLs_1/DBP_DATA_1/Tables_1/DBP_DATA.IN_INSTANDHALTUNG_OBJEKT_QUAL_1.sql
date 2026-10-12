create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.IN_INSTANDHALTUNG_OBJEKT_QUAL_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	QUAL_MELDUNG_ID NUMBER(18,0) NOT NULL COMMENT 'ID der Qualitaetsmeldung aus qmnum',
	TP_OBJEKT_ID NUMBER(38,0) COMMENT 'Auspraegung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1',
	AUFTRAG_ID VARCHAR(20) COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
	TECHN_PLATZ_ID VARCHAR(30) COLLATE 'en-ci' COMMENT 'Der technische Platz ist eine_1 von Kaufland Facility Management verwaltete Einheit',
	DAT_STOER_BEGINN DATE COMMENT 'Stoerungsbeginn (Datum)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	CS_AUFTRAG_PRIO NUMBER(38,0) COMMENT 'Für die Auftragsart 4IHA ist bei PRIOK eine_1 Priorität von 1, 2 oder 3 angegeben. Falls keine Priorität angegeben: Null. (cs = customer service)',
	constraint PK_IN_INSTANDHALTUNG_OBJEKT_QUAL primary key (QUAL_MELDUNG_ID, MANDANT_ID),
	unique (MANDANT_ID, QUAL_MELDUNG_ID)
)COMMENT='LIS - IND View VIQMEL, enthaelt Tabellen QMEL (Qualitaetsmeldung) und ILOA (Standort und Kontierung zum ICH-Objekt)'
;
