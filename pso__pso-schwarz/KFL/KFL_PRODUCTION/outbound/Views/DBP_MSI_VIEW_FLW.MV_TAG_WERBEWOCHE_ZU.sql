CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_tag_werbewoche_zu (dat, kjwo_so, kjwo_do, kjwo_mi) AS SELECT
 V01.dat,
 V02.kjwo AS kjwo_so,
 V03.kjwo AS kjwo_do,
 V04.kjwo AS kjwo_mi
FROM kfl_production_dbp_view.v_tag AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V01.dat = DATE_SUB(V02.dat, INTERVAL 1 DAY)
 INNER JOIN kfl_production_dbp_view.v_tag AS V03 ON V01.dat = DATE_ADD(V03.dat, INTERVAL 3 DAY)
 INNER JOIN kfl_production_dbp_view.v_tag AS V04 ON V01.dat = DATE_ADD(V04.dat, INTERVAL 2 DAY);