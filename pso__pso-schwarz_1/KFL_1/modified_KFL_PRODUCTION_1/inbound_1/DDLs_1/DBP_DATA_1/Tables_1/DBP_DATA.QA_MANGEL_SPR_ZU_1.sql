--==============================================================
-- Table: qa_mangel_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: qa_mangel_spr_zu_1
   generated from Powerdesigner on Mittwoch, 28. Februar 2024 10:49:41
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.QA_MANGEL_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   qa_mangel_id                        VARCHAR(3)       NOT NULL COMMENT 'ID des QA-Mangel (z. B. 001 = Frischemangel)',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   qa_mangel_bez                       VARCHAR(50)      COMMENT 'Bezeichnung des QA-Mangel',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_QA_MANGEL_SPR_ZU PRIMARY KEY (mandant_id, qa_mangel_id, spr_id) NOT ENFORCED
)  COMMENT = 'Texte für QA-Mängel Codes, z. B. 001 = Frischemangel';
