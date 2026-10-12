--==============================================================
-- Table: geku_crm_gutschein_grund_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_gutschein_grund_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_CRM_GUTSCHEIN_GRUND_1 (
   geku_crm_gutschein_grund_id         NUMBER(38,0)     NOT NULL COMMENT 'Mapping ID',
   ausgeber_id                         VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Gutschein_1 Grund Id aus GEKU',
   crm_gutschein_grund_id              NUMBER(38,0)     COMMENT 'Grund der Gutscheinausgabe ID',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_CRM_GUTSCHEIN_GRUND PRIMARY KEY (geku_crm_gutschein_grund_id) NOT ENFORCED
)  COMMENT = 'Mapping Tabelle Geku CRM für Gutschein_1 Grund';

