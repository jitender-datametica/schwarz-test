CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_baustein_art_zu_per_msi_1 AS SELECT baustein_id,
 mandant_id,
 art_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_msi_data.baustein_art_zu_per_msi_1;