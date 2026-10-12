--==============================================================
-- Table: l_verkaufsmoebel
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_verkaufsmoebel
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 14:52:22
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_VERKAUFSMOEBEL (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   verkaufsmoebel_id                   INTEGER     NOT NULL COMMENT 'ID des Verkaufsmöbels - Ein Verkaufsmöbel ist der Gegenstand auf / in dem die Artikel in der Filiale verkauft werden.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_VERKAUFSMOEBEL PRIMARY KEY (mandant_id, verkaufsmoebel_id) NOT ENFORCED
)  COMMENT = 'Beinhaltet alle möglichen Verkaufsmöbel die eine Filiale nutzen kann. Ein Verkaufsmöbel ist der Gegenstand auf / in dem die Artikel in der Filiale verkauft werden.';
