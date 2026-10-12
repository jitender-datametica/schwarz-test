CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_besch_best_belos_vorgang_zu (belos_vorgang_id, best_beleg_id,
mandant_id) AS SELECT belos_vorgang_id,
 best_beleg_id,
 mandant_id
FROM kfl_production_dbp_view.v_besch_best_belos_vorgang_zu;