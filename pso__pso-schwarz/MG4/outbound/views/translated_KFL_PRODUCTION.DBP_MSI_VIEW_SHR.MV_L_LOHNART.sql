CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_lohnart (mandant_id, lohnart_id) AS SELECT *
FROM kfl_production_dbp_view.v_l_lohnart AS v01;