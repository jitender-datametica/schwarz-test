CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wg_zu_per_1 AS SELECT mandant_id,
 dat_von,
 art_id,
 arthiertyp_id,
 wg_id,
 dat_bis,
 wug_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.art_wg_zu_per_1;