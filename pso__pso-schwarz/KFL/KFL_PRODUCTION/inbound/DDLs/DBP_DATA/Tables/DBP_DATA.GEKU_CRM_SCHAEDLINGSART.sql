--==============================================================
-- Table: geku_crm_schaedlingsart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_schaedlingsart
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_CRM_SCHAEDLINGSART (
   geku_crm_schaedlingsart_id          NUMBER(38,0)     NOT NULL COMMENT 'Mapping ID',
   schaedlingsart_id                   NUMBER(38,0)     COMMENT 'Schaedlingsart ID aus GEKU',
   crm_schaedlingsart_id               NUMBER(38,0)     COMMENT 'Schaedlingsart ID aus CRM',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_CRM_SCHAEDLINGSART PRIMARY KEY (geku_crm_schaedlingsart_id) NOT ENFORCED
)  COMMENT = 'Mapping Tabelle Geku CRM für Schaedlingsarten';

