--==============================================================
-- Table: besch_faktura
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura
   generated from Powerdesigner on Freitag, 21. Januar 2022 14:12:43
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_FAKTURA(
   mandant_id                          INTEGER    NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   faktura_beleg_id                    INTEGER    NOT NULL COMMENT 'Das Feld enthält die Beleg ID der der Faktura und dient der eindeutigen Identifikation der Fakturabelege.',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   dat_faktura                         DATE            NOT NULL COMMENT 'Abhängig von der Fakturaart ist hier entweder das Fakturadatum oder das Datum der Leistungserstellung hinterlegt',
   fakturaart_id                       VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Klassifiziert verschiedene Arten von Fakturabelegen, die eine unterschiedliche Verarbeitung durch das System erfordern.',
   faktura_status_id                   VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Buchhaltungsstatus des Fakturabelegs (z.B. einer Rechnung). Der Status gibt Auskunft darüber, ob das System die Faktura erfolgreich an die Buchhaltung übergeleitet hat, oder ob die Überleitung gesperrt ist, weil für die Fakturaart eine Buchungssperre gese',
   verkaufsorganisation_id             VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.',
   kalk_schema_id                      VARCHAR(7)      COLLATE 'en-ci' NOT NULL COMMENT 'Legt fest, welche Konditionsarten in einem Beleg verwendet werden können und in welcher Reihenfolge sie erscheinen.',
   auftraggeber_id                     VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'Kundennummer des Auftraggebers. Noch keine Referenz zu einer bestehenden DWH Tabelle möglich (SAP Quelle VBRP - WERKS)',
   storno_fg                           INTEGER    NOT NULL COMMENT 'Stornokennzeichen für diesen Fakturabeleg',
   dat_erstellung                      DATE            NOT NULL COMMENT 'Das Feld enthält das Erstelldatum des Datensatzes auf dem SAP System.',
   dat_faktura_sap                     DATE            NOT NULL COMMENT 'Das Attribut dat_faktura_sap  enthält das Original-SAP-Datum für Fakturaindex und Druck.',
   faktura_typ_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Der Fakturatyp dient dazu, einen Storno- oder Retourenbeleg zu identifizieren. Keine Lookuptabelle dazu vorhanden. Aus vbtyp',
   mandant_id_auftraggeber             INTEGER    NOT NULL COMMENT 'Der Mandant des Auftraggebers kann bei grenzüberschreitenden Fakturen (z.Bsp. IWT) vom Mandanten im Schlüssel abweichen',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'TP408_LVS - In diester Tabelle sind die Fakturabelege aus der SAP Tabelle VBRK enthalten - nur für Mandant 1. - MULTISET';