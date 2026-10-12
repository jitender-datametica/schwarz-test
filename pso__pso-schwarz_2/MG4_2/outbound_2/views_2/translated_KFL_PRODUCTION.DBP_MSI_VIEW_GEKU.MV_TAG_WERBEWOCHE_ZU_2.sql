CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_tag_werbewoche_zu_2 (dat, kjwo_mi, kjwo_do) AS SELECT v01.dat,
 v02.kjwo AS kjwo_mi,
 v03.kjwo AS kjwo_do
FROM kfl_production_dbp_view.v_tag_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS v02 ON v01.dat = DATE_ADD(v02.dat, INTERVAL 2 DAY)
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS v03 ON v01.dat = DATE_ADD(v03.dat, INTERVAL 3 DAY);