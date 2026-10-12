CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_abwesenh_zu_per_1 (mandant_id, abwesenheit_id, mitarbeiter_id, kjmo,
dat_von, dat_bis, abwesenheit_stunden, abrechnung_tage, abrechnung_stunden, td_insert, td_update) AS SELECT mandant_id,
 abwesenheit_id,
 mitarbeiter_id,
 kjmo,
 dat_von,
 dat_bis,
 abwesenheit_stunden,
 abrechnung_tage,
 abrechnung_stunden,
 td_insert,
 td_update
FROM kfl_production_dbp_data.ma_abwesenh_zu_per_1;