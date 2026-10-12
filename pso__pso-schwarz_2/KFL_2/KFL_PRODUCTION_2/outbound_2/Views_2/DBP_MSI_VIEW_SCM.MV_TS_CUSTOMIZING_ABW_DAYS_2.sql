CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_customizing_abw_days_2 (mandant_id, werbe_typ_id, kjwo, dat,
std_dat_fg, abw_dat_fg, adj_dat_fg) AS SELECT V03.mandant_id,
 V03.werbe_typ_id,
 V01.kjwo,
 V02.dat,
  CASE
  WHEN V032.dat IS NOT NULL
  THEN 1
  ELSE 0
  END AS std_dat_fg,
  CASE
  WHEN v04.mandant_id IS NOT NULL
  THEN 1
  ELSE 0
  END AS abw_dat_fg,
  CASE
  WHEN V05.dat IS NOT NULL
  THEN 1
  ELSE 0
  END AS adj_dat_fg
FROM kfl_production_dbp_view.v_woche_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V02 ON V02.dat BETWEEN DATE_SUB(V01.wo_dat_von, INTERVAL 7 DAY) AND (DATE_ADD(V01
    .wo_dat_bis, INTERVAL 7 DAY))
 INNER JOIN kfl_production_dbp_view.v_werbe_typ_spr_zu_2 AS V03 ON V03.mandant_id IN (2, 6, 7) AND V03.werbe_typ_id = 6 OR
      V03.mandant_id IN (1) AND V03.werbe_typ_id = 2 OR V03.mandant_id IN (3, 4, 5) AND V03.werbe_typ_id = 5 OR V03.mandant_id
     IN (8) AND V03.werbe_typ_id = 7
 LEFT JOIN kfl_production_dbp_view.v_werbewoche_kl_2 AS V032 ON V03.mandant_id = V032.mandant_id AND V01.kjwo = V032.kjwo_ww
     AND V02.dat = V032.dat
 LEFT JOIN (SELECT ABW.mandant_id,
   ABW.dat_von,
   ABW.dat_bis,
   ABW.werbe_typ_id,
   T1.kjwo
  FROM kfl_production_dbp_view.v_ts_avq_werbezeitraum_abw_2 AS ABW
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS T1_2 ON ABW.dat_von = T1.dat) AS v04 ON V03.mandant_id = v04.mandant_id AND
     V02.dat BETWEEN v04.dat_von AND v04.dat_bis AND V01.kjwo = v04.kjwo AND V03.werbe_typ_id = v04.werbe_typ_id
 LEFT JOIN kfl_production_dbp_view.v_ts_wbs_vz_tag_2 AS V05 ON V03.mandant_id = V05.mandant_id AND V02.dat = V05.dat;