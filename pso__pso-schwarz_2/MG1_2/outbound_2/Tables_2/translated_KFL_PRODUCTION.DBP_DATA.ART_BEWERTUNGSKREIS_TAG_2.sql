DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ART_BEWERTUNGSKREIS_TAG_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_BEWERTUNGSKREIS_TAG_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
BEWERTUNGSKREIS_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt  '),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
DAT_GLD DATE NOT NULL OPTIONS(description='Datum, zu dem der GLD ermittelt wurde'),
PREIS_STEUER_KZ STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Preissteuerkennzeichen.S= S- Preis, V=GLD'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
GLD NUMERIC(18,6) NOT NULL
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Ist unabhängig vom preis_steuer_kz vorhanden'),
STANDARD_PREIS NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Standardpreis ist nur bei entsprechend gesetztem preis_steuer_kz gefüllt (S)'),
MENGE_BESTAND_BME NUMERIC(18,3) NOT NULL OPTIONS(description='Gesamtbestand in Basismengeneinheiten'),
WERT_BESTAND NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Entspricht nicht dem Produkt aus Menge und Preis und muss daher als eigener Wert gespeichert werden'),
VK_WERT NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Zum Verkaufspreis bewerteter Bestand'),
ZEIT_EXTRAKT INTEGER NOT NULL OPTIONS(description='Zeitpunkt der Erzeugung der Schnittstellendatei'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_ID, DAT_GLD) NOT ENFORCED
) CLUSTER BY MANDANT_ID, GLD, DAT_GLD
OPTIONS(description='TP408_LVS - Diese Tabelle bildet den gleitenden Durchschnittspreis aus der SAP Tabelle MBEW ab - nur für Läger - MULTISET');