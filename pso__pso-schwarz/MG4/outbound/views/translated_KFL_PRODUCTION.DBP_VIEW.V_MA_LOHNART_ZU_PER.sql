CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_lohnart_zu_per (mandant_id, mitarbeiter_id, lohnart_id, kjmo,
dat_von, dat_bis, stunden_lohnart, system_id, kostenstelle_id) AS SELECT mandant_id,
 mitarbeiter_id,
 lohnart_id,
 kjmo,
 dat_von,
 dat_bis,
 stunden_lohnart,
 system_id,
 kostenstelle_id
FROM kfl_production_dbp_data.ma_lohnart_zu_per;