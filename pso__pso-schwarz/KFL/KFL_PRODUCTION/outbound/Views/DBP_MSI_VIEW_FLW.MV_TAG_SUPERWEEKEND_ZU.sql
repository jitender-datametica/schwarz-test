CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_tag_superweekend_zu (dat, kjwo_sw) AS SELECT V01.dat,
 V02.kjwo AS kjwo_sw
FROM kfl_production_dbp_view.v_tag AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V01.dat = DATE_ADD(V02.dat, INTERVAL 3 DAY)
WHERE V01.wtag_id IN (4, 5, 6, 7);