--==============================================================
-- Table: fipo_standard_text_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_standard_text_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_STANDARD_TEXT_SPR_ZU_1 (
   fipo_standard_text_id               NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines Standardtextes aus ste_id',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   fipo_standard_text                  VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Standardtext aus dem Quellfeld sti_text',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_STANDARD_TEXT_SPR_ZU PRIMARY KEY (fipo_standard_text_id, spr_id) NOT ENFORCED
)  COMMENT = 'FIPO - Sprachabhängige Bezeichnungen der FIPO-Standardtexte aus standardtexte_int';

