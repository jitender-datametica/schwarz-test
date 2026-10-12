create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BESCH_FAKTURA_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
	FAKTURA_BELEG_ID NUMBER(18,0) NOT NULL COMMENT 'Das Feld enthält die Beleg ID der der Faktura und dient der eindeutigen Identifikation der Fakturabelege.',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	DAT_FAKTURA DATE NOT NULL COMMENT 'Abhängig von der Fakturaart ist hier entweder das Fakturadatum oder das Datum der Leistungserstellung hinterlegt',
	FAKTURAART_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Klassifiziert verschiedene Arten von Fakturabelegen, die eine_1 unterschiedliche Verarbeitung durch das System erfordern.',
	FAKTURA_STATUS_ID VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Buchhaltungsstatus des Fakturabelegs (z.B. einer Rechnung). Der Status_1 gibt Auskunft darüber, ob das System die Faktura erfolgreich an die Buchhaltung übergeleitet hat, oder ob die Überleitung gesperrt ist, weil für die Fakturaart eine_1 Buchungssperre gese',
	VERKAUFSORGANISATION_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.',
	KALK_SCHEMA_ID VARCHAR(7) NOT NULL COLLATE 'en-ci' COMMENT 'Legt fest, welche Konditionsarten in einem Beleg verwendet werden können und in welcher Reihenfolge sie erscheinen.',
	AUFTRAGGEBER_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Kundennummer des Auftraggebers. Noch keine Referenz zu einer bestehenden DWH Tabelle möglich (SAP Quelle VBRP - WERKS)',
	STORNO_FG NUMBER(38,0) NOT NULL COMMENT 'Stornokennzeichen für diesen Fakturabeleg',
	DAT_ERSTELLUNG DATE NOT NULL COMMENT 'Das Feld enthält das Erstelldatum des Datensatzes auf dem SAP System.',
	DAT_FAKTURA_SAP DATE NOT NULL COMMENT 'Das Attribut dat_faktura_sap  enthält das Original-SAP-Datum für Fakturaindex und Druck.',
	FAKTURA_TYP_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Der Fakturatyp dient dazu, einen Storno- oder Retourenbeleg zu identifizieren. Keine Lookuptabelle dazu vorhanden. Aus vbtyp',
	MANDANT_ID_AUFTRAGGEBER NUMBER(38,0) NOT NULL COMMENT 'Der Mandant_1 des Auftraggebers kann bei grenzüberschreitenden Fakturen (z.Bsp. IWT) vom Mandanten im Schlüssel abweichen',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='TP408_LVS - In diester Tabelle sind die Fakturabelege aus der SAP Tabelle VBRK enthalten - nur für Mandant_1 1. - MULTISET'
;
