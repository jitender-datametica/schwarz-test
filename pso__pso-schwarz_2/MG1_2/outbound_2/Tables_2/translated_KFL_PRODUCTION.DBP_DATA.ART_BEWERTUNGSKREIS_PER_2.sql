DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ART_BEWERTUNGSKREIS_PER_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_BEWERTUNGSKREIS_PER_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
BEWERTUNGSKREIS_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt. Aus bwkey\n\n            '),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
DAT_VON DATE NOT NULL OPTIONS(description='Datum, ab dem der Satz Gültigkeit hat'),
PREIS_STEUER_KZ STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Preissteuerkennzeichen.S= S- Preis, V=GLD. Aus vprsv'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
DAT_BIS DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT\n            '),
DAT_AENDERUNG DATE NOT NULL OPTIONS(description='Aenderungsdatum des Satzes im SAP Quellsystem.'),
ZEIT_AENDERUNG INTEGER NOT NULL OPTIONS(description='Aenderungszeitpunkt des Satzes im Quellsystem.'),
GLD NUMERIC(18,6) NOT NULL
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Ist unabhängig vom preis_steuer_kz vorhanden. Aus verpr'),
STANDARD_PREIS NUMERIC(18,4) NOT NULL
OPTIONS(description='Der Standardpreis ist nur bei entsprechend gesetztem preis_steuer_kz gefüllt (S). Aus stprs'),
MENGE_BESTAND_BME NUMERIC(18,3) NOT NULL
OPTIONS(description='Gesamtbestand in Basismengeneinheiten aus dem Quellfeld lbkum'),
WERT_BESTAND NUMERIC(18,4) NOT NULL
OPTIONS(description='Entspricht nicht dem Produkt aus Menge und Preis und muss daher als eigener Wert gespeichert werden. Aus salk3'),
VK_WERT NUMERIC(18,2) NOT NULL OPTIONS(description='Zum Verkaufspreis bewerteter Bestand aus vksal'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_ID, DAT_VON) NOT ENFORCED
) CLUSTER BY DAT_BIS
OPTIONS(description='TP2_AIS - Diese Tabelle bildet den gleitenden Durchschnittspreis aus der SAP Tabelle MBEW ab - nur für Märkte - MULTISET');