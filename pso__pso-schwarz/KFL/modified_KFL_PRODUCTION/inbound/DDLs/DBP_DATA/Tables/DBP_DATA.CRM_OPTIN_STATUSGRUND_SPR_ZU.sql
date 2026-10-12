--==============================================================
-- Table: crm_optin_statusgrund_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_optin_statusgrund_spr_zu
   generated from Powerdesigner on Montag, 15. September 2025 15:20:57
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_OPTIN_STATUSGRUND_SPR_ZU (
   crm_optin_statusgrund_cd            VARCHAR(20)      NOT NULL COMMENT 'Statusgrund-Code des Optins (liefert Information darüber, ob Erlaubnis erteilt, Erlaubnis nicht erteilt).',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   crm_optin_statusgrund_bez           VARCHAR(30)      COMMENT 'Statusgrund-Bezeichnung des Optins.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_OPTIN_STATUSGRUND_SPR_ZU PRIMARY KEY (crm_optin_statusgrund_cd, spr_id) NOT ENFORCED
)  COMMENT = 'CRM - Sprachtabelle fuer Optin-Statusgrund aus Cosmos DB CRM.';
