CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_preisindex_gesamt (mandant_id, dat_erfass, wrg_id,
betrag_umsatz_art_gesamt) AS SELECT mandant_id,
 dat_erfass,
 wrg_id,
 betrag_umsatz_art_gesamt
FROM kfl_production_dbp_data.preisindex_gesamt;