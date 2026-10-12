DROP TABLE IF EXISTS kfl_production_dbp_data.art_bewertungskreis_per_2;
CREATE OR REPLACE TABLE kfl_production_dbp_data.art_bewertungskreis_per_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
bewertungskreis_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt. Aus bwkey\n\n            '),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Satz Gültigkeit hat'),
preis_steuer_kz STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Preissteuerkennzeichen.S= S- Preis, V=GLD. Aus vprsv'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT\n            '),
dat_aenderung DATE NOT NULL OPTIONS(description='Aenderungsdatum des Satzes im SAP Quellsystem.'),
zeit_aenderung INTEGER NOT NULL OPTIONS(description='Aenderungszeitpunkt des Satzes im Quellsystem.'),
gld NUMERIC(18,6) NOT NULL
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Ist unabhängig vom preis_steuer_kz vorhanden. Aus verpr'),
standard_preis NUMERIC(18,4) NOT NULL
OPTIONS(description='Der Standardpreis ist nur bei entsprechend gesetztem preis_steuer_kz gefüllt (S). Aus stprs'),
menge_bestand_bme NUMERIC(18,3) NOT NULL
OPTIONS(description='Gesamtbestand in Basismengeneinheiten aus dem Quellfeld lbkum'),
wert_bestand NUMERIC(18,4) NOT NULL
OPTIONS(description='Entspricht nicht dem Produkt aus Menge und Preis und muss daher als eigener Wert gespeichert werden. Aus salk3'),
vk_wert NUMERIC(18,2) NOT NULL OPTIONS(description='Zum Verkaufspreis bewerteter Bestand aus vksal'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, dat_von) NOT ENFORCED
) CLUSTER BY dat_bis
OPTIONS(description='TP2_AIS - Diese Tabelle bildet den gleitenden Durchschnittspreis aus der SAP Tabelle MBEW ab - nur für Märkte - MULTISET');