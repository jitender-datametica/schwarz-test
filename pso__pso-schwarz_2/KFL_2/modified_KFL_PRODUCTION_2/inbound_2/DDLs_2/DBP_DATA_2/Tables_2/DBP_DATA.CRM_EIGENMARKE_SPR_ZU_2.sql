--==============================================================
-- Table: crm_eigenmarke_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_eigenmarke_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_EIGENMARKE_SPR_ZU_2 (
   crm_eigenmarke_id                   INTEGER     NOT NULL COMMENT 'Eigenmarke ID',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   crm_eigenmarke_bez                  VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Eigenmarke Bezeichnung DWH generiert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_EIGENMARKE_SPR_ZU PRIMARY KEY (crm_eigenmarke_id, spr_id) NOT ENFORCED
)  COMMENT = 'KMR - Sprachzuordnungstabelle Eigenmarke - MS Dynamics CRM';

