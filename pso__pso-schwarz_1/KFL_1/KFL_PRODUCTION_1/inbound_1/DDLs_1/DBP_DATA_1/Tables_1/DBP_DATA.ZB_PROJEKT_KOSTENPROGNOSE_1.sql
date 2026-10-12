create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ZB_PROJEKT_KOSTENPROGNOSE_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID NUMBER(38,0) NOT NULL COMMENT 'ID eines Gewerks , z.Bsp 3 = Baukosten',
	WARENGRUPPE_CD VARCHAR(20) NOT NULL COMMENT 'Code der Warengruppe',
	DAT_VERSION DATE NOT NULL COMMENT 'Datum der Version der Kostenprognose',
	VERSION_NR VARCHAR(20) NOT NULL COMMENT 'Versionsnummer der Kostenprognose',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_KOSTENPROGNOSE NUMBER(38,5) NOT NULL COMMENT 'Betrag der Kostenprognose in Landeswährung',
	BETRAG_ZEK NUMBER(38,5) COMMENT 'Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)',
	BETRAG_ZEA NUMBER(38,5) COMMENT 'Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_PROJEKT_KOSTENPROGNOSE primary key (MANDANT_ID, PROJEKT_NR, GEWERK_ID, WARENGRUPPE_CD, DAT_VERSION)
)COMMENT='Enthält Kostenprognosen für die Warengruppen pro Gewerk im jeweiligen Projekt.'
;
