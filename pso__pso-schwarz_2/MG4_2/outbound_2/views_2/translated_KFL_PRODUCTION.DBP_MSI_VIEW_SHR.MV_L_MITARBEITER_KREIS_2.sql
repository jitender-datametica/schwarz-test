CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_mitarbeiter_kreis_2 (mandant_id, mitarbeiter_kreis_id) AS
SELECT *
FROM kfl_production_dbp_view.v_l_mitarbeiter_kreis_2 AS v01;