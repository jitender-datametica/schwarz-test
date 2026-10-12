CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_hr_massnahme_2 (mandant_id, hr_massnahme_grund_id,
hr_massnahme_id) AS SELECT mandant_id,
 hr_massnahme_grund_id,
 hr_massnahme_id
FROM kfl_production_dbp_view.v_l_hr_massnahme_2 AS V01;