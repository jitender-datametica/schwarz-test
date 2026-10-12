CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lagerbestand_atp_per AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat_von,
 dat_bis,
 menge_lgbest_frei,
 menge_lgbest_block_werbung,
 menge_lgbest_block_iwt,
 menge_lgbest_block_nwbs
FROM kfl_production_dbp_data.lagerbestand_atp_per;