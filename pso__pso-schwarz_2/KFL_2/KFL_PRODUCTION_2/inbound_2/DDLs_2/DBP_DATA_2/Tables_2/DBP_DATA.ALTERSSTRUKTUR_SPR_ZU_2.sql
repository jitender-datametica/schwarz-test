--==============================================================
-- Table: altersstruktur_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: altersstruktur_spr_zu_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ALTERSSTRUKTUR_SPR_ZU_2 (
   altersstruktur_id                   NUMBER(38,0)     NOT NULL COMMENT 'ID der Altersstruktur, z.B. 1 = Stammfiliale, 2 = Durchsetzungsfiliale, 3 = Expansionsbereinigt',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   altersstruktur_bez                  VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Altersstruktur',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ALTERSSTRUKTUR_SPR_ZU PRIMARY KEY (altersstruktur_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Altersstruktur Sprachzuordnung';

