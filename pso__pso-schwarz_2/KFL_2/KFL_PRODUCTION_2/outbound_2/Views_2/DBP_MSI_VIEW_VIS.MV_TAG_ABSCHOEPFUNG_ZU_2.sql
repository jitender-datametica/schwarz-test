CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_tag_abschoepfung_zu_2 AS SELECT V01.sort_id,
 V01.dat_von,
 V01.dat_bis,
 V02.dat
FROM kfl_production_dbp_msi_view_vis.mv_tag_abschoepfung_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V02 ON V02.dat BETWEEN V01.dat_von AND V01.dat_bis;