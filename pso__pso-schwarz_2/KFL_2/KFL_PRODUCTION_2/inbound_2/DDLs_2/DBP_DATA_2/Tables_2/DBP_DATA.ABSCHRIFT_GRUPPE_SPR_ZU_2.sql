--==============================================================
-- Table: abschrift_gruppe_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschrift_gruppe_spr_zu_2
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABSCHRIFT_GRUPPE_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   abschriftgruppe_id                  NUMBER(38,0)     NOT NULL COMMENT 'Merkmal zur Gruppierung der Abschriften_2',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprache ID',
   abschriftgrp_bez                    VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung der Abschriftengruppe
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABSCHRIFT_GRUPPE_SPR_ZU PRIMARY KEY (mandant_id, abschriftgruppe_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Sprachabhängige Bezeichnung der Abschriftenhierarchien (=gruppen)';

