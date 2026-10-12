CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_kundenherkunft_spr_zu_2 (kundenherkunft_cd
OPTIONS(description='Code der Kundenherkunft ( example values: K-App,Marktplatz,Mobiles Registrierungsformular,kappAndroid,kappIOS,marketplaceLoyalty,sscTerminal,sscWeb,Web).'),
spr_id OPTIONS(description='ID der Sprache'), kundenherkunft_bez
OPTIONS(description='Bezeichnung der Kundenherkunft (bspw. aus der K-App, aus dem Customer Service etc.)'))
OPTIONS(DESCRIPTION = `CRM - SPRACHTABELLE FÜR KUNDENHERKUNFT AUS COSMOS DB CRM.`) AS SELECT kundenherkunft_cd,
 spr_id,
 kundenherkunft_bez
FROM kfl_production_dbp_data.crm_kundenherkunft_spr_zu_2;