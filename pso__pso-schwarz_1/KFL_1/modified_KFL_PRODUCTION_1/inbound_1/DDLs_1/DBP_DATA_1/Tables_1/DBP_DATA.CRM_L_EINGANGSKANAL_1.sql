--==============================================================
-- Table: crm_l_eingangskanal_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_eingangskanal_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_EINGANGSKANAL_1 (
   crm_eingangskanal_id                INTEGER     NOT NULL COMMENT 'Eingangskanal ID - z.B. Telefon, Email, etc.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_EINGANGSKANAL PRIMARY KEY (crm_eingangskanal_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup für Eingangskanal - MS Dynamics CRM';

