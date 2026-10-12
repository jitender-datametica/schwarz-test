CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_crm_gender_1 (gender_id
OPTIONS(description='ID für das Geschlecht des Kunden'), gender_bez
OPTIONS(description='Bezeichnugn für das Geschlecht des Kunden'))
OPTIONS(DESCRIPTION = `CRM - LOOKUP TABELLE FÜR SALUTATIONCODE AUS COSMOS DB.`) AS SELECT gender_id,
 gender_bez
FROM kfl_production_dbp_data.l_crm_gender_1;