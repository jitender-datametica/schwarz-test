create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_KUNDE_OPTIN_ZU (
	CRM_KUNDE_ID VARCHAR(144) NOT NULL COMMENT 'CRM-interne ID des Kunden',
	CRM_OPTIN_ID VARCHAR(144) NOT NULL COMMENT 'CRM-interne ID für ein Optin ',
	ZEIT_ERSTELLUNG TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeit zu welcher der User erstmals das Optin angenommen hat',
	ZEIT_AENDERUNG TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeit zu welcher das Optin vom User zuletzt geändert wurde',
	BONUSPUNKTE_FG NUMBER(38,0) NOT NULL COMMENT 'Sagt aus ob der User durch die Aktivierung des Optins Bonuspunkte bekommen hat ',
	OPTIN_VERSIONS_URL VARCHAR(400) NOT NULL DEFAULT '0' COMMENT 'URL aus der herausgelesen werden kann, welche Version des Optins der User zuletzt akzeptiert/abgelehnt hat',
	OPTIN_STATUSGRUND_ID NUMBER(38,0) NOT NULL DEFAULT -9999 COMMENT 'Statusgrund-ID des Optins (liefert Information darüber, wieso das Optin für den Kunden aktiv oder inaktiv ist (aktiv_fg), bspw. Erlaubnis erteilt, Erlaubnis nicht erteilt, Erlaubnis entzogen)',
	AKTIV_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Flag das anzeigt, ob der Kunde das Optin aktiviert hat oder ob es inaktiv ist',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='CRM - Zuordnungstabelle. Jeder Kunde (crm_kunde_id) kann Optins (crm_optin_id) - bspw. SMS Versand, E-Mail Versand, Terms and Conditions - akzeptieren oder ablehnen.'
;