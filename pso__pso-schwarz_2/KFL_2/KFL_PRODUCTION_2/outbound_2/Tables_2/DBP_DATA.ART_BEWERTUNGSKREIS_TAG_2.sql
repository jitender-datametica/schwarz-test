--==============================================================
-- Table: art_bewertungskreis_tag_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_bewertungskreis_tag_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_bewertungskreis_tag_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
bewertungskreis_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt  '),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
dat_gld DATE NOT NULL OPTIONS(description='Datum, zu dem der GLD ermittelt wurde'),
preis_steuer_kz STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Preissteuerkennzeichen.S= S- Preis, V=GLD'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
gld NUMERIC(18,6) NOT NULL
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Ist unabhängig vom preis_steuer_kz vorhanden'),
standard_preis NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Standardpreis ist nur bei entsprechend gesetztem preis_steuer_kz gefüllt (S)'),
menge_bestand_bme NUMERIC(18,3) NOT NULL OPTIONS(description='Gesamtbestand in Basismengeneinheiten'),
wert_bestand NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Entspricht nicht dem Produkt aus Menge und Preis und muss daher als eigener Wert gespeichert werden'),
vk_wert NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Zum Verkaufspreis bewerteter Bestand'),
zeit_extrakt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zeitpunkt der Erzeugung der Schnittstellendatei'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, dat_gld) NOT ENFORCED
) CLUSTER BY mandant_id, gld, dat_gld
OPTIONS(description='TP408_LVS - Diese Tabelle bildet den gleitenden Durchschnittspreis aus der SAP Tabelle MBEW ab - nur für Läger - MULTISET');