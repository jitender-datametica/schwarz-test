--==============================================================
-- Table: crm_l_optin_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_optin_2
   generated from Powerdesigner on Montag, 15. September 2025 15:15:22
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_OPTIN_2 (
   crm_optin_id                        VARCHAR(36)      NOT NULL COMMENT 'CRM-interne ID für ein Optin ',
   crm_loyalty_fg                      INTEGER     NOT NULL DEFAULT 0 COMMENT 'Sagt ob die Herkunft/ der Uprsung ist die Loyalty App.',
   crm_optin_kanal_cd                  VARCHAR(50)      NOT NULL COMMENT 'CRM-interne Code für den Kanal des Optins.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_OPTIN PRIMARY KEY (crm_optin_id) NOT ENFORCED
)  COMMENT = 'CRM - Enthaelt Optin Daten aus Cosmos DB CRM.';
