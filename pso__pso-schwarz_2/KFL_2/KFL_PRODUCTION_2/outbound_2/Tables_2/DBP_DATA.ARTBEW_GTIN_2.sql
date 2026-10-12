--==============================================================
-- Table: artbew_gtin_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_gtin_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_gtin_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Markt'),
dat DATE NOT NULL OPTIONS(description='Datum, Format YYYY-MM_2-DD'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
bewart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='1001 AF, 1002 SA'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Aktionsnummer wie von den Kassen gemeldet (bei Kassensystem POSITION über Stammdaten angereichert)'),
promo_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Promotion-Flag kennzeichnet einen Promotion-Artikel_2 (z.Bsp. 3 für 2)'),
ean_kasse NUMERIC(26,0) NOT NULL OPTIONS(description='von den Kassensystemen gelieferte EAN_2'),
herst_id BIGNUMERIC(38,0) OPTIONS(description='Hersteller fall abweichend zum Lieferanten'),
mwst_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Schlüssel des Mehrwertsteuersatzes'),
wrg_2 STRING(3) COLLATE 'und:ci' OPTIONS(description='Währung, in der der Umsatz erzielt wurde'),
menge NUMERIC(18,3)
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)'),
umsatz_netto NUMERIC(18,4) OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
diff_umsatz_netto_konz NUMERIC(18,4) OPTIONS(description='von der Konzernwährung abweichender Umsatz netto'),
umsatz_mwst_betrag NUMERIC(18,4)
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_2 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
diff_umsatz_mwst_betrag_konz NUMERIC(18,4)
OPTIONS(description='von der Konzernwährung abweichender Mehrwertsteuerbetrag'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, dat, art_id, gp_id, bewart_id, promo_fg, ean_kasse) NOT ENFORCED
) CLUSTER BY mandant_id, dat
OPTIONS(description='Aggregat aus Bons aller Länder (auch für POSITION statt WPUUMS). Benötigt für Marktforschungsinstitute, die Abverkäufe auf Ebene GTIN brauchen. Tabelle nicht mehr relevant wenn Umstellung auf KPOS ausgerollt.');