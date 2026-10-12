CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tag_stunde_2 AS SELECT dat,
 stunde,
 stunde_minuten,
 dat_zeit
FROM kfl_production_dbp_data.tag_stunde_2;