--==============================================================
-- Table: fanquote_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fanquote_1
   generated from Powerdesigner on Mittwoch, 18. August 2021 16:48:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fanquote_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
matching_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden'),
kjwo_update BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
d423_fanquote NUMERIC(6,4) DEFAULT 0
OPTIONS(description='Die Fanquote_1 beschreibt wie viel % der Kunden, die den Artikel_1 gekauft haben, auch tatsächliche Fans des Artikels sind, also den Artikel_1 wiederholt kaufen.'),
a507_umsatz_cardholder NUMERIC(18,4) DEFAULT 0
OPTIONS(description='Umsatz an einem Tag_1, an dem der Artikel_1 verfuegbar war, der durch Kunden mit einer Kundenkarte fuer diesen Artikel_1 generiert wurden.'),
a508_anteil_sa_cardholder NUMERIC(6,4) DEFAULT 0
OPTIONS(description='Anteil des Umsatzes, der generiert wurde, als der Artikel_1 in Aktion_1 (SA) war im Verhaeltnis zum gesamten Umsatz, der durch Kunden mit einer Kundenkarte generiert wurde.'),
a509_anz_kaeufer BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Anzahl der Kaeufer des Artikels mit Kundenkarte, die in entsprechender Beduerfnisklasse im letzten Jahr mehr als 3 Mal eingekauft haben.'),
substitute_matching_id STRING(750) COLLATE 'und:ci' OPTIONS(description='Liste aller Ersatz Matching IDs'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='In Hadoop berechnete u. gelieferte Fanquote_1 auf Ebene matching_id.');