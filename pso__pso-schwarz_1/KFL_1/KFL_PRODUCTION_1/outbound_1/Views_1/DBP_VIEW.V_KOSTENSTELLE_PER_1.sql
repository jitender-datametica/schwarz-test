CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kostenstelle_per_1 AS SELECT mandant_id,
 system_id,
 kostenstelle_id,
 dat_von,
 krk_id,
 kostenstelle_bez,
 dat_bis
FROM kfl_production_dbp_data.kostenstelle_per_1;