CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_mitarbeiter_status_1 (mandant_id, ma_status_id) AS SELECT *
FROM kfl_production_dbp_view.v_l_mitarbeiter_status_1 AS v01;