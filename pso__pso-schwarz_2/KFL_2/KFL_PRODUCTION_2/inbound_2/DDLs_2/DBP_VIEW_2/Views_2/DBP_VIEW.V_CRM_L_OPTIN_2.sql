CREATE OR REPLACE VIEW DBP_VIEW.V_CRM_L_OPTIN_2 (
   crm_optin_id                             COMMENT 'CRM-interne ID für ein Optin '
  ,crm_loyalty_fg                           COMMENT 'Sagt ob die Herkunft/ der Uprsung ist die Loyalty App.'
  ,crm_optin_kanal_cd                       COMMENT 'CRM-interne Code für den Kanal des Optins.'
)
COMMENT = 'CRM - Enthaelt Optin Daten aus Cosmos DB CRM.'
 AS 
    SELECT 
        crm_optin_id,
        crm_loyalty_fg,
        crm_optin_kanal_cd

FROM DBP_DATA.CRM_L_OPTIN_2 ;