CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_kostenstelle_zu_per_2 (mandant_id, system_id, kostenstelle_id,
mitarbeiter_id, kjmo, dat_von, dat_bis) AS SELECT mandant_id,
 system_id,
 kostenstelle_id,
 mitarbeiter_id,
 kjmo,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.ma_kostenstelle_zu_per_2;