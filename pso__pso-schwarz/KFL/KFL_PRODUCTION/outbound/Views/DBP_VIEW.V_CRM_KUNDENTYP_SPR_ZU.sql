CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_kundentyp_spr_zu (kundentyp_cd
OPTIONS(description='Code des Kundentypes.'), spr_id OPTIONS(description='ID der Sprache'), kundentyp_bez
OPTIONS(description='Bezeichnung des Kundentyps (bspw. aus der K-App, aus dem Customer Service etc.)'))
OPTIONS(DESCRIPTION = `CRM - SPRACHTABELLE KUNDENTYP AUS COSMOS DB CRM.`) AS SELECT kundentyp_cd,
 spr_id,
 kundentyp_bez
FROM kfl_production_dbp_data.crm_kundentyp_spr_zu;