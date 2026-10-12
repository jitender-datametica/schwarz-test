--==============================================================
-- Table: besch_faktura_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_2
   generated from Powerdesigner on Freitag, 21. Januar 2022 14:12:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_faktura_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_2 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
faktura_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der der Faktura und dient der eindeutigen Identifikation der Fakturabelege.'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
dat_faktura DATE NOT NULL
OPTIONS(description='Abhängig von der Fakturaart ist hier entweder das Fakturadatum oder das Datum der Leistungserstellung hinterlegt'),
fakturaart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Klassifiziert verschiedene Arten von Fakturabelegen, die eine_2 unterschiedliche Verarbeitung durch das System erfordern.'),
faktura_status_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Buchhaltungsstatus des Fakturabelegs (z.B. einer Rechnung). Der Status_2 gibt Auskunft darüber, ob das System die Faktura erfolgreich an die Buchhaltung übergeleitet hat, oder ob die Überleitung gesperrt ist, weil für die Fakturaart eine_2 Buchungssperre gese'),
verkaufsorganisation_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'),
kalk_schema_id STRING(7) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Legt fest, welche Konditionsarten in einem Beleg verwendet werden können und in welcher Reihenfolge sie erscheinen.'),
auftraggeber_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kundennummer des Auftraggebers. Noch keine Referenz zu einer bestehenden DWH Tabelle möglich (SAP Quelle VBRP - WERKS)'),
storno_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Stornokennzeichen für diesen Fakturabeleg'),
dat_erstellung DATE NOT NULL
OPTIONS(description='Das Feld enthält das Erstelldatum des Datensatzes auf dem SAP System.'),
dat_faktura_sap DATE NOT NULL
OPTIONS(description='Das Attribut dat_faktura_sap  enthält das Original-SAP-Datum für Fakturaindex und Druck.'),
faktura_typ_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der Fakturatyp dient dazu, einen Storno- oder Retourenbeleg zu identifizieren. Keine Lookuptabelle dazu vorhanden. Aus vbtyp'),
mandant_id_auftraggeber BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_2 des Auftraggebers kann bei grenzüberschreitenden Fakturen (z.Bsp. IWT) vom Mandanten im Schlüssel abweichen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='TP408_LVS - In diester Tabelle sind die Fakturabelege aus der SAP Tabelle VBRK enthalten - nur für Mandant_2 1. - MULTISET');