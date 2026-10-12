--==============================================================
-- Table: fanquote
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fanquote
   generated from Powerdesigner on Mittwoch, 18. August 2021 16:48:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.fanquote (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   matching_id                         NUMBER(38,0)    NOT NULL COMMENT 'Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden',
   kjwo_update                         NUMBER(38,0)    NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   d423_fanquote                       NUMBER(6,4)     DEFAULT 0 COMMENT 'Die Fanquote beschreibt wie viel % der Kunden, die den Artikel gekauft haben, auch tatsächliche Fans des Artikels sind, also den Artikel wiederholt kaufen.',
   a507_umsatz_cardholder              NUMBER(18,4)    DEFAULT 0 COMMENT 'Umsatz an einem Tag, an dem der Artikel verfuegbar war, der durch Kunden mit einer Kundenkarte fuer diesen Artikel generiert wurden.',
   a508_anteil_SA_cardholder           NUMBER(6,4)     DEFAULT 0 COMMENT 'Anteil des Umsatzes, der generiert wurde, als der Artikel in Aktion (SA) war im Verhaeltnis zum gesamten Umsatz, der durch Kunden mit einer Kundenkarte generiert wurde.',
   a509_anz_kaeufer                    NUMBER(38,0)    DEFAULT 0 COMMENT 'Anzahl der Kaeufer des Artikels mit Kundenkarte, die in entsprechender Beduerfnisklasse im letzten Jahr mehr als 3 Mal eingekauft haben.',
   substitute_matching_id              VARCHAR(750)    collate 'en-ci' COMMENT 'Liste aller Ersatz Matching IDs'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'In Hadoop berechnete u. gelieferte Fanquote auf Ebene matching_id.';