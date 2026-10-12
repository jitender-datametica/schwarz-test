--==============================================================
-- Table: verkaufsmoebel_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: verkaufsmoebel_spr_zu_2
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 14:55:56
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.VERKAUFSMOEBEL_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   verkaufsmoebel_id                   INTEGER     NOT NULL COMMENT 'ID des Verkaufsmöbels - Ein Verkaufsmöbel ist der Gegenstand auf / in dem die Artikel_2 in der Filiale verkauft werden.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   verkaufsmoebel_bez                  VARCHAR(100)     COMMENT 'Bezeichnung des Verkaufsmöbels.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VERKAUFSMOEBEL_SPR_ZU PRIMARY KEY (mandant_id, verkaufsmoebel_id, spr_id) NOT ENFORCED
)  COMMENT = 'Bezeichnungen der Verkaufsmöbel in unterschiedlichen Sprachen.';
