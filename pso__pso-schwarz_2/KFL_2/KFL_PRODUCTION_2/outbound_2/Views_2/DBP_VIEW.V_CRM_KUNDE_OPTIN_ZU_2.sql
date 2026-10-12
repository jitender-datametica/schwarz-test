CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_kunde_optin_zu_2 (crm_kunde_id
OPTIONS(description='CRM-interne ID des Kunden'), crm_optin_id OPTIONS(description='CRM-interne ID für ein Optin '),
zeit_erstellung OPTIONS(description='Zeit_2 zu welcher der User erstmals das Optin angenommen hat'), zeit_aenderung
OPTIONS(description='Zeit_2 zu welcher das Optin vom User zuletzt geändert wurde'), bonuspunkte_fg
OPTIONS(description='Sagt aus ob der User durch die Aktivierung des Optins Bonuspunkte bekommen hat '),
optin_versions_url
OPTIONS(description='URL aus der herausgelesen werden kann, welche Version des Optins der User zuletzt akzeptiert/abgelehnt hat'),
crm_optin_statusgrund_cd
OPTIONS(description='Statusgrund-Code des Optins (liefert Information darüber, ob Erlaubnis erteilt, Erlaubnis nicht erteilt).'),
aktiv_fg OPTIONS(description='Flag das anzeigt, ob der Kunde das Optin aktiviert hat oder ob es inaktiv ist'))
OPTIONS(DESCRIPTION = `CRM - ZUORDNUNGSTABELLE. JEDER KUNDE (CRM_KUNDE_ID) KANN OPTINS (CRM_OPTIN_ID) - BSPW. SMS VERSAND, E-MAIL VERSAND, TERMS AND CONDITIONS - AKZEPTIEREN ODER ABLEHNEN.`)
AS SELECT crm_kunde_id,
 crm_optin_id,
 zeit_erstellung,
 zeit_aenderung,
 bonuspunkte_fg,
 optin_versions_url,
 crm_optin_statusgrund_cd,
 aktiv_fg
FROM kfl_production_dbp_data.crm_kunde_optin_zu_2;