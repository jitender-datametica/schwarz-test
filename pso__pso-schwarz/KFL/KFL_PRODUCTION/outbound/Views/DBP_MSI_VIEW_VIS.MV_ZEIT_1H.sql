CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_zeit_1h (zeit_stunde, zeit_1_h_bez) AS SELECT zeit_stunde,
   zeit_von || '-' || zeit_bis_1_h AS zeit_1_h_bez
FROM kfl_production_dbp_view.v_zeit
WHERE zeit_minute = 0;