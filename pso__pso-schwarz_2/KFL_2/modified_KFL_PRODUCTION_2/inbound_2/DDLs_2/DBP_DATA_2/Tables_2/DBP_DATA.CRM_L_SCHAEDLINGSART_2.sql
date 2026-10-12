--==============================================================
-- Table: crm_l_schaedlingsart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_schaedlingsart_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_SCHAEDLINGSART_2 (
   crm_schaedlingsart_id               INTEGER     NOT NULL COMMENT 'Schädlingsart ID',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_SCHAEDLINGSART PRIMARY KEY (crm_schaedlingsart_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup für Schaedlingsart - MS Dynamics CRM';

