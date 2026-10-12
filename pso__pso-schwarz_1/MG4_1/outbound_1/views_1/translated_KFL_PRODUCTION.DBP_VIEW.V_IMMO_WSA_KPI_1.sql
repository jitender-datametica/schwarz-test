CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_wsa_kpi_1 (mandant_id, region_id, branche_id, groesse_kategorie,
wrg_id, umsatz_produktivitaet, kunde_umsatz, td_update, td_insert) AS SELECT mandant_id,
 region_id,
 branche_id,
 groesse_kategorie,
 wrg_id,
 umsatz_produktivitaet,
 kunde_umsatz,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_wsa_kpi_1;