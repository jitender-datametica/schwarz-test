--==============================================================
-- Table: fanquote_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fanquote_1
   generated from Powerdesigner on Mittwoch, 18. August 2021 16:48:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.fanquote_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   matching_id                         INTEGER    NOT NULL COMMENT 'Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden',
   kjwo_update                         INTEGER    NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   d423_fanquote                       NUMBER(29,4)     DEFAULT 0 COMMENT 'Die Fanquote_1 beschreibt wie viel % der Kunden, die den Artikel_1 gekauft haben, auch tatsächliche Fans des Artikels sind, also den Artikel_1 wiederholt kaufen.',
   a507_umsatz_cardholder              NUMBER(29,4)    DEFAULT 0 COMMENT 'Umsatz an einem Tag_1, an dem der Artikel_1 verfuegbar war, der durch Kunden mit einer Kundenkarte fuer diesen Artikel_1 generiert wurden.',
   a508_anteil_SA_cardholder           NUMBER(29,4)     DEFAULT 0 COMMENT 'Anteil des Umsatzes, der generiert wurde, als der Artikel_1 in Aktion_1 (SA) war im Verhaeltnis zum gesamten Umsatz, der durch Kunden mit einer Kundenkarte generiert wurde.',
   a509_anz_kaeufer                    INTEGER    DEFAULT 0 COMMENT 'Anzahl der Kaeufer des Artikels mit Kundenkarte, die in entsprechender Beduerfnisklasse im letzten Jahr mehr als 3 Mal eingekauft haben.',
   substitute_matching_id              VARCHAR(750)    collate 'en-ci' COMMENT 'Liste aller Ersatz Matching IDs'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'In Hadoop berechnete u. gelieferte Fanquote_1 auf Ebene matching_id.';