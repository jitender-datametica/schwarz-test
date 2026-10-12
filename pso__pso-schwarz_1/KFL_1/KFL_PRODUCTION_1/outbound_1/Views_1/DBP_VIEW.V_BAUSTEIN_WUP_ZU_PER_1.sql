CREATE OR REPLACE VIEW kfl_production_dbp_view.v_baustein_wup_zu_per_1 AS SELECT baustein_id,
 mandant_id,
 wup_id,
 nb_id,
 dat_bis,
 dat_von
FROM kfl_production_dbp_data.baustein_wup_zu_per_1;