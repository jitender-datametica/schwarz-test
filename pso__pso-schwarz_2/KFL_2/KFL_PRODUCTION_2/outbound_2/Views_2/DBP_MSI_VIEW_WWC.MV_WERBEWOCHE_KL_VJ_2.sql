CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_werbewoche_kl_vj_2 (mandant_id, akt_kjwo_ww, kjwo_ww, kjwo_ww_vj
, dat_von_vj, dat_bis_vj) AS SELECT mandant_id,
 akt_kjwo_ww,
 kjwo_ww,
 kjwo_ww_vj,
 dat_von_vj,
 dat_bis_vj
FROM (SELECT t1.mandant_id,
   t1.akt_kjwo_ww,
   t1.kjwo_ww,
   V03.kjwo_ww AS kjwo_ww_vj,
   MIN(V03.dat) OVER (PARTITION BY CAST(V03.mandant_id AS STRING), CAST(V03.kjwo_ww AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_von_vj,
   MAX(V03.dat) OVER (PARTITION BY CAST(V03.mandant_id AS STRING), CAST(V03.kjwo_ww AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_bis_vj
  FROM (SELECT V01.mandant_id,
     V01.akt_kjwo_ww,
     V01.kjwo_ww,
     V02.dat_vj
    FROM kfl_production_dbp_view.v_werbewoche_kl_2 AS V01
     INNER JOIN kfl_production_dbp_view.v_tag_2 AS V02 ON V01.dat = V02.dat) AS t1_2
   INNER JOIN kfl_production_dbp_view.v_werbewoche_kl_2 AS V03 ON t1.mandant_id = V03.mandant_id AND t1.dat_vj = V03.dat)
 AS t2
GROUP BY mandant_id,
 akt_kjwo_ww,
 kjwo_ww,
 kjwo_ww_vj,
 dat_von_vj,
 dat_bis_vj;