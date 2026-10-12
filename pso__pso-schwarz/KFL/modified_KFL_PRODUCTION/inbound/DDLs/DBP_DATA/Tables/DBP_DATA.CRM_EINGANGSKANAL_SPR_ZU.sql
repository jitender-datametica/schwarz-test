--==============================================================
-- Table: crm_eingangskanal_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_eingangskanal_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_EINGANGSKANAL_SPR_ZU (
   crm_eingangskanal_id                INTEGER     NOT NULL COMMENT 'Eingangskanal ID - z.B. Telefon, Email, etc.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   crm_eingangskanal_bez               VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Eingangskanal Bezeichnung DWH generiert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_EINGANGSKANAL_SPR_ZU PRIMARY KEY (crm_eingangskanal_id, spr_id) NOT ENFORCED
)  COMMENT = 'KMR - Sprachzuordnungstabelle Eingangskanal - MS Dynamics CRM';

