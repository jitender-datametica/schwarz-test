CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_zeit_15min (zeit_stunde, zeit_15min, zeit_15min_bez,
zeit_30min) AS SELECT zeit_stunde,
 zeit_minute AS zeit_15min,
   zeit_von || '-' || zeit_bis_15min AS zeit_15min_bez,
 CAST(CAST(FLOOR(zeit_minute / 30) AS INTEGER) * 30 AS BIGNUMERIC) AS zeit_30min
FROM kfl_production_dbp_view.v_zeit;