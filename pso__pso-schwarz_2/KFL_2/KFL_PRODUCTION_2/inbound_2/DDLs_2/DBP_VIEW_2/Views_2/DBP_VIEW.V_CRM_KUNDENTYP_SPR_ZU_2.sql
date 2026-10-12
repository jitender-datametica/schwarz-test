CREATE OR REPLACE VIEW DBP_VIEW.V_CRM_KUNDENTYP_SPR_ZU_2 (
   kundentyp_cd                             COMMENT 'Code des Kundentypes.'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,kundentyp_bez                            COMMENT 'Bezeichnung des Kundentyps (bspw. aus der K-App, aus dem Customer Service etc.)'
)
COMMENT = 'CRM - Sprachtabelle Kundentyp aus Cosmos DB CRM.'
 AS 
    SELECT 
        kundentyp_cd,
        spr_id,
        kundentyp_bez

FROM DBP_DATA.CRM_KUNDENTYP_SPR_ZU_2 ;