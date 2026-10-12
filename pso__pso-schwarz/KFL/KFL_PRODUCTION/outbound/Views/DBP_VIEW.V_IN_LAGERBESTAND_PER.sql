CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_lagerbestand_per AS SELECT mandant_id,
 in_art_id,
 werk_id,
 in_lagerort_id,
 dat_von,
 dat_bis,
 menge_lgbest_frei_bme,
 menge_lgbest_umlag_bme,
 menge_lgbest_qual_bme,
 menge_lgbest_nf_charge_bme,
 menge_lgbest_gesp_bme,
 menge_lgbest_ret_gesp_bme
FROM kfl_production_dbp_data.in_lagerbestand_per;