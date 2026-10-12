CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_mitarbeiter_gruppe_2 (mandant_id, mitarbeiter_gruppe_id) AS
SELECT *
FROM kfl_production_dbp_view.v_l_mitarbeiter_gruppe_2 AS v01;