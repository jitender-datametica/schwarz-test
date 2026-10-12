--==============================================================
-- Table: crm_kunde_optin_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_kunde_optin_zu_1
   generated from Powerdesigner on Montag, 15. September 2025 14:49:16
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_kunde_optin_zu_1 (
crm_kunde_id STRING(36) NOT NULL OPTIONS(description='CRM-interne ID des Kunden'),
crm_optin_id STRING(36) NOT NULL OPTIONS(description='CRM-interne ID für ein Optin '),
zeit_erstellung TIMESTAMP NOT NULL
OPTIONS(description='Zeit_1 zu welcher der User erstmals das Optin angenommen hat'),
zeit_aenderung TIMESTAMP NOT NULL
OPTIONS(description='Zeit_1 zu welcher das Optin vom User zuletzt geändert wurde'),
bonuspunkte_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sagt aus ob der User durch die Aktivierung des Optins Bonuspunkte bekommen hat '),
optin_versions_url STRING(100) DEFAULT '0' NOT NULL
OPTIONS(description='URL aus der herausgelesen werden kann, welche Version des Optins der User zuletzt akzeptiert/abgelehnt hat'),
crm_optin_statusgrund_cd STRING(20) NOT NULL
OPTIONS(description='Statusgrund-Code des Optins (liefert Information darüber, ob Erlaubnis erteilt, Erlaubnis nicht erteilt).'),
aktiv_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag das anzeigt, ob der Kunde das Optin aktiviert hat oder ob es inaktiv ist'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_kunde_id, crm_optin_id) NOT ENFORCED
)
OPTIONS(description='CRM - Zuordnungstabelle. Jeder Kunde (crm_kunde_id) kann Optins (crm_optin_id) - bspw. SMS Versand, E-Mail Versand, Terms and Conditions - akzeptieren oder ablehnen.');