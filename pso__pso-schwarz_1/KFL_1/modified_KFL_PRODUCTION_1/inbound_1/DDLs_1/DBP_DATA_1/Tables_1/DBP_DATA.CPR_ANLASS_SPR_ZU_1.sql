--==============================================================
-- Table: cpr_anlass_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_anlass_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_ANLASS_SPR_ZU_1 (
   projekt_anlass_id                   VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'ID des Projektanlasses oder Veranlassers, z.Bsp. Vertrieb. Quelle ist cpr_cause',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
   projekt_anlass_bez                  VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Beschreibung des Projektanlasses, z.Bsp. Auftrag von Vertrieb. Quelle ist txtmd',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_ANLASS_SPR_ZU PRIMARY KEY (projekt_anlass_id, spr_id) NOT ENFORCED
)  COMMENT = 'IOS - sprachabhängige Bezeichnung des Projektanlasses aus der Quelltabelle cause';

