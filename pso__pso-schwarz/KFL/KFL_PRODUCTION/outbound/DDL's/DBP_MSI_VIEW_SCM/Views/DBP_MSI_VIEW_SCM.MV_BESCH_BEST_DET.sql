-- 2026-02-04, AP0309228, SPEC0356102, initial, dknop

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_besch_best_det (mandant_id, best_beleg_id, best_beleg_pos_id,
dat_best_beleg, anforderer_name) AS SELECT mandant_id,
 best_beleg_id,
 best_beleg_pos_id,
 dat_best_beleg,
 anforderer_name
FROM kfl_production_dbp_view.v_besch_best_det;