--==============================================================
-- Table: l_crm_gender
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_crm_gender
   generated from Powerdesigner on Donnerstag, 28. August 2025 10:50:04
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_CRM_GENDER (
   gender_id                           INTEGER     NOT NULL COMMENT 'ID für das Geschlecht des Kunden',
   gender_bez                          VARCHAR(50)      DEFAULT 'system generated' COMMENT 'Bezeichnung für das Geschlecht des Kunden.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_CRM_GENDER PRIMARY KEY (gender_id) NOT ENFORCED
)  COMMENT = 'CRM - Lookup Tabelle für SalutationCode aus Cosmos DB.';
