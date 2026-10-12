CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_mitarbeiter_abwesenh (mandant_id, abwesenheit_id) AS SELECT
 *
FROM kfl_production_dbp_view.v_l_mitarbeiter_abwesenh AS v01;