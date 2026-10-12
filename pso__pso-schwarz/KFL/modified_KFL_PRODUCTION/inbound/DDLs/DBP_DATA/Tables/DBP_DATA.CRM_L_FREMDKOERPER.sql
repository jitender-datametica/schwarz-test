--==============================================================
-- Table: crm_l_fremdkoerper
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_fremdkoerper
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_FREMDKOERPER (
   crm_fremdkoerper_id                 INTEGER     NOT NULL COMMENT 'Art der Verunreinigung ID',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_FREMDKOERPER PRIMARY KEY (crm_fremdkoerper_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup für Fremdkörper - MS Dynamics CRM';

