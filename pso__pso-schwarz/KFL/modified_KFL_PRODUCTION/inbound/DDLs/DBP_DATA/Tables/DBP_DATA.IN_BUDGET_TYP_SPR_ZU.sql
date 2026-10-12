--==============================================================
-- Table: in_budget_typ_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_budget_typ_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_BUDGET_TYP_SPR_ZU (
   in_budget_typ_id                    VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID eines Budgettyps',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   in_budget_typ_bez                   VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Budgettyps',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_BUDGET_TYP_SPR_ZU PRIMARY KEY (in_budget_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMS - Sprachabhängige Bezeichnungen der Budgetypen aus SAP Industrie zco_budg_type_t';
