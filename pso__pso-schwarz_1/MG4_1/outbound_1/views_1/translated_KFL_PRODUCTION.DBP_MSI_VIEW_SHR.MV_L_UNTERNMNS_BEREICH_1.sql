CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_unternmns_bereich_1 (mandant_id, unternehmens_bereich_id) AS
SELECT *
FROM kfl_production_dbp_view.v_l_unternmns_bereich_1 AS v01;