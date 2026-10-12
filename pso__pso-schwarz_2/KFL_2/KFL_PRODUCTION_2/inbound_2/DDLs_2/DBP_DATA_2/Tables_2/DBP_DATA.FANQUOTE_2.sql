--==============================================================
-- Table: fanquote_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fanquote_2
   generated from Powerdesigner on Mittwoch, 18. August 2021 16:48:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.fanquote_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   matching_id                         NUMBER(38,0)    NOT NULL COMMENT 'Gruppierungskriterium für Artikel_2 (kann auch nur ein Artikel_2 sein), die über die GTIN zu Nielsen-Artikel_2 gematched werden',
   kjwo_update                         NUMBER(38,0)    NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   d423_fanquote                       NUMBER(6,4)     DEFAULT 0 COMMENT 'Die Fanquote_2 beschreibt wie viel % der Kunden, die den Artikel_2 gekauft haben, auch tatsächliche Fans des Artikels sind, also den Artikel_2 wiederholt kaufen.',
   a507_umsatz_cardholder              NUMBER(18,4)    DEFAULT 0 COMMENT 'Umsatz an einem Tag_2, an dem der Artikel_2 verfuegbar war, der durch Kunden mit einer Kundenkarte fuer diesen Artikel_2 generiert wurden.',
   a508_anteil_SA_cardholder           NUMBER(6,4)     DEFAULT 0 COMMENT 'Anteil des Umsatzes, der generiert wurde, als der Artikel_2 in Aktion_2 (SA) war im Verhaeltnis zum gesamten Umsatz, der durch Kunden mit einer Kundenkarte generiert wurde.',
   a509_anz_kaeufer                    NUMBER(38,0)    DEFAULT 0 COMMENT 'Anzahl der Kaeufer des Artikels mit Kundenkarte, die in entsprechender Beduerfnisklasse im letzten Jahr mehr als 3 Mal eingekauft haben.',
   substitute_matching_id              VARCHAR(750)    collate 'en-ci' COMMENT 'Liste aller Ersatz Matching IDs'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'In Hadoop berechnete u. gelieferte Fanquote_2 auf Ebene matching_id.';