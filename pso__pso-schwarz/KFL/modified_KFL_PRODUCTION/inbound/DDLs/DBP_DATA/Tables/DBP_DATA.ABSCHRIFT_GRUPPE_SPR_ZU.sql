--==============================================================
-- Table: abschrift_gruppe_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschrift_gruppe_spr_zu
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABSCHRIFT_GRUPPE_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   abschriftgruppe_id                  INTEGER     NOT NULL COMMENT 'Merkmal zur Gruppierung der Abschriften',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache ID',
   abschriftgrp_bez                    VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung der Abschriftengruppe
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABSCHRIFT_GRUPPE_SPR_ZU PRIMARY KEY (mandant_id, abschriftgruppe_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Sprachabhängige Bezeichnung der Abschriftenhierarchien (=gruppen)';

