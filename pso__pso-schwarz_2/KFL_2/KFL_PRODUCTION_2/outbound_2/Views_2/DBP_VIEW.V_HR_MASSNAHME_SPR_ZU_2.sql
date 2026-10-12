CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hr_massnahme_spr_zu_2 AS SELECT mandant_id,
 hr_massnahme_grund_id,
 hr_massnahme_id,
 spr_id,
 hr_massnahme_grund_bez
FROM kfl_production_dbp_data.hr_massnahme_spr_zu_2;