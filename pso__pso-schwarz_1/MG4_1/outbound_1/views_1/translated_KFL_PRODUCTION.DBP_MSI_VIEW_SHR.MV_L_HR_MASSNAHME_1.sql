CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_hr_massnahme_1 (mandant_id, hr_massnahme_grund_id,
hr_massnahme_id) AS SELECT *
FROM kfl_production_dbp_view.v_l_hr_massnahme_1 AS v01;