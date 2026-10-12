--==============================================================
-- Table: crm_l_eigenmarke
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_eigenmarke
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_EIGENMARKE (
   crm_eigenmarke_id                   INTEGER     NOT NULL COMMENT 'Eigenmarke ID',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_EIGENMARKE PRIMARY KEY (crm_eigenmarke_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup für die Kaufland Eigenmarken - MS Dynamics CRM';

