CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_tag_werbewoche_zu_1 (dat, kjwo_mi, kjwo_do) AS SELECT V01.dat,
 V02.kjwo AS kjwo_mi,
 V03.kjwo AS kjwo_do
FROM kfl_production_dbp_view.v_tag_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON V01.dat = DATE_ADD(V02.dat, INTERVAL 2 DAY)
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V03 ON V01.dat = DATE_ADD(V03.dat, INTERVAL 3 DAY);