CREATE OR REPLACE VIEW kfl_production_dbp_view.v_marktbestand_erp_delta_1 AS SELECT art_id,
 mandant_id,
 wup_id,
 nb_id,
 dat,
 menge_lgbest_erp_frei_bme,
 menge_lgbest_erp_qual_bme
FROM kfl_production_dbp_data.marktbestand_erp_delta_1;