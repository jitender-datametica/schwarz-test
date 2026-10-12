--==============================================================
-- Table: abschriftart_abschriftgrp_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_abschriftgrp_zu
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABSCHRIFTART_ABSCHRIFTGRP_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   abschriftart_id                     INTEGER     NOT NULL COMMENT 'Abschriftenart  -  numerisch',
   abschriftgruppe_id                  INTEGER     NOT NULL COMMENT 'Merkmal zur Gruppierung der Abschriften',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABSCHRIFTART_ABSCHRIFTGRP_ZU PRIMARY KEY (mandant_id, abschriftart_id, abschriftgruppe_id) NOT ENFORCED
)  COMMENT = 'VIS - Gruppierung von Abschriftenarten';

