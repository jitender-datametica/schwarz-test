CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jzg_fakt_zielwert AS WITH MONAT_GJ AS (SELECT gj,
   akt_gj,
   mo_kj,
   kjmo
  FROM kfl_production_dbp_view.v_monat
  WHERE akt_gj = 0), WUP AS (SELECT mandant_id,
   nb_id,
   wup_id,
   aktuell_wup_id,
   dat_eroeffnung,
   dat_bis,
   COALESCE(dat_eroeffnung_alt, dat_eroeffnung) AS neo_dat,
   dat_bis AS stl_dat,
    EXTRACT(YEAR FROM COALESCE(dat_eroeffnung_alt, dat_eroeffnung)) - IF(EXTRACT(MONTH FROM COALESCE(dat_eroeffnung_alt
        , dat_eroeffnung)) < 3, 1, 0) AS neo_gj,
    EXTRACT(YEAR FROM dat_bis) - IF(EXTRACT(MONTH FROM dat_bis) < 3, 1, 0) AS stl_gj
  FROM kfl_production_dbp_view.v_wup AS WUP
  WHERE (nb_id = 0 OR wup_id IN (0, 2, 22, 28, 43, 46, 124, 8980, 8987, 8991, 100000, 100002, 100022, 100028, 100043,
       100046, 100124))
   AND dat_eroeffnung < DATE '2090-12-31'), ZIEL AS (SELECT JZG.mandant_id,
   JZG.nb_id,
   JZG.wup_id,
   JZG.wrg_id,
   JZG.metrik_id,
   JZG.typ_id,
   JZG.level_id,
   JZG.zielerreich_eingabe AS zielerreich,
   JZG.zielwert_eingabe AS zielwert_gj,
   JZG.kommentar_eingabe AS kommentar_gj
  FROM kfl_production_dbp_msi_view_vis.mv_vis_jzg_fakt_eingabe AS JZG
   INNER JOIN WUP AS t6 ON JZG.wup_id = t6.wup_id AND JZG.mandant_id = t6.mandant_id
   INNER JOIN kfl_production_dbp_view.v_jahr_gj AS JAHR ON JZG.gj = JAHR.gj AND JAHR.akt_gj = 0), VIS_MAIN AS (SELECT
   VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   0 AS zero,
   zeit.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan_gj,
   SUM(VIS.pers_std_plan) AS std_plan_gj,
   MAX(t8.zielwert_gj) AS ums_ziel_gj,
   MAX(t8.kommentar_gj) AS ums_komm_gj,
   MAX(t8.zielerreich) AS ums_ziel_er,
    MAX(t8.zielwert_gj) / IF(SUM(VIS.ums_netto_plan) = 0, NULL, SUM(VIS.ums_netto_plan)) AS faktor_gj
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wup AS VIS
   INNER JOIN MONAT_GJ AS zeit ON VIS.kjmo = zeit.kjmo
   INNER JOIN WUP AS t3 ON VIS.wup_id = t3.wup_id AND VIS.mandant_id = t3.mandant_id
   LEFT JOIN ZIEL AS t8 ON VIS.mandant_id = t8.mandant_id AND VIS.wup_id = t8.wup_id AND VIS.wrg_id = t8.wrg_id AND t8.metrik_id
        = 10 AND t8.typ_id = 0 AND t8.level_id = 0
  WHERE t3.stl_gj > zeit.gj
   AND t3.neo_gj <= zeit.gj
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   zero,
   zeit.gj), WARE AS (SELECT ABT.abt_id,
   HWG.hwg_id,
   OWG.owg_id,
   CAST(CASE
     WHEN ABT.abt_id = 4
     THEN 9999999
     WHEN ABT.abt_id = 5
     THEN ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id)
     WHEN ABT.abt_id = 6
     THEN ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000
     ELSE ABT.abt_id * 1000000
     END AS BIGNUMERIC) AS level_owg,
   CAST(CASE
     WHEN ABT.abt_id = 4
     THEN 9999999
     WHEN ABT.abt_id IN (5, 6)
     THEN ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000
     ELSE ABT.abt_id * 1000000
     END AS BIGNUMERIC) AS level_hwg,
   CAST(CASE
     WHEN ABT.abt_id = 4
     THEN 9999999
     ELSE ABT.abt_id * 1000000
     END AS BIGNUMERIC) AS level_abt
  FROM kfl_production_dbp_msi_view_vis.mv_owg_int AS OWG
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int AS ABT ON HWG.abt_id = ABT.abt_id
  WHERE ABT.abt_id IN (4, 5, 6, 7, 8)), VIS_PLAN AS (SELECT VIS0.mandant_id,
   VIS0.nb_id,
   VIS0.wup_id,
   VIS0.wrg_id,
   zeit.gj,
   t31.abt_id,
   t31.hwg_id,
   t31.owg_id,
   t31.level_abt,
   t31.level_hwg,
   t31.level_owg,
   SUM(VIS0.umsatz_netto_plan) AS ums_plan_gj,
   MAX(t41.zielerreich) AS abs_ziel_er,
   MAX(t41.kommentar_gj) AS abs_komm_gj,
   MAX(t41.zielwert_gj) AS abs_eing_gj,
    SUM(VIS0.umsatz_netto_plan) * MAX(t41.zielwert_gj) AS abs_kalk_gj
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg AS VIS0
   INNER JOIN WARE AS t31 ON VIS0.owg_id = t31.owg_id
   INNER JOIN MONAT_GJ AS zeit ON VIS0.kjmo = zeit.kjmo
   INNER JOIN WUP AS t36 ON VIS0.wup_id = t36.wup_id AND VIS0.mandant_id = t36.mandant_id
   LEFT JOIN ZIEL AS t41 ON VIS0.mandant_id = t41.mandant_id AND VIS0.wup_id = t41.wup_id AND VIS0.wrg_id = t41.wrg_id
     AND t41.metrik_id = 40 AND t31.level_owg = t41.level_id
  WHERE t36.stl_gj > zeit.gj
   AND t36.neo_gj <= zeit.gj
  GROUP BY VIS0.mandant_id,
   VIS0.nb_id,
   VIS0.wup_id,
   VIS0.wrg_id,
   t31.abt_id,
   t31.hwg_id,
   t31.owg_id,
   t31.level_owg,
   t31.level_hwg,
   t31.level_abt,
   zeit.gj), VIS_ABT_PLAN AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   level_id,
   SUM(ums_plan_gj) AS ums_plan_gj,
   SUM(abs_kalk_gj) AS abs_kalk_gj,
   MAX(`A118612`) AS abs_eing_gj,
   MAX(`A118613`) AS abs_komm_gj,
   MAX(`A118614`) AS abs_ziel_er
  FROM (SELECT mandant_id,
     nb_id,
     wup_id,
     wrg_id,
     gj,
     abt_id,
     level_abt AS level_id,
     ums_plan_gj,
     abs_kalk_gj,
     IF(abt_id IN (4, 7, 8), abs_eing_gj, NULL) AS `A118612`,
     IF(abt_id IN (4, 7, 8), abs_komm_gj, NULL) AS `A118613`,
     IF(abt_id IN (4, 7, 8), abs_ziel_er, NULL) AS `A118614`
    FROM VIS_PLAN AS vis) AS t47
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   level_id), VIS_HWG_PLAN AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   hwg_id,
   level_id,
   SUM(ums_plan_gj) AS ums_plan_gj,
   SUM(abs_kalk_gj) AS abs_kalk_gj,
   MAX(`A118613`) AS abs_eing_gj,
   MAX(`A118614`) AS abs_komm_gj,
   MAX(`A118615`) AS abs_ziel_er
  FROM (SELECT mandant_id,
     nb_id,
     wup_id,
     wrg_id,
     gj,
     hwg_id,
     level_hwg AS level_id,
     ums_plan_gj,
     abs_kalk_gj,
     IF(abt_id IN (6), abs_eing_gj, NULL) AS `A118613`,
     IF(abt_id IN (6), abs_komm_gj, NULL) AS `A118614`,
     IF(abt_id IN (6), abs_ziel_er, NULL) AS `A118615`
    FROM VIS_PLAN AS vis) AS t84
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   hwg_id,
   level_id), VIS_OWG_PLAN AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   owg_id,
   level_id,
   SUM(ums_plan_gj) AS ums_plan_gj,
   SUM(abs_kalk_gj) AS abs_kalk_gj,
   MAX(abs_eing_gj) AS abs_eing_gj,
   MAX(abs_komm_gj) AS abs_komm_gj,
   MAX(abs_ziel_er) AS abs_ziel_er
  FROM (SELECT mandant_id,
     nb_id,
     wup_id,
     wrg_id,
     gj,
     owg_id,
     level_owg AS level_id,
     ums_plan_gj,
     abs_kalk_gj,
     abs_eing_gj,
     abs_komm_gj,
     abs_ziel_er
    FROM VIS_PLAN AS vis) AS t120
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   owg_id,
   level_id), VIS_FIL_PLAN AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   SUM(ums_plan_gj) AS ums_plan_gj,
   SUM(abs_kalk_gj) AS abs_kalk_gj,
   abs_eing_gj
  FROM (SELECT mandant_id,
     nb_id,
     wup_id,
     wrg_id,
     gj,
     ums_plan_gj,
     abs_kalk_gj,
     NULL AS abs_eing_gj
    FROM VIS_PLAN AS vis) AS t235
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abs_eing_gj), VIS_ABT_INV AS (SELECT vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.wrg_id,
   vis.gj,
   vis.abt_id,
   vis.level_abt AS level_id,
   SUM(vis.ums_plan_gj) AS ums_plan_gj,
   MAX(t384.zielwert_gj) AS inv_eing_gj,
   MAX(t384.kommentar_gj) AS inv_komm_gj,
   MAX(t384.zielerreich) AS inv_ziel_er,
    SUM(vis.ums_plan_gj) * MAX(t384.zielwert_gj) AS inv_kalk_gj
  FROM VIS_PLAN AS vis
   LEFT JOIN ZIEL AS t384 ON vis.mandant_id = t384.mandant_id AND vis.wup_id = t384.wup_id AND vis.wrg_id = t384.wrg_id
     AND t384.metrik_id = 46 AND vis.level_abt = t384.level_id
  GROUP BY vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.wrg_id,
   vis.gj,
   vis.abt_id,
   level_id), VIS_FIL_INV AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   SUM(ums_plan_gj) AS ums_plan_gj,
   SUM(inv_kalk_gj) AS inv_kalk_gj
  FROM VIS_ABT_INV AS vis
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj) (SELECT *
  FROM (SELECT 10 AS metrik_id,
      zero AS typ_id,
      zero AS level_id,
      mandant_id,
      nb_id,
      wup_id,
      wrg_id,
      gj,
      IFNULL(ums_ziel_gj, 0) AS eingabe_gj,
      IFNULL(ums_komm_gj, '') AS kommentar_gj,
      IFNULL(ums_ziel_er, '') AS zielerreichung,
      faktor_gj AS check_gj,
      IFNULL(ums_ziel_gj, 0) AS ziel_gj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj2,
      IFNULL(ums_ziel_gj, 0) AS ziel_gj
     FROM VIS_MAIN AS vis0
     UNION ALL
     SELECT 10 AS metrik_id,
      1 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC) AS eingabe_gj,
      '' AS kommentar_gj,
      '' AS zielerreichung,
      vis0.faktor_gj AS check_gj,
       sub1.ums_plan_gj * vis0.faktor_gj AS ziel_gj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj2,
       sub1.ums_plan_gj * vis0.faktor_gj AS ziel_gj
     FROM VIS_MAIN AS vis0
      INNER JOIN VIS_ABT_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
         = sub1.wrg_id
     UNION ALL
     SELECT 10 AS metrik_id,
      2 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC) AS eingabe_gj,
      '' AS kommentar_gj,
      '' AS zielerreichung,
      vis0.faktor_gj AS check_gj,
       sub1.ums_plan_gj * vis0.faktor_gj AS ziel_gj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj2,
       sub1.ums_plan_gj * vis0.faktor_gj AS ziel_gj
     FROM VIS_MAIN AS vis0
      INNER JOIN VIS_HWG_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
         = sub1.wrg_id
     UNION ALL
     SELECT 10 AS metrik_id,
      3 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC) AS eingabe_gj,
      '' AS kommentar_gj,
      '' AS zielerreichung,
      vis0.faktor_gj AS check_gj,
       sub1.ums_plan_gj * vis0.faktor_gj AS ziel_gj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj2,
       sub1.ums_plan_gj * vis0.faktor_gj AS ziel_gj
     FROM VIS_MAIN AS vis0
      INNER JOIN VIS_OWG_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
         = sub1.wrg_id
     UNION ALL
     SELECT 16 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      IFNULL(t142.zielwert_gj, 0) AS eingabe_gj,
      IFNULL(t142.kommentar_gj, '') AS kommentar_gj,
      IFNULL(t142.zielerreich, '') AS zielerreichung,
      CAST(NULL AS NUMERIC) AS check_gj,
      t142.zielwert_gj AS ziel_gj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj2,
      t142.zielwert_gj AS ziel_gj
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t142 ON vis0.mandant_id = t142.mandant_id AND vis0.wup_id = t142.wup_id AND vis0.wrg_id = t142.wrg_id
            AND t142.metrik_id = 16 AND t142.typ_id = 0 AND t142.level_id = 0
     UNION ALL
     SELECT 18 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC) AS eingabe_gj,
      '' AS kommentar_gj,
      '' AS zielerreichung,
      CAST(NULL AS NUMERIC) AS check_gj,
      IFNULL(vis0.ums_ziel_gj, 0) AS ziel_gj1,
      IFNULL(t162.zielwert_gj, 0) AS ziel_gj2,
       IFNULL(vis0.ums_ziel_gj, 0) / IF(IFNULL(t162.zielwert_gj, 0) = 0, NULL, IFNULL(t162.zielwert_gj, 0)) AS ziel_gj
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t162 ON vis0.mandant_id = t162.mandant_id AND vis0.wup_id = t162.wup_id AND vis0.wrg_id = t162.wrg_id
            AND t162.metrik_id = 16 AND t162.typ_id = 0 AND t162.level_id = 0
     UNION ALL
     SELECT 20 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC) AS eingabe_gj,
      '' AS kommentar_gj,
      '' AS zielerreichung,
      CAST(NULL AS NUMERIC) AS check_gj,
      IFNULL(vis0.ums_ziel_gj, 0) AS ziel_gj1,
      IFNULL(t182.zielwert_gj, 0) AS ziel_gj2,
       IFNULL(vis0.ums_ziel_gj, 0) / IF(IFNULL(t182.zielwert_gj, 0) = 0, NULL, IFNULL(t182.zielwert_gj, 0)) AS ziel_gj
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t182 ON vis0.mandant_id = t182.mandant_id AND vis0.wup_id = t182.wup_id AND vis0.wrg_id = t182.wrg_id
            AND t182.metrik_id = 24 AND t182.typ_id = 0 AND t182.level_id = 0
     UNION ALL
     SELECT 24 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      IFNULL(t202.zielwert_gj, 0) AS eingabe_gj,
      IFNULL(t202.kommentar_gj, '') AS kommentar_gj,
      IFNULL(t202.zielerreich, '') AS zielerreichung,
      CAST(NULL AS NUMERIC) AS check_gj,
      IFNULL(t202.zielwert_gj, 0) AS ziel_gj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj2,
      IFNULL(t202.zielwert_gj, 0) AS ziel_gj
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t202 ON vis0.mandant_id = t202.mandant_id AND vis0.wup_id = t202.wup_id AND vis0.wrg_id = t202.wrg_id
            AND t202.metrik_id = 24 AND t202.typ_id = 0 AND t202.level_id = 0
     UNION ALL
     SELECT 40 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC) AS eingabe_gj,
      '' AS kommentar_gj,
      '' AS zielerreichung,
      vis0.faktor_gj AS check_gj,
      IFNULL(sub1.abs_kalk_gj * vis0.faktor_gj, 0) AS ziel_gj1,
      IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) AS ziel_gj2,
       IFNULL(sub1.abs_kalk_gj * vis0.faktor_gj, 0) / IF(IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) = 0, NULL, IFNULL(sub1
          .ums_plan_gj * vis0.faktor_gj, 0)) AS ziel_gj
     FROM VIS_MAIN AS vis0
      INNER JOIN VIS_FIL_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
         = sub1.wrg_id
     UNION ALL
     SELECT 40 AS metrik_id,
      1 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      IFNULL(sub1.abs_eing_gj, 0) AS eingabe_gj,
      IFNULL(sub1.abs_komm_gj, '') AS kommentar_gj,
      IFNULL(sub1.abs_ziel_er, '') AS zielerreichung,
      vis0.faktor_gj AS check_gj,
      IFNULL(sub1.abs_kalk_gj * vis0.faktor_gj, 0) AS ziel_gj1,
      IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) AS ziel_gj2,
       IFNULL(sub1.abs_kalk_gj * vis0.faktor_gj, 0) / IF(IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) = 0, NULL, IFNULL(sub1
          .ums_plan_gj * vis0.faktor_gj, 0)) AS ziel_gj
     FROM VIS_MAIN AS vis0
      INNER JOIN VIS_ABT_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
         = sub1.wrg_id
     UNION ALL
     SELECT 40 AS metrik_id,
      2 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      IFNULL(sub1.abs_eing_gj, 0) AS eingabe_gj,
      IFNULL(sub1.abs_komm_gj, '') AS kommentar_gj,
      IFNULL(sub1.abs_ziel_er, '') AS zielerreichung,
      vis0.faktor_gj AS check_gj,
      IFNULL(sub1.abs_kalk_gj * vis0.faktor_gj, 0) AS ziel_gj1,
      IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) AS ziel_gj2,
       IFNULL(sub1.abs_kalk_gj * vis0.faktor_gj, 0) / IF(IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) = 0, NULL, IFNULL(sub1
          .ums_plan_gj * vis0.faktor_gj, 0)) AS ziel_gj
     FROM VIS_MAIN AS vis0
      INNER JOIN VIS_HWG_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
         = sub1.wrg_id
     UNION ALL
     SELECT 40 AS metrik_id,
      3 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      IFNULL(sub1.abs_eing_gj, 0) AS eingabe_gj,
      IFNULL(sub1.abs_komm_gj, '') AS kommentar_gj,
      IFNULL(sub1.abs_ziel_er, '') AS zielerreichung,
      vis0.faktor_gj AS check_gj,
      IFNULL(sub1.abs_kalk_gj * vis0.faktor_gj, 0) AS ziel_gj1,
      IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) AS ziel_gj2,
       IFNULL(sub1.abs_kalk_gj * vis0.faktor_gj, 0) / IF(IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) = 0, NULL, IFNULL(sub1
          .ums_plan_gj * vis0.faktor_gj, 0)) AS ziel_gj
     FROM VIS_MAIN AS vis0
      INNER JOIN VIS_OWG_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
         = sub1.wrg_id
     UNION ALL
     SELECT 46 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC) AS eingabe_gj,
      '' AS kommentar_gj,
      '' AS zielerreichung,
      vis0.faktor_gj AS check_gj,
      IFNULL(sub1.inv_kalk_gj * vis0.faktor_gj, 0) AS ziel_gj1,
      IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) AS ziel_gj2,
       IFNULL(sub1.inv_kalk_gj * vis0.faktor_gj, 0) / IF(IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) = 0, NULL, IFNULL(sub1
          .ums_plan_gj * vis0.faktor_gj, 0)) AS ziel_gj
     FROM VIS_MAIN AS vis0
      INNER JOIN VIS_FIL_INV AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
        = sub1.wrg_id
     UNION ALL
     SELECT 46 AS metrik_id,
      1 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      IFNULL(sub1.inv_eing_gj, 0) AS eingabe_gj,
      IFNULL(sub1.inv_komm_gj, '') AS kommentar_gj,
      IFNULL(sub1.inv_ziel_er, '') AS zielerreichung,
      vis0.faktor_gj AS check_gj,
      IFNULL(sub1.inv_kalk_gj * vis0.faktor_gj, 0) AS ziel_gj1,
      IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) AS ziel_gj2,
       IFNULL(sub1.inv_kalk_gj * vis0.faktor_gj, 0) / IF(IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) = 0, NULL, IFNULL(sub1
          .ums_plan_gj * vis0.faktor_gj, 0)) AS ziel_gj
     FROM VIS_MAIN AS vis0
      INNER JOIN VIS_ABT_INV AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
        = sub1.wrg_id
     UNION ALL
     SELECT 70 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      IFNULL(t449.zielwert_gj, 0) AS eingabe_gj,
      '' AS kommentar_gj,
      '' AS zielerreichung,
      CAST(NULL AS NUMERIC) AS check_gj,
      IFNULL(t449.zielwert_gj * vis0.ums_ziel_gj, 0) AS ziel_gj1,
      IFNULL(vis0.ums_ziel_gj, 0) AS ziel_gj2,
       IFNULL(t449.zielwert_gj * vis0.ums_ziel_gj, 0) / IF(IFNULL(vis0.ums_ziel_gj, 0) = 0, NULL, IFNULL(vis0.ums_ziel_gj
         , 0)) AS ziel_gj
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t449 ON vis0.mandant_id = t449.mandant_id AND vis0.wup_id = t449.wup_id AND vis0.wrg_id = t449.wrg_id
            AND t449.metrik_id = 70 AND t449.typ_id = 0 AND t449.level_id = 0
     UNION ALL
     SELECT 91 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC) AS eingabe_gj,
      IFNULL(t469.kommentar_gj, '') AS kommentar_gj,
      IFNULL(t469.zielerreich, '') AS zielerreichung,
      CAST(NULL AS NUMERIC) AS check_gj,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj2,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t469 ON vis0.mandant_id = t469.mandant_id AND vis0.wup_id = t469.wup_id AND vis0.wrg_id = t469.wrg_id
            AND t469.metrik_id = 91 AND t469.typ_id = 0 AND t469.level_id = 0
     UNION ALL
     SELECT 92 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC) AS eingabe_gj,
      IFNULL(t489.kommentar_gj, '') AS kommentar_gj,
      IFNULL(t489.zielerreich, '') AS zielerreichung,
      CAST(NULL AS NUMERIC) AS check_gj,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj2,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t489 ON vis0.mandant_id = t489.mandant_id AND vis0.wup_id = t489.wup_id AND vis0.wrg_id = t489.wrg_id
            AND t489.metrik_id = 92 AND t489.typ_id = 0 AND t489.level_id = 0
     UNION ALL
     SELECT 93 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC) AS eingabe_gj,
      IFNULL(t509.kommentar_gj, '') AS kommentar_gj,
      IFNULL(t509.zielerreich, '') AS zielerreichung,
      CAST(NULL AS NUMERIC) AS check_gj,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj2,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t509 ON vis0.mandant_id = t509.mandant_id AND vis0.wup_id = t509.wup_id AND vis0.wrg_id = t509.wrg_id
            AND t509.metrik_id = 93 AND t509.typ_id = 0 AND t509.level_id = 0
     UNION ALL
     SELECT 94 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC) AS eingabe_gj,
      IFNULL(t529.kommentar_gj, '') AS kommentar_gj,
      IFNULL(t529.zielerreich, '') AS zielerreichung,
      CAST(NULL AS NUMERIC) AS check_gj,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj2,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t529 ON vis0.mandant_id = t529.mandant_id AND vis0.wup_id = t529.wup_id AND vis0.wrg_id = t529.wrg_id
            AND t529.metrik_id = 94 AND t529.typ_id = 0 AND t529.level_id = 0
     UNION ALL
     SELECT 95 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC) AS eingabe_gj,
      IFNULL(t549.kommentar_gj, '') AS kommentar_gj,
      IFNULL(t549.zielerreich, '') AS zielerreichung,
      CAST(NULL AS NUMERIC) AS check_gj,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj2,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t549 ON vis0.mandant_id = t549.mandant_id AND vis0.wup_id = t549.wup_id AND vis0.wrg_id = t549.wrg_id
            AND t549.metrik_id = 95 AND t549.typ_id = 0 AND t549.level_id = 0
     UNION ALL
     SELECT jzg.metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      IFNULL(t571.zielwert_gj, 0) AS eingabe_gj,
      IFNULL(t571.kommentar_gj, '') AS kommentar_gj,
      IFNULL(t571.zielerreich, '') AS zielerreichung,
      CAST(NULL AS NUMERIC) AS check_gj,
      t571.zielwert_gj AS ziel_gj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_gj2,
      t571.zielwert_gj AS ziel_gj
     FROM VIS_MAIN AS vis0
      INNER JOIN (SELECT metrik_id,
        metrik_fg
       FROM kfl_production_dbp_msi_view_vis.mv_vis_jzg_l_metrik
       WHERE metrik_fg IN (10, 30)) AS jzg ON TRUE
      LEFT JOIN ZIEL AS t571 ON vis0.mandant_id = t571.mandant_id AND vis0.wup_id = t571.wup_id AND vis0.wrg_id = t571.wrg_id
            AND jzg.metrik_id = t571.metrik_id AND t571.typ_id = 0 AND t571.level_id = 0));