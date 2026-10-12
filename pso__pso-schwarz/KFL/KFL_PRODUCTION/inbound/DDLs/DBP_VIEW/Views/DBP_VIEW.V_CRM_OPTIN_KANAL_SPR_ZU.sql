CREATE OR REPLACE VIEW DBP_VIEW.V_CRM_OPTIN_KANAL_SPR_ZU (
   crm_optin_kanal_cd                       COMMENT 'CRM-interne Code für den Kanal des Optins.'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,crm_optin_kanal_bez                      COMMENT 'Bezeichnug für den Kanal des Optins.'
)
COMMENT = 'CRM - Sprachtabelle fuer die Opt-In Kanäle aus Cosmos DB CRM.'
 AS 
    SELECT 
        crm_optin_kanal_cd,
        spr_id,
        crm_optin_kanal_bez

FROM DBP_DATA.CRM_OPTIN_KANAL_SPR_ZU ;