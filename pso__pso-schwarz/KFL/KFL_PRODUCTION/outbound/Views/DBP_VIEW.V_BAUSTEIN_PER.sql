CREATE OR REPLACE VIEW kfl_production_dbp_view.v_baustein_per AS SELECT baustein_id,
 mandant_id,
 spr_id,
 baustein_bez,
 dat_von,
 dat_bis,
 baustein_art_id
FROM kfl_production_dbp_data.baustein_per;