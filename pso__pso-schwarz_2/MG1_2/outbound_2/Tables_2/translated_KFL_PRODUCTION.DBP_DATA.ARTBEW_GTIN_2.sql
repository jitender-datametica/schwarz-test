DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ARTBEW_GTIN_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTBEW_GTIN_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Markt'),
DAT DATE NOT NULL OPTIONS(description='Datum, Format YYYY-MM_2-DD'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
BEWART_ID INTEGER NOT NULL OPTIONS(description='1001 AF, 1002 SA'),
AKTION_ID STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Aktionsnummer wie von den Kassen gemeldet (bei Kassensystem POSITION über Stammdaten angereichert)'),
PROMO_FG INTEGER NOT NULL
OPTIONS(description='Das Promotion-Flag kennzeichnet einen Promotion-Artikel_2 (z.Bsp. 3 für 2)'),
EAN_KASSE INTEGER NOT NULL OPTIONS(description='von den Kassensystemen gelieferte EAN_2'),
NB_ID INTEGER OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
HERST_ID INTEGER OPTIONS(description='Hersteller fall abweichend zum Lieferanten'),
MWST_ID INTEGER NOT NULL OPTIONS(description='Schlüssel des Mehrwertsteuersatzes'),
WRG_2 STRING(3) COLLATE 'und:ci' OPTIONS(description='Währung, in der der Umsatz erzielt wurde'),
MENGE NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)'),
UMSATZ_NETTO NUMERIC(18,4) OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
DIFF_UMSATZ_NETTO_KONZ NUMERIC(18,4) OPTIONS(description='von der Konzernwährung abweichender Umsatz netto'),
UMSATZ_MWST_BETRAG NUMERIC(18,4)
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_2 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
DIFF_UMSATZ_MWST_BETRAG_KONZ NUMERIC(18,4)
OPTIONS(description='von der Konzernwährung abweichender Mehrwertsteuerbetrag'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, DAT, ART_ID, GP_ID, BEWART_ID, PROMO_FG, EAN_KASSE) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT
OPTIONS(description='Aggregat aus Bons aller Länder (auch für POSITION statt WPUUMS). Benötigt für Marktforschungsinstitute, die Abverkäufe auf Ebene GTIN brauchen. Tabelle nicht mehr relevant wenn Umstellung auf KPOS ausgerollt.');