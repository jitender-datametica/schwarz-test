--==============================================================
-- Table: crm_l_gutschein_grund
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_gutschein_grund
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_GUTSCHEIN_GRUND (
   crm_gutschein_grund_id              INTEGER     NOT NULL COMMENT 'Grund der Gutscheinausgabe ID',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_GUTSCHEIN_GRUND PRIMARY KEY (crm_gutschein_grund_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup für Gutscheinausgabegrund - MS Dynamics CRM';

