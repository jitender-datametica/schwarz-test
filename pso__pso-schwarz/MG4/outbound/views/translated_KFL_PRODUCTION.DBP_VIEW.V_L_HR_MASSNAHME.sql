CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_hr_massnahme (mandant_id, hr_massnahme_grund_id, hr_massnahme_id) AS
SELECT mandant_id,
 hr_massnahme_grund_id,
 hr_massnahme_id
FROM kfl_production_dbp_data.l_hr_massnahme;