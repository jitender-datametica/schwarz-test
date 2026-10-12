CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_tour_plombe_start_1 (mandant_id, tour_id, plombe_id,
plombe_pos_id, nb_id, wup_id, plombe_vorgang_id, dat_erfasst, zeit_erfasst, storno_fg) AS SELECT mandant_id,
 tour_id,
 plombe_id,
 plombe_pos_id,
 nb_id,
 wup_id,
 plombe_vorgang_id,
 dat_erfasst,
 zeit_erfasst,
 storno_fg
FROM kfl_production_dbp_view.v_tour_plombe_start_1;