CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_zeit_15min_trn AS SELECT T1.zeit_stunde,
 T1.zeit_minute AS zeit_15min,
 T2.zeit_stunde AS zeit_stunde_trn,
 T2.zeit_minute AS zeit_15min_trn
FROM kfl_production_dbp_view.v_zeit AS T1
 INNER JOIN kfl_production_dbp_view.v_zeit AS T2 ON T1.zeit_stunde > T2.zeit_stunde OR T1.zeit_stunde = T2.zeit_stunde
   AND T1.zeit_minute >= T2.zeit_minute;