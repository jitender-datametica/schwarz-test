CREATE OR REPLACE VIEW DBP_VIEW.V_CRM_KUNDE_OPTIN_ZU_1 (
   crm_kunde_id                             COMMENT 'CRM-interne ID des Kunden'
  ,crm_optin_id                             COMMENT 'CRM-interne ID für ein Optin '
  ,zeit_erstellung                          COMMENT 'Zeit_1 zu welcher der User erstmals das Optin angenommen hat'
  ,zeit_aenderung                           COMMENT 'Zeit_1 zu welcher das Optin vom User zuletzt geändert wurde'
  ,bonuspunkte_fg                           COMMENT 'Sagt aus ob der User durch die Aktivierung des Optins Bonuspunkte bekommen hat '
  ,optin_versions_url                       COMMENT 'URL aus der herausgelesen werden kann, welche Version des Optins der User zuletzt akzeptiert/abgelehnt hat'
  ,crm_optin_statusgrund_cd                 COMMENT 'Statusgrund-Code des Optins (liefert Information darüber, ob Erlaubnis erteilt, Erlaubnis nicht erteilt).'
  ,aktiv_fg                                 COMMENT 'Flag das anzeigt, ob der Kunde das Optin aktiviert hat oder ob es inaktiv ist'
)
COMMENT = 'CRM - Zuordnungstabelle. Jeder Kunde (crm_kunde_id) kann Optins (crm_optin_id) - bspw. SMS Versand, E-Mail Versand, Terms and Conditions - akzeptieren oder ablehnen.'
 AS 
    SELECT 
        crm_kunde_id,
        crm_optin_id,
        zeit_erstellung,
        zeit_aenderung,
        bonuspunkte_fg,
        optin_versions_url,
        crm_optin_statusgrund_cd,
        aktiv_fg

FROM DBP_DATA.CRM_KUNDE_OPTIN_ZU_1 ;