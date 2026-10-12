CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_hr_massnahme_zu_per_1 AS SELECT mandant_id,
 hr_massnahme_grund_id,
 hr_massnahme_id,
 mitarbeiter_id,
 kjmo,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.ma_hr_massnahme_zu_per_1;