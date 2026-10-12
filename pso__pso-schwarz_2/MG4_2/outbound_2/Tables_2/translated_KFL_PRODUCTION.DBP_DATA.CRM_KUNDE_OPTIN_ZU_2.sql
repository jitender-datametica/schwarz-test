CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_kunde_optin_zu_2 (
crm_kunde_id STRING(144) NOT NULL OPTIONS(description='CRM-interne ID des Kunden'),
crm_optin_id STRING(144) NOT NULL OPTIONS(description='CRM-interne ID für ein Optin '),
zeit_erstellung DATETIME NOT NULL OPTIONS(description='Zeit_2 zu welcher der User erstmals das Optin angenommen hat'),
zeit_aenderung DATETIME NOT NULL OPTIONS(description='Zeit_2 zu welcher das Optin vom User zuletzt geändert wurde'),
bonuspunkte_fg INTEGER NOT NULL
OPTIONS(description='Sagt aus ob der User durch die Aktivierung des Optins Bonuspunkte bekommen hat '),
optin_versions_url STRING(400) DEFAULT '0' NOT NULL
OPTIONS(description='URL aus der herausgelesen werden kann, welche Version des Optins der User zuletzt akzeptiert/abgelehnt hat'),
optin_statusgrund_id INTEGER DEFAULT - 9999 NOT NULL
OPTIONS(description='Statusgrund-ID des Optins (liefert Information darüber, wieso das Optin für den Kunden aktiv oder inaktiv ist (aktiv_fg), bspw. Erlaubnis erteilt, Erlaubnis nicht erteilt, Erlaubnis entzogen)'),
aktiv_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag das anzeigt, ob der Kunde das Optin aktiviert hat oder ob es inaktiv ist'),
td_insert TIMESTAMP,
td_update TIMESTAMP
)
OPTIONS(description='CRM - Zuordnungstabelle. Jeder Kunde (crm_kunde_id) kann Optins (crm_optin_id) - bspw. SMS Versand, E-Mail Versand, Terms and Conditions - akzeptieren oder ablehnen.');