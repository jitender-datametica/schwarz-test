CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_zeit_30min_1 AS SELECT zeit_stunde,
 zeit_minute AS zeit_30min,
   zeit_von || '-' || zeit_bis_30min AS zeit_30min_bez
FROM kfl_production_dbp_view.v_zeit_1
WHERE zeit_minute IN (0, 30);