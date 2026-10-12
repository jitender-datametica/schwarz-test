CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_zeit_1h_1 AS SELECT zeit_stunde,
   zeit_von || '-' || zeit_bis_1_h AS zeit_1_h_bez
FROM kfl_production_dbp_view.v_zeit_1
WHERE zeit_minute = 0;