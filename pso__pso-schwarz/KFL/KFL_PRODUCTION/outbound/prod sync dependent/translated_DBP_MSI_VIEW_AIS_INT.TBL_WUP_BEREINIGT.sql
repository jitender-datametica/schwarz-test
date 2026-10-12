
CREATE OR REPLACE TABLE dbp_msi_view_ais_int.tbl_wup_bereinigt
 AS
SELECT V01.dat,
 V02.mandant_id,
 V02.wup_id,
  CASE
  WHEN V01.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V01.kjwo_kl_dat_bis
       < V02.dat_bis OR V02.wup_aenderung_grund_id IN (1, 2, 3, 4))
  THEN 1
  ELSE 0
  END AS wup_bereinigt_fg_akt,
  CASE
  WHEN V04.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V04.kjwo_kl_dat_bis
       < V02.dat_bis OR V02.wup_aenderung_grund_id IN (1, 2, 3, 4))
  THEN 1
  ELSE 0
  END AS wup_bereinigt_fg_vj_wo,
  CASE
  WHEN CAST(V01.dat AS STRING) LIKE '%-02-29'
  THEN CASE
   WHEN V04.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V04
       .kjwo_kl_dat_bis < V02.dat_bis OR V02.wup_aenderung_grund_id IN (1, 2, 3, 4))
   THEN 1
   ELSE 0
   END
  WHEN V03.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V03.kjwo_kl_dat_bis
       < V02.dat_bis OR V02.wup_aenderung_grund_id IN (1, 2, 3, 4))
  THEN 1
  ELSE 0
  END AS wup_bereinigt_fg_vj
FROM kfl_production_dbp_view.v_tag AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.dat >= COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung)
 LEFT JOIN kfl_production_dbp_view.v_tag AS V03 ON V01.dat = V03.dat_vj_kt
 LEFT JOIN kfl_production_dbp_view.v_tag AS V04 ON V01.dat = V04.dat_vj
WHERE V01.dat BETWEEN DATE '2019-01-01' AND (DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY))
 AND V02.nb_id = 0;
