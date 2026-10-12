CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_gutschein_1 (mandant_id, crm_gutschein_id, crm_vorgang_id,
crm_gutschein_grund_id, gutschein_nummer, kostenstelle_id, gutschein_wert, wrg_id) AS SELECT mandant_id,
 crm_gutschein_id,
 crm_vorgang_id,
 crm_gutschein_grund_id,
 gutschein_nummer,
 kostenstelle_id,
 gutschein_wert,
 wrg_id
FROM kfl_production_dbp_data.crm_gutschein_1;