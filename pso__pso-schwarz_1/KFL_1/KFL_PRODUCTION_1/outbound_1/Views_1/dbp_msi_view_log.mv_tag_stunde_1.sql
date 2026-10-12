CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_tag_stunde_1 AS SELECT dat,
 stunde,
 stunde_minuten,
 dat_zeit
FROM kfl_production_dbp_view.v_tag_stunde_1 AS V01;