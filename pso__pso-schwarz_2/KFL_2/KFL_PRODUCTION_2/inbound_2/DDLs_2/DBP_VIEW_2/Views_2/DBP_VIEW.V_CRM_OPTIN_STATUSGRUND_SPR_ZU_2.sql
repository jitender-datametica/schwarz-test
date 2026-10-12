CREATE OR REPLACE VIEW DBP_VIEW.V_CRM_OPTIN_STATUSGRUND_SPR_ZU_2 (
   crm_optin_statusgrund_cd                 COMMENT 'Statusgrund-Code des Optins (liefert Information darüber, ob Erlaubnis erteilt, Erlaubnis nicht erteilt).'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,crm_optin_statusgrund_bez                COMMENT 'Statusgrund-Bezeichnung des Optins.'
)
COMMENT = 'CRM - Sprachtabelle fuer Optin-Statusgrund aus Cosmos DB CRM.'
 AS 
    SELECT 
        crm_optin_statusgrund_cd,
        spr_id,
        crm_optin_statusgrund_bez

FROM DBP_DATA.CRM_OPTIN_STATUSGRUND_SPR_ZU_2 ;