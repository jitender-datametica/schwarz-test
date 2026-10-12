--==============================================================
-- Table: crm_optin_kanal_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_optin_kanal_spr_zu_2
   generated from Powerdesigner on Montag, 15. September 2025 15:27:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_OPTIN_KANAL_SPR_ZU_2 (
   crm_optin_kanal_cd                  VARCHAR(50)      NOT NULL COMMENT 'CRM-interne Code für den Kanal des Optins.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   crm_optin_kanal_bez                 VARCHAR(200)     COMMENT 'Bezeichnug für den Kanal des Optins.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_OPTIN_KANAL_SPR_ZU PRIMARY KEY (crm_optin_kanal_cd, spr_id) NOT ENFORCED
)  COMMENT = 'CRM - Sprachtabelle fuer die Opt-In Kanäle aus Cosmos DB CRM.';
