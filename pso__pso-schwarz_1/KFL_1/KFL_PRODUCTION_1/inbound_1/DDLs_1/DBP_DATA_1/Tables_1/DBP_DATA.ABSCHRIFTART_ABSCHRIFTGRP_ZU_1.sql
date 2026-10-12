--==============================================================
-- Table: abschriftart_abschriftgrp_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_abschriftgrp_zu_1
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABSCHRIFTART_ABSCHRIFTGRP_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   abschriftart_id                     NUMBER(38,0)     NOT NULL COMMENT 'Abschriftenart  -  numerisch',
   abschriftgruppe_id                  NUMBER(38,0)     NOT NULL COMMENT 'Merkmal zur Gruppierung der Abschriften_1',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABSCHRIFTART_ABSCHRIFTGRP_ZU PRIMARY KEY (mandant_id, abschriftart_id, abschriftgruppe_id) NOT ENFORCED
)  COMMENT = 'VIS - Gruppierung von Abschriftenarten';

