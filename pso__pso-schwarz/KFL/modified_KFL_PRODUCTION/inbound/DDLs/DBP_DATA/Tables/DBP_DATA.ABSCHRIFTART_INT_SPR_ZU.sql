--==============================================================
-- Table: abschriftart_int_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_int_spr_zu
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABSCHRIFTART_INT_SPR_ZU (
   abschriftart_int_id                 INTEGER     NOT NULL COMMENT 'ID Einheitliche Abschriftart KL international (z.B. -1=Werbeabschriften)',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   abschriftart_int_bez                VARCHAR(40)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung Einheitliche Abschriftart KL international',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABSCHRIFTART_INT_SPR_ZU PRIMARY KEY (abschriftart_int_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Sprach-Tabelle für Einheitliche Abschriftenarten KL international';

