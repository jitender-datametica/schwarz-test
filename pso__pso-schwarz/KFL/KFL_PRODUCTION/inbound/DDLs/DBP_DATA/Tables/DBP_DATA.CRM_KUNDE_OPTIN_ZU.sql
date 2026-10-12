--==============================================================
-- Table: crm_kunde_optin_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_kunde_optin_zu
   generated from Powerdesigner on Montag, 15. September 2025 14:49:16
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_KUNDE_OPTIN_ZU (
   crm_kunde_id                        VARCHAR(36)      NOT NULL COMMENT 'CRM-interne ID des Kunden',
   crm_optin_id                        VARCHAR(36)      NOT NULL COMMENT 'CRM-interne ID für ein Optin ',
   zeit_erstellung                     TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeit zu welcher der User erstmals das Optin angenommen hat',
   zeit_aenderung                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeit zu welcher das Optin vom User zuletzt geändert wurde',
   bonuspunkte_fg                      NUMBER(38,0)     NOT NULL COMMENT 'Sagt aus ob der User durch die Aktivierung des Optins Bonuspunkte bekommen hat ',
   optin_versions_url                  VARCHAR(100)     NOT NULL DEFAULT '0' COMMENT 'URL aus der herausgelesen werden kann, welche Version des Optins der User zuletzt akzeptiert/abgelehnt hat',
   crm_optin_statusgrund_cd            VARCHAR(20)      NOT NULL COMMENT 'Statusgrund-Code des Optins (liefert Information darüber, ob Erlaubnis erteilt, Erlaubnis nicht erteilt).',
   aktiv_fg                            NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Flag das anzeigt, ob der Kunde das Optin aktiviert hat oder ob es inaktiv ist',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_KUNDE_OPTIN_ZU PRIMARY KEY (crm_kunde_id, crm_optin_id) NOT ENFORCED
)  COMMENT = 'CRM - Zuordnungstabelle. Jeder Kunde (crm_kunde_id) kann Optins (crm_optin_id) - bspw. SMS Versand, E-Mail Versand, Terms and Conditions - akzeptieren oder ablehnen.';
