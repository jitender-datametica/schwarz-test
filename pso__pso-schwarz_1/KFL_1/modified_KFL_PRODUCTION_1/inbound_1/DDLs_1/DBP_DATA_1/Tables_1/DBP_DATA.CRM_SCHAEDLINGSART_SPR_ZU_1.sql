--==============================================================
-- Table: crm_schaedlingsart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_schaedlingsart_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_SCHAEDLINGSART_SPR_ZU_1 (
   crm_schaedlingsart_id               INTEGER     NOT NULL COMMENT 'Schädlingsart ID',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   crm_schaedlingsart_bez              VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Schädlingsart Bezeichnung DWH generiert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_SCHAEDLINGSART_SPR_ZU PRIMARY KEY (crm_schaedlingsart_id, spr_id) NOT ENFORCED
)  COMMENT = 'KMR - Sprachzuordnungstabelle Schädlingsart - MS Dynamics CRM';

