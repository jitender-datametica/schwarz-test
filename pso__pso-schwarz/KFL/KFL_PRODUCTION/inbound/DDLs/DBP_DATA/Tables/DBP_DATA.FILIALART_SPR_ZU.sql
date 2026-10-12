--==============================================================
-- Table: filialart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: filialart_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FILIALART_SPR_ZU (
   filialart_id                        NUMBER(38,0)     NOT NULL COMMENT 'ID der Filialart, z.B. 1 = Stammfiliale, 2 = Durchsetzungsfiliale',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   filialart_bez                       VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Filialart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FILIALART_SPR_ZU PRIMARY KEY (filialart_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Filialart Sprachzuordnung';

