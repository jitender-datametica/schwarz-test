--==============================================================
-- Table: geku_crm_schaedlingsart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_schaedlingsart_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_CRM_SCHAEDLINGSART_2 (
   geku_crm_schaedlingsart_id          INTEGER     NOT NULL COMMENT 'Mapping ID',
   schaedlingsart_id                   INTEGER     COMMENT 'Schaedlingsart ID aus GEKU',
   crm_schaedlingsart_id               INTEGER     COMMENT 'Schaedlingsart ID aus CRM',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_CRM_SCHAEDLINGSART PRIMARY KEY (geku_crm_schaedlingsart_id) NOT ENFORCED
)  COMMENT = 'Mapping Tabelle Geku CRM für Schaedlingsarten';

