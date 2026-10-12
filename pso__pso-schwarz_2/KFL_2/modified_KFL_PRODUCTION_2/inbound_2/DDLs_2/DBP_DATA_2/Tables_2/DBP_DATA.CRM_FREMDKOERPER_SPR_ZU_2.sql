--==============================================================
-- Table: crm_fremdkoerper_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_fremdkoerper_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_FREMDKOERPER_SPR_ZU_2 (
   crm_fremdkoerper_id                 INTEGER     NOT NULL COMMENT 'Art_2 der Verunreinigung ID',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   crm_fremdkoerper_bez                VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Fremdkörper Bezeichnung DWH generiert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_FREMDKOERPER_SPR_ZU PRIMARY KEY (crm_fremdkoerper_id, spr_id) NOT ENFORCED
)  COMMENT = 'KMR - Sprachzuordnungstabelle Fremdkörper - MS Dynamics CRM';

