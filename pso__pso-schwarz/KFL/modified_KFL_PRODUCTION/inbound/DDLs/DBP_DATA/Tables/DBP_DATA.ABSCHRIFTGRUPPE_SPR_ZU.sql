--==============================================================
-- Table: abschriftgruppe_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftgruppe_spr_zu
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:47:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABSCHRIFTGRUPPE_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   abschriftgruppe_id                  INTEGER     NOT NULL COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.',
   abschriftgruppe_bez                 VARCHAR(100)     COMMENT 'Sprachabhängige Bezeichnung der Abschriftgruppe.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABSCHRIFTGRUPPE_SPR_ZU PRIMARY KEY (mandant_id, spr_id, abschriftgruppe_id) NOT ENFORCED
)  COMMENT = 'Sprachtabelle der Abschriftgruppen.';
