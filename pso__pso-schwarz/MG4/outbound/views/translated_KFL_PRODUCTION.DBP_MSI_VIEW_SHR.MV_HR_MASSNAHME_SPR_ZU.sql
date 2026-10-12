CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_hr_massnahme_spr_zu (mandant_id, hr_massnahme_grund_id,
hr_massnahme_id, hr_massnahme_grund_bez) AS SELECT mandant_id,
 hr_massnahme_grund_id,
 hr_massnahme_id,
 hr_massnahme_grund_bez
FROM kfl_production_dbp_view.v_hr_massnahme_spr_zu AS v01
WHERE spr_id = 22;