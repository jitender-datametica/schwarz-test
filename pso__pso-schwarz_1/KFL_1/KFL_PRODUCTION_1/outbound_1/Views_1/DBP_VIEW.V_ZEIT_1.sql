CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zeit_1 AS SELECT zeit_stunde,
 zeit_minute,
 zeit_von,
 zeit_bis_15min,
 zeit_bis_30min,
 zeit_bis_1_h,
 aktuell_fg
FROM kfl_production_dbp_data.zeit_1;