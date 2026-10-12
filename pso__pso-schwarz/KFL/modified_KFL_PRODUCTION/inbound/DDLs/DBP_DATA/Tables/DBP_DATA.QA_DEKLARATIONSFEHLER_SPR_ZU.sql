--==============================================================
-- Table: qa_deklarationsfehler_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: qa_deklarationsfehler_spr_zu
   generated from Powerdesigner on Mittwoch, 28. Februar 2024 10:49:01
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.QA_DEKLARATIONSFEHLER_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   qa_deklarationsfehler_id            VARCHAR(3)       NOT NULL COMMENT 'ID der QA-Deklarationsfehler (, z. B. 002 = Etikett fehlt)',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   qa_deklarationsfehler_bez           VARCHAR(50)      COMMENT 'Bezeichnung der QA-Deklarationsfehler.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_QA_DEKLARATIONSFEHLER_SPR_ZU PRIMARY KEY (mandant_id, qa_deklarationsfehler_id, spr_id) NOT ENFORCED
)  COMMENT = 'Texte für QA-Deklarationsfehler Codes, z. B. 002 = Etikett fehlt';
