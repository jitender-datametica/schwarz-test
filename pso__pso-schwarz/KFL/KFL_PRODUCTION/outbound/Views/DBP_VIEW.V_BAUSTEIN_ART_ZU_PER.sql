CREATE OR REPLACE VIEW kfl_production_dbp_view.v_baustein_art_zu_per AS SELECT baustein_id,
 mandant_id,
 art_id,
 dat_bis,
 dat_von,
 akz_id,
 stueckliste_id
FROM kfl_production_dbp_data.baustein_art_zu_per;