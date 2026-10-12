CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_hr_massnahme_zu_per (mandant_id, hr_massnahme_grund_id,
hr_massnahme_id, mitarbeiter_id, kjmo) AS SELECT mandant_id,
 hr_massnahme_grund_id,
 hr_massnahme_id,
 mitarbeiter_id,
 kjmo
FROM kfl_production_dbp_view.v_ma_hr_massnahme_zu_per AS V01;