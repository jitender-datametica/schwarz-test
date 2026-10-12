CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wupcal_2 AS WITH T_WUP_BEREINIGT AS (SELECT V010.dat,
   V02.mandant_id,
   V02.wup_id,
    CASE
    WHEN V010.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V010
        .kjwo_kl_dat_bis < V02.dat_bis OR V02.wup_aenderung_grund_id IN (1, 2, 3, 4))
    THEN 1
    ELSE 0
    END AS wup_bereinigt_fg_akt,
    CASE
    WHEN V04.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V04
        .kjwo_kl_dat_bis < V02.dat_bis OR V02.wup_aenderung_grund_id IN (1, 2, 3, 4))
    THEN 1
    ELSE 0
    END AS wup_bereinigt_fg_vj_wo,
    CASE
    WHEN CAST(V010.dat AS STRING) LIKE '%-02-29'
    THEN CASE
     WHEN V04.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V04
         .kjwo_kl_dat_bis < V02.dat_bis OR V02.wup_aenderung_grund_id IN (1, 2, 3, 4))
     THEN 1
     ELSE 0
     END
    WHEN V03.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V03
        .kjwo_kl_dat_bis < V02.dat_bis OR V02.wup_aenderung_grund_id IN (1, 2, 3, 4))
    THEN 1
    ELSE 0
    END AS wup_bereinigt_fg_vj
  FROM kfl_production_dbp_view.v_tag_2 AS V010
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V010.dat >= COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung)
   LEFT JOIN kfl_production_dbp_view.v_tag_2 AS V03 ON V010.dat = V03.dat_vj_kt
   LEFT JOIN kfl_production_dbp_view.v_tag_2 AS V04 ON V010.dat = V04.dat_vj
  WHERE V010.dat BETWEEN DATE '2019-01-01' AND (DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY))
   AND (V02.nb_id = 0 AND V02.mandant_id <> 1 OR V02.mandant_id >= 2 AND V02.wup_id = 0)) (SELECT V01.wup_id,
   V01.mandant_id,
   V01.nb_id,
   V01.dat,
   V01.bonanzahl,
   V01.bonanzahl_sug,
    CASE
    WHEN V01.datenlieferung_artbew_wg_sum IN (0, 2, 3)
    THEN 0
    ELSE V01.datenlieferung_artbew_wg_sum
    END AS datenlieferung,
   V01.datenlieferung_artbew,
   v02.wup_bereinigt_fg_akt,
   v02.wup_bereinigt_fg_vj,
   v02.wup_bereinigt_fg_vj_wo
  FROM kfl_production_dbp_view.v_wupcal_2 AS V01
   LEFT JOIN T_WUP_BEREINIGT AS v02 ON V01.dat = v02.dat AND V01.mandant_id = v02.mandant_id AND V01.wup_id = v02.wup_id
     
  WHERE V01.mandant_id <> 1);