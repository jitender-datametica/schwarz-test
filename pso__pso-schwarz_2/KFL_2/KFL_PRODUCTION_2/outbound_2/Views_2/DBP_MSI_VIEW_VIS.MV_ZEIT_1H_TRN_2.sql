CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_zeit_1h_trn_2 AS SELECT T1.zeit_stunde,
 T2.zeit_stunde AS zeit_stunde_trn
FROM kfl_production_dbp_view.v_zeit_2 AS T1_2
 INNER JOIN kfl_production_dbp_view.v_zeit_2 AS T2 ON T1.zeit_stunde >= T2.zeit_stunde
WHERE T1.zeit_minute = 0
 AND T2.zeit_minute = 0;