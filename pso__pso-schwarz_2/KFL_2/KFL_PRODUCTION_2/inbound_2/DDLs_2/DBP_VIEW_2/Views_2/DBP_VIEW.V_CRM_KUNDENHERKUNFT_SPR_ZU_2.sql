CREATE OR REPLACE VIEW DBP_VIEW.V_CRM_KUNDENHERKUNFT_SPR_ZU_2 (
   kundenherkunft_cd                        COMMENT 'Code der Kundenherkunft ( example values: K-App,Marktplatz,Mobiles Registrierungsformular,kappAndroid,kappIOS,marketplaceLoyalty,sscTerminal,sscWeb,Web).'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,kundenherkunft_bez                       COMMENT 'Bezeichnung der Kundenherkunft (bspw. aus der K-App, aus dem Customer Service etc.)'
)
COMMENT = 'CRM - Sprachtabelle für Kundenherkunft aus Cosmos DB CRM.'
 AS 
    SELECT 
        kundenherkunft_cd,
        spr_id,
        kundenherkunft_bez

FROM DBP_DATA.CRM_KUNDENHERKUNFT_SPR_ZU_2 ;