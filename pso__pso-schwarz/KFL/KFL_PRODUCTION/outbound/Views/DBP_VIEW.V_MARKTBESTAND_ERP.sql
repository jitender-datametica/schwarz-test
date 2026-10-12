CREATE OR REPLACE VIEW kfl_production_dbp_view.v_marktbestand_erp AS SELECT mandant_id,
 art_id,
 wup_id,
 nb_id,
 dat,
 bestand_id,
 bezugsweg_id,
 relevant_fg,
 menge_lgbest_erp_frei_bme,
 menge_lgbest_erp_qual_bme,
 menge_lgbest_erp_gesp_bme,
 fortschreibung_fg
FROM kfl_production_dbp_data.marktbestand_erp;