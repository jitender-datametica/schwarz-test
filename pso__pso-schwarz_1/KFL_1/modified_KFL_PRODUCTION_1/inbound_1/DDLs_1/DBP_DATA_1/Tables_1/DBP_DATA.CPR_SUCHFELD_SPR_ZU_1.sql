--==============================================================
-- Table: cpr_suchfeld_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_suchfeld_spr_zu_1
   generated from Powerdesigner on Dienstag, 27. Juni 2023 17:54:10
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_SUCHFELD_SPR_ZU_1 (
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
   cpr_suchfeld_id                     INTEGER     NOT NULL COMMENT 'Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert',
   suchfeld_bez                        VARCHAR(60)      COLLATE 'en-ci' COMMENT 'zusätzliche Bezeichnung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_SUCHFELD_SPR_ZU PRIMARY KEY (spr_id, cpr_suchfeld_id) NOT ENFORCED
)  COMMENT = 'IOS - sprachabhängige Bezeichnungen für das C-Projects Suchfeld';