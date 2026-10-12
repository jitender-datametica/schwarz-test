--==============================================================
-- Table: art_bewertungskreis_monat
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_bewertungskreis_monat
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_bewertungskreis_monat (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
bewertungskreis_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt  '),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
gjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahresmonat'),
preis_steuer_kz STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Preissteuerkennzeichen.S= S- Preis, V=GLD'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
gld NUMERIC(18,6) NOT NULL
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände'),
standard_preis NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Standardpreis ist nur bei entsprechend gesetztem preis_steuer_kz gefüllt (S)'),
menge_bestand_bme NUMERIC(18,3) NOT NULL OPTIONS(description='Gesamtbestand in Basismengeneinheiten'),
wert_bestand NUMERIC(18,4) NOT NULL
OPTIONS(description='Entspricht nicht dem Produkt aus Menge und Preis und muss daher als eigener Wert gespeichert werden'),
vk_wert NUMERIC(18,2) NOT NULL OPTIONS(description='Zum Verkaufspreis bewerteter Bestand'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, gjmo) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - Diese Tabelle enthält historisierte und korrigierte Daten auf monatlicher Ebene aus der SAP Tabelle mbew - MULTISET');