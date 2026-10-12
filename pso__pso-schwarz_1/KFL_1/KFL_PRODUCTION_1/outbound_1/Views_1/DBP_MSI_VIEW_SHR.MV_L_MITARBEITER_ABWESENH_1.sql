CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_mitarbeiter_abwesenh_1 (mandant_id, abwesenheit_id) AS SELECT
 mandant_id,
 abwesenheit_id
FROM kfl_production_dbp_view.v_l_mitarbeiter_abwesenh_1 AS V01;