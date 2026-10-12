CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_zeit_15min AS SELECT zeit_stunde,
 zeit_minute AS zeit_15min,
   zeit_von || '-' || zeit_bis_15min AS zeit_15min_bez,
  CAST(zeit_minute / 30 AS BIGNUMERIC) * 30 AS zeit_30min
FROM kfl_production_dbp_view.v_zeit;