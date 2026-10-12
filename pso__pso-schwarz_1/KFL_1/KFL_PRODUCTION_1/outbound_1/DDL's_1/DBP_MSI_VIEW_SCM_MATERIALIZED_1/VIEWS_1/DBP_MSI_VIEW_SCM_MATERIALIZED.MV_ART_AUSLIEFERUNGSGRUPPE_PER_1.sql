CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_auslieferungsgruppe_per_1 (mandant_id, art_id,
auslieferungsgruppe_id, dat_von, dat_bis) AS SELECT mandant_id,
 art_id,
 auslieferungsgruppe_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_art_auslieferungsgruppe_per_1 AS V01;