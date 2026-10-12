CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jzg_fakt_data AS WITH ZEIT AS (SELECT gj,
   kjmo,
   mo_kj,
    gj - 1 AS gj_vj,
   kjmo_vj
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
   JZG.zielwert_eingabe AS zielwert_vj,
   JZG.kommentar_eingabe AS kommentar_vj
  FROM kfl_production_dbp_msi_view_vis.mv_vis_jzg_fakt_eingabe AS JZG
   INNER JOIN WUP AS t7 ON JZG.wup_id = t7.wup_id AND JZG.mandant_id = t7.mandant_id
   INNER JOIN kfl_production_dbp_view.v_jahr_gj AS JAHR ON JZG.gj = JAHR.gj AND JAHR.akt_gj = - 1), VIS_MAIN AS (SELECT
   VIS_GJ.mandant_id,
   VIS_GJ.nb_id,
   t4.aktuell_wup_id AS wup_id,
   VIS_GJ.wrg_id,
   0 AS zero,
   t1.gj,
   SUM(VIS_GJ.ums_netto_plan) AS ums_plan_gj,
   SUM(VIS_GJ.pers_std_plan) AS std_plan_gj,
   SUM(VIS_VJ.ums_netto) AS ums_netto_vj,
   SUM(VIS_VJ.anz_kunde) AS anz_kunde_vj,
   SUM(VIS_VJ.pers_std) AS std_netto_vj,
   SUM(VIS_VJ.pers_kosten) AS pk_wert_vj,
   SUM(VIS_VJ.ums_netto_plan) AS ums_plan_vj,
   SUM(VIS_VJ.pers_std_plan) AS std_plan_vj,
   MAX(t9.zielwert_vj) AS ums_ziel_vj,
    MAX(t9.zielwert_vj) / IF(SUM(VIS_VJ.ums_netto_plan) = 0, NULL, SUM(VIS_VJ.ums_netto_plan)) AS faktor_vj,
   MAX(t9.kommentar_vj) AS ums_komm_vj
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup AS VIS_GJ
   INNER JOIN kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup AS VIS_VJ ON VIS_GJ.mandant_id = VIS_VJ.mandant_id
        AND VIS_GJ.wup_id = VIS_VJ.wup_id AND VIS_GJ.wrg_id = VIS_VJ.wrg_id AND VIS_VJ.kjmo = VIS_GJ.kjmo - 100
   INNER JOIN ZEIT AS t1 ON VIS_GJ.kjmo = t1.kjmo
   INNER JOIN WUP AS t4 ON VIS_GJ.wup_id = t4.wup_id AND VIS_GJ.mandant_id = t4.mandant_id
   LEFT JOIN ZIEL AS t9 ON VIS_GJ.mandant_id = t9.mandant_id AND VIS_GJ.wup_id = t9.wup_id AND VIS_GJ.wrg_id = t9.wrg_id
         AND t9.metrik_id = 10 AND t9.typ_id = 0 AND t9.level_id = 0
  WHERE t4.stl_gj + 2 > t1.gj
   AND t4.neo_gj <= t1.gj
  GROUP BY VIS_GJ.mandant_id,
   VIS_GJ.nb_id,
   wup_id,
   VIS_GJ.wrg_id,
   zero,
   t1.gj), WARE AS (SELECT ABT.abt_id,
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
  WHERE ABT.abt_id IN (4, 5, 6, 7, 8)), VIS_WG AS (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   t36.gj,
   t33.abt_id,
   t33.hwg_id,
   t33.owg_id,
   t33.level_abt,
   t33.level_hwg,
   t33.level_owg,
   SUM(VIS.ums_netto) AS ums_netto,
   SUM(VIS.ums_netto_kvj) AS ums_netto_kvj,
   SUM(VIS.menge_kvj) AS menge_kvj
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wg AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN WARE AS t33 ON WG.owg_id = t33.owg_id
   INNER JOIN ZEIT AS t36 ON VIS.kjmo = t36.kjmo
   INNER JOIN WUP AS t39 ON VIS.wup_id = t39.wup_id AND VIS.mandant_id = t39.mandant_id
  WHERE t39.stl_gj + 2 > t36.gj
   AND t39.neo_gj <= t36.gj
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   t33.abt_id,
   t33.hwg_id,
   t33.owg_id,
   t33.level_owg,
   t33.level_hwg,
   t33.level_abt,
   t36.gj), VIS_ABT AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   level_id,
   SUM(ums_netto) AS ums_ware,
   SUM(ums_netto_kvj) AS ums_ware_vj,
   SUM(menge_kvj) AS mng_ware_vj
  FROM (SELECT mandant_id,
     nb_id,
     wup_id,
     wrg_id,
     gj,
     abt_id,
     level_abt AS level_id,
     ums_netto,
     ums_netto_kvj,
     menge_kvj
    FROM VIS_WG AS vis) AS t43
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   level_id), VIS_PLAN AS (SELECT VIS0.mandant_id,
   VIS0.nb_id,
   VIS0.wup_id,
   VIS0.wrg_id,
   t52.gj,
   t49.abt_id,
   t49.hwg_id,
   t49.owg_id,
   t49.level_abt,
   t49.level_hwg,
   t49.level_owg,
   SUM(VIS0.umsatz_netto_plan) AS ums_plan_gj,
   SUM(VIS0.abschriften_netto_operativ_plan) AS abs_plan_gj,
   SUM(VIS_VJ0.umsatz_netto_plan) AS ums_plan_vj,
   SUM(VIS_VJ0.abschriften_netto_operativ_plan) AS abs_plan_vj,
   MAX(t60.zielwert_vj) AS abs_eing_vj,
    SUM(VIS_VJ0.umsatz_netto_plan) * MAX(t60.zielwert_vj) AS abs_kalk_vj
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg AS VIS0
   LEFT JOIN kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg AS VIS_VJ0 ON VIS0.mandant_id = VIS_VJ0.mandant_id AND
        VIS0.wup_id = VIS_VJ0.wup_id AND VIS0.wrg_id = VIS_VJ0.wrg_id AND VIS0.owg_id = VIS_VJ0.owg_id AND VIS_VJ0.kjmo
     = VIS0.kjmo - 100
   INNER JOIN WARE AS t49 ON VIS0.owg_id = t49.owg_id
   INNER JOIN ZEIT AS t52 ON VIS0.kjmo = t52.kjmo
   INNER JOIN WUP AS t55 ON VIS0.wup_id = t55.wup_id AND VIS0.mandant_id = t55.mandant_id
   LEFT JOIN ZIEL AS t60 ON VIS0.mandant_id = t60.mandant_id AND VIS0.wup_id = t60.wup_id AND VIS0.wrg_id = t60.wrg_id
     AND t60.metrik_id = 40 AND t49.level_owg = t60.level_id
  WHERE t55.stl_gj + 2 > t52.gj
   AND t55.neo_gj <= t52.gj
  GROUP BY VIS0.mandant_id,
   VIS0.nb_id,
   VIS0.wup_id,
   VIS0.wrg_id,
   t49.abt_id,
   t49.hwg_id,
   t49.owg_id,
   t49.level_owg,
   t49.level_hwg,
   t49.level_abt,
   t52.gj), VIS_ABT_PLAN AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   level_id,
   SUM(ums_plan_gj) AS ums_plan_gj,
   SUM(abs_plan_gj) AS abs_plan_gj,
   SUM(ums_plan_vj) AS ums_plan_vj,
   SUM(abs_plan_vj) AS abs_plan_vj,
   MAX(`A118613`) AS abs_eing_vj,
   SUM(abs_kalk_vj) AS abs_kalk_vj
  FROM (SELECT mandant_id,
     nb_id,
     wup_id,
     wrg_id,
     gj,
     abt_id,
     level_abt AS level_id,
     ums_plan_gj,
     abs_plan_gj,
     ums_plan_vj,
     abs_plan_vj,
     abs_kalk_vj,
     IF(abt_id IN (4, 7, 8), abs_eing_vj, NULL) AS `A118613`
    FROM VIS_PLAN AS vis) AS t66
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   level_id), VIS_HWG AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   hwg_id,
   level_hwg AS level_id,
   SUM(ums_netto) AS ums_ware,
   SUM(ums_netto_kvj) AS ums_ware_vj,
   SUM(menge_kvj) AS mng_ware_vj
  FROM VIS_WG AS vis
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   hwg_id,
   level_id), VIS_HWG_PLAN AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   hwg_id,
   level_id,
   SUM(ums_plan_gj) AS ums_plan_gj,
   SUM(abs_plan_gj) AS abs_plan_gj,
   SUM(ums_plan_vj) AS ums_plan_vj,
   SUM(abs_plan_vj) AS abs_plan_vj,
   MAX(`A118614`) AS abs_eing_vj,
   SUM(abs_kalk_vj) AS abs_kalk_vj
  FROM (SELECT mandant_id,
     nb_id,
     wup_id,
     wrg_id,
     gj,
     abt_id,
     hwg_id,
     level_hwg AS level_id,
     ums_plan_gj,
     abs_plan_gj,
     ums_plan_vj,
     abs_plan_vj,
     abs_kalk_vj,
     IF(abt_id = 6, abs_eing_vj, NULL) AS `A118614`
    FROM VIS_PLAN AS vis) AS t121
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   hwg_id,
   level_id), VIS_OWG AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   hwg_id,
   owg_id,
   level_owg AS level_id,
   SUM(ums_netto) AS ums_ware,
   SUM(ums_netto_kvj) AS ums_ware_vj,
   SUM(menge_kvj) AS mng_ware_vj
  FROM VIS_WG AS vis
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   hwg_id,
   owg_id,
   level_id), VIS_OWG_PLAN AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   hwg_id,
   owg_id,
   level_id,
   SUM(ums_plan_gj) AS ums_plan_gj,
   SUM(abs_plan_gj) AS abs_plan_gj,
   SUM(ums_plan_vj) AS ums_plan_vj,
   SUM(abs_plan_vj) AS abs_plan_vj,
   MAX(abs_eing_vj) AS abs_eing_vj,
   SUM(abs_kalk_vj) AS abs_kalk_vj
  FROM (SELECT mandant_id,
     nb_id,
     wup_id,
     wrg_id,
     gj,
     abt_id,
     hwg_id,
     owg_id,
     level_owg AS level_id,
     ums_plan_gj,
     abs_plan_gj,
     ums_plan_vj,
     abs_plan_vj,
     abs_eing_vj,
     abs_kalk_vj
    FROM VIS_PLAN AS vis) AS t175
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   abt_id,
   hwg_id,
   owg_id,
   level_id), ZEIT_TAG_VJ AS (SELECT gj + 1 AS gj,
   gj AS gj_vj,
   kjmo AS kjmo_vj,
   mo_kj,
   dat AS dat_vj
  FROM kfl_production_dbp_view.v_tag
  WHERE akt_gj = - 1), VIS_KASSE AS (SELECT VIS.mandant_id,
   VIS.nb_id,
   krs.nach_wrg_id AS wrg_id,
   t293.aktuell_wup_id AS wup_id,
   t290.gj,
   SUM(VIS.umsatz_netto * krs.umrechnungskurs) AS kass_ums_vj,
   SUM(VIS.anz_kunden) AS kass_bon_vj,
   SUM(VIS.anz_artikel) AS kass_art_vj,
   SUM(VIS.umsatz_netto_kscan * krs.umrechnungskurs) AS kscan_ums_vj,
   SUM(VIS.anz_bon_kscan) AS kscan_bon_vj,
   SUM(VIS.anz_zeilen_kscan) AS kscan_art_vj,
   SUM(IF(ktp.kasse_typ_id = 1, VIS.umsatz_netto * krs.umrechnungskurs, 0)) AS pos_ums_vj,
   SUM(IF(ktp.kasse_typ_id = 1, VIS.anz_kunden, 0)) AS pos_knd_vj,
   SUM(IF(ktp.kasse_typ_id = 1, VIS.anz_artikel, 0)) AS pos_art_vj,
   SUM(IF(ktp.kasse_typ_id <> 1, VIS.umsatz_netto * krs.umrechnungskurs, 0)) AS sco_ums_vj,
   SUM(IF(ktp.kasse_typ_id <> 1, VIS.anz_kunden, 0)) AS sco_bon_vj,
   SUM(IF(ktp.kasse_typ_id <> 1, VIS.anz_artikel, 0)) AS sco_art_vj,
   SUM(IF(ktp.kasse_typ_id = 1, VIS.anz_artikel / 100000.00, NULL)) AS pos_art100t_vj,
   SUM(IF(ktp.kasse_typ_id = 1, VIS.registrierzeit / 60.0000, NULL)) AS pos_scan_m_vj,
   SUM(IF(ktp.kasse_typ_id = 1, VIS.kassierzeit / 3600.0000, NULL)) AS pos_kstd_vj
  FROM kfl_production_dbp_view.v_vis_tag_kasse AS VIS
   INNER JOIN (SELECT KTP.mandant_id,
     KTP.wup_id,
     t280.dat_vj,
     KTP.kasse_nr,
     KTP.kasse_typ_id
    FROM kfl_production_dbp_view.v_kasse_typ_per AS KTP
     INNER JOIN ZEIT_TAG_VJ AS t280 ON t280.dat_vj BETWEEN KTP.dat_von AND KTP.dat_bis
    WHERE KTP.kasse_typ_id IN (1, 8, 9, 10, 11)) AS ktp ON VIS.mandant_id = ktp.mandant_id AND VIS.wup_id = ktp.wup_id
     AND VIS.kasse_nr = ktp.kasse_nr AND VIS.dat = ktp.dat_vj
   INNER JOIN (SELECT von_wrg_id,
      nach_wrg_id,
      umrechnungskurs
     FROM kfl_production_dbp_data.kurs AS KRS1
     WHERE kurstyp_id = 3
      AND dat_bis = DATE '9999-12-31'
      AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
     UNION ALL
     SELECT von_wrg_id,
      von_wrg_id AS von_wrg_id0,
      1.0000
     FROM kfl_production_dbp_data.kurs AS KRS2
     WHERE kurstyp_id = 3
      AND dat_bis = DATE '9999-12-31'
      AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON VIS.wrg_id = krs.von_wrg_id
   INNER JOIN ZEIT_TAG_VJ AS t290 ON VIS.dat = t290.dat_vj
   INNER JOIN WUP AS t293 ON VIS.wup_id = t293.wup_id AND VIS.mandant_id = t293.mandant_id
  WHERE t293.stl_gj + 2 > t290.gj
   AND t293.neo_gj <= t290.gj
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   wrg_id,
   wup_id,
   t290.gj), VIS_ODS_KA AS (SELECT VIS.mandant_id,
   t324.aktuell_wup_id AS wup_id,
   t321.gj,
   SUM(VIS.anz_scans) AS scan_anz_vj,
   SUM(VIS.sum_scan_sek / 60) AS scan_min_vj
  FROM kfl_production_dbp_v_ods.v_ods_bon_kassenabschluss AS VIS
   INNER JOIN ZEIT_TAG_VJ AS t321 ON VIS.bon_dat = t321.dat_vj
   INNER JOIN WUP AS t324 ON VIS.wup_id = t324.wup_id AND VIS.mandant_id = t324.mandant_id
  WHERE t324.stl_gj + 2 > t321.gj
   AND t324.neo_gj <= t321.gj
  GROUP BY VIS.mandant_id,
   wup_id,
   t321.gj), VIS_WCAL AS (SELECT VIS.mandant_id,
   VIS.nb_id,
   t519.aktuell_wup_id AS wup_id,
   t516.gj,
   SUM(VIS.bonanzahl_sug) AS bon_vj,
   SUM(VIS.bonanzahl_kundenkarte) AS kundkart,
   SUM(VIS.bonanzahl_kundenkarte_payback) AS payback,
    SUM(VIS.bonanzahl_kundenkarte) - IFNULL(SUM(VIS.bonanzahl_kundenkarte_payback), 0) AS kcard_vj
  FROM kfl_production_dbp_view.v_wupcal AS VIS
   INNER JOIN ZEIT_TAG_VJ AS t516 ON VIS.dat = t516.dat_vj
   INNER JOIN WUP AS t519 ON VIS.mandant_id = t519.mandant_id AND VIS.wup_id = t519.wup_id
  WHERE t519.stl_gj + 2 > t516.gj
   AND t519.neo_gj <= t516.gj
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   wup_id,
   t516.gj), VIS_FIL_PLAN AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   level_id,
   SUM(ums_plan_gj) AS ums_plan_gj,
   SUM(abs_plan_gj) AS abs_plan_gj,
   SUM(ums_plan_vj) AS ums_plan_vj,
   SUM(abs_plan_vj) AS abs_plan_vj,
   abs_eing_vj,
   SUM(abs_kalk_vj) AS abs_kalk_vj
  FROM (SELECT mandant_id,
     nb_id,
     wup_id,
     wrg_id,
     gj,
     0 AS level_id,
     ums_plan_gj,
     abs_plan_gj,
     ums_plan_vj,
     abs_plan_vj,
     NULL AS abs_eing_vj,
     abs_kalk_vj
    FROM VIS_PLAN AS vis) AS t563
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   level_id,
   abs_eing_vj), VIS_ABSCHRIFTEN AS (SELECT t578.mandant_id,
   t578.nb_id,
   t578.wup_id,
   t578.wrg_id,
   t578.gj0 AS gj,
   t578.abt_id0 AS abt_id,
   t578.hwg_id,
   t578.owg_id0 AS owg_id,
   t578.level_abt,
   t578.level_hwg,
   t578.level_owg,
   t578.abs_netto_vj
  FROM (SELECT VIS3.mandant_id,
     VIS3.nb_id,
     VIS3.wup_id,
     VIS3.wrg_id,
     t569.abt_id AS abt_id0,
     t569.hwg_id,
     t569.owg_id AS owg_id0,
     t569.level_owg,
     t569.level_hwg,
     t569.level_abt,
     t572.gj AS gj0,
     SUM(CASE
        WHEN VIS3.mandant_id = 6 AND VIS3.abschriftart_id = 2 OR VIS3.mandant_id = 3 AND VIS3.abschriftart_id = 11 OR
             VIS3.mandant_id IN (2, 4, 5, 7, 8) AND VIS3.abschriftart_id = 7 OR VIS3.mandant_id IN (2, 5) AND VIS3.abschriftart_id
             = 10 OR VIS3.abschriftart_id = 20 AND VIS3.mandant_id NOT IN (1)
        THEN 1
        ELSE - 1
        END * VIS3.abschrift_netto) AS abs_netto_vj
    FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_abschriften_wg AS VIS3
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int AS WG ON VIS3.wg_id = WG.wg_id
     INNER JOIN WARE AS t569 ON WG.owg_id = t569.owg_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu AS AAZ ON VIS3.abschriftart_id = AAZ.abschriftart_id
        AND VIS3.mandant_id = AAZ.mandant_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu AS ATZ ON AAZ.abschriftart_int_id = ATZ.abschriftart_int_id
      
     INNER JOIN ZEIT_TAG_VJ AS t572 ON VIS3.dat = t572.dat_vj
     INNER JOIN WUP AS t575 ON VIS3.wup_id = t575.wup_id AND VIS3.mandant_id = t575.mandant_id
    WHERE t575.stl_gj + 2 > t572.gj
     AND t575.neo_gj <= t572.gj
     AND ATZ.abschriftart_thema_int_id IN (1, 4)
    GROUP BY VIS3.mandant_id,
     VIS3.nb_id,
     VIS3.wup_id,
     VIS3.wrg_id,
     abt_id0,
     t569.hwg_id,
     owg_id0,
     t569.level_owg,
     t569.level_hwg,
     t569.level_abt,
     gj0) AS t578), VIS_FIL_ABS AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   0 AS level_id,
   SUM(abs_netto_vj) AS abs_netto_vj
  FROM VIS_ABSCHRIFTEN AS vis
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   level_id), VIS_FIL AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   SUM(ums_netto) AS ums_ware,
   SUM(ums_netto_kvj) AS ums_ware_vj,
   SUM(menge_kvj) AS mng_ware_vj
  FROM VIS_WG AS vis
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj), VIS_ABT_ABS AS (SELECT vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.wrg_id,
   vis.gj,
   vis.abt_id,
   vis.level_abt AS level_id,
   SUM(vis.abs_netto_vj) AS abs_netto_vj,
   MAX(t654.kommentar_vj) AS kommentar_vj
  FROM VIS_ABSCHRIFTEN AS vis
   LEFT JOIN ZIEL AS t654 ON vis.mandant_id = t654.mandant_id AND vis.wup_id = t654.wup_id AND vis.wrg_id = t654.wrg_id
      AND t654.metrik_id = 40 AND t654.typ_id = 1 AND vis.level_abt = t654.level_id
  GROUP BY vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.wrg_id,
   vis.gj,
   vis.abt_id,
   level_id), VIS_HWG_ABS AS (SELECT vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.wrg_id,
   vis.gj,
   vis.abt_id,
   vis.hwg_id,
   vis.level_hwg AS level_id,
   SUM(vis.abs_netto_vj) AS abs_netto_vj,
   MAX(t729.kommentar_vj) AS kommentar_vj
  FROM VIS_ABSCHRIFTEN AS vis
   LEFT JOIN ZIEL AS t729 ON vis.mandant_id = t729.mandant_id AND vis.wup_id = t729.wup_id AND vis.wrg_id = t729.wrg_id
      AND t729.metrik_id = 40 AND t729.typ_id = 2 AND vis.level_hwg = t729.level_id
  WHERE vis.abt_id IN (5, 6)
  GROUP BY vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.wrg_id,
   vis.gj,
   vis.abt_id,
   vis.hwg_id,
   level_id), VIS_OWG_ABS AS (SELECT vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.wrg_id,
   vis.gj,
   vis.abt_id,
   vis.hwg_id,
   vis.owg_id,
   vis.level_owg AS level_id,
   SUM(vis.abs_netto_vj) AS abs_netto_vj,
   MAX(t805.kommentar_vj) AS kommentar_vj
  FROM VIS_ABSCHRIFTEN AS vis
   LEFT JOIN ZIEL AS t805 ON vis.mandant_id = t805.mandant_id AND vis.wup_id = t805.wup_id AND vis.wrg_id = t805.wrg_id
      AND t805.metrik_id = 40 AND t805.typ_id = 3 AND vis.level_owg = t805.level_id
  WHERE vis.abt_id = 5
  GROUP BY vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.wrg_id,
   vis.gj,
   vis.abt_id,
   vis.hwg_id,
   vis.owg_id,
   level_id), VIS_ABT_INV_PLAN AS (SELECT vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.wrg_id,
   vis.gj,
   vis.abt_id,
   vis.level_abt AS level_id,
   SUM(vis.ums_plan_gj) AS ums_plan_gj,
   SUM(vis.ums_plan_vj) AS ums_plan_vj,
   MAX(t864.kommentar_vj) AS kommentar_vj,
   MAX(t864.zielwert_vj) AS inv_eing_vj,
    SUM(vis.ums_plan_vj) * MAX(t864.zielwert_vj) AS inv_kalk_vj
  FROM VIS_PLAN AS vis
   LEFT JOIN ZIEL AS t864 ON vis.mandant_id = t864.mandant_id AND vis.wup_id = t864.wup_id AND vis.wrg_id = t864.wrg_id
     AND t864.metrik_id = 46 AND vis.level_abt = t864.level_id
  GROUP BY vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.wrg_id,
   vis.gj,
   vis.abt_id,
   level_id), VIS_FIL_INV_PLAN AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   SUM(ums_plan_gj) AS ums_plan_gj,
   SUM(ums_plan_vj) AS ums_plan_vj,
   kommentar_vj,
   kommentar_vj AS inv_eing_vj,
   SUM(inv_kalk_vj) AS inv_kalk_vj
  FROM (SELECT mandant_id,
     nb_id,
     wup_id,
     wrg_id,
     gj,
     ums_plan_gj,
     ums_plan_vj,
     NULL AS kommentar_vj,
     NULL AS inv_eing_vj,
     inv_kalk_vj
    FROM VIS_ABT_INV_PLAN AS vis) AS t868
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   kommentar_vj,
   inv_eing_vj), VIS_ABT_INV AS (SELECT VIS11.mandant_id,
   VIS11.nb_id,
   t885.aktuell_wup_id AS wup_id,
   krs.nach_wrg_id AS wrg_id,
   t882.gj,
   t879.abt_id,
   t879.level_abt AS level_id,
   SUM(VIS11.inventur_wert_vk_netto * krs.umrechnungskurs) AS inv_wert_vj,
   SUM(VIS11.umsatz_vk_netto_sum * krs.umrechnungskurs) AS inv_ums_vj
  FROM kfl_production_dbp_view.v_hfm_inventur_termin_owg_wup_zu AS VIS11
   INNER JOIN (SELECT von_wrg_id,
      nach_wrg_id,
      umrechnungskurs
     FROM kfl_production_dbp_data.kurs AS KRS1
     WHERE kurstyp_id = 3
      AND dat_bis = DATE '9999-12-31'
      AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
     UNION ALL
     SELECT von_wrg_id,
      von_wrg_id AS von_wrg_id0,
      1.0000
     FROM kfl_production_dbp_data.kurs AS KRS2
     WHERE kurstyp_id = 3
      AND dat_bis = DATE '9999-12-31'
      AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON VIS11.wrg_id = krs.von_wrg_id
   INNER JOIN WARE AS t879 ON VIS11.owg_id = t879.owg_id
   INNER JOIN ZEIT_TAG_VJ AS t882 ON VIS11.dat_plan_zaehlung = t882.dat_vj
   INNER JOIN WUP AS t885 ON VIS11.wup_id = t885.wup_id AND VIS11.mandant_id = t885.mandant_id
  WHERE t885.stl_gj + 2 > t882.gj
   AND t885.neo_gj <= t882.gj
   AND VIS11.inventurart_int_id = 8
  GROUP BY VIS11.mandant_id,
   VIS11.nb_id,
   wup_id,
   wrg_id,
   t882.gj,
   t879.abt_id,
   level_id), VIS_FIL_INV AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   SUM(inv_wert_vj) AS inv_wert_vj,
   SUM(inv_ums_vj) AS inv_ums_vj
  FROM VIS_ABT_INV AS vis
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj), VIS_KURZCHECK AS (SELECT kmr.mandant_id,
   kmr.nb_id,
   kmr.wup_id,
   t987.gj,
   SUM(kmr.ergebnis_ok) AS kmr_ok_vj,
   SUM(kmr.ergebnis_nok) AS kmr_nok_vj,
   SUM(kmr.ergebnis_anz) AS kmr_anz_vj
  FROM (SELECT WUP.mandant_id,
      WUP.nb_id,
      WUP.aktuell_wup_id AS wup_id,
      KMR_PRF.dat_pruef_zeitraum_bis AS dat,
      IF(KMR_FRG.ergebnis_num = 1, 1, 0) AS ergebnis_nok,
      IF(KMR_FRG.ergebnis_num >= 0, 1, 0) AS ergebnis_anz,
      IF(KMR_FRG.ergebnis_num = 0, 1, 0) AS ergebnis_ok
     FROM kfl_production_dbp_view.v_kmr_frage AS KMR_FRG
      INNER JOIN kfl_production_dbp_view.v_kmr_pruefprogramm_kapitel AS KMR_KAP ON KMR_FRG.kapitel_id = KMR_KAP.kapitel_id
         AND KMR_FRG.amx_system_id = KMR_KAP.amx_system_id
      INNER JOIN kfl_production_dbp_view.v_kmr_pruefung AS KMR_PRF ON KMR_KAP.pruefung_id = KMR_PRF.pruefung_id AND
        KMR_KAP.amx_system_id = KMR_PRF.amx_system_id
      INNER JOIN kfl_production_dbp_view.v_kmr_l_pruefung_klasse AS KMR_LPK ON KMR_PRF.pruefung_klasse_id = KMR_LPK.pruefung_klasse_id
         AND KMR_PRF.amx_system_id = KMR_LPK.amx_system_id
      INNER JOIN kfl_production_dbp_view.v_kmr_l_pruefung_status AS KMR_LPS ON KMR_PRF.pruefung_status_id = KMR_LPS.pruefung_status_id
         AND KMR_PRF.amx_system_id = KMR_LPS.amx_system_id
      INNER JOIN kfl_production_dbp_view.v_kmr_l_organisationseinheit AS KMR_LOE ON KMR_PRF.gepr_oe_id = KMR_LOE.orga_einheit_id
         AND KMR_PRF.amx_system_id = KMR_LOE.amx_system_id
      INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON KMR_LOE.wup_id = WUP.wup_id AND KMR_LOE.mandant_id = WUP.mandant_id
        
      INNER JOIN kfl_production_dbp_view.v_kmr_l_pruefprozess AS KMR_LPP ON KMR_KAP.gepr_prozess_id = KMR_LPP.gepr_prozess_id
         AND KMR_KAP.amx_system_id = KMR_LPP.amx_system_id
     WHERE KMR_FRG.amx_system_id = 1
      AND KMR_PRF.pruefung_klasse_id IN (100003)
      AND KMR_PRF.pruefung_status_id IN (100005, 100041)
      AND ROUND(SAFE_CAST(SUBSTR(KMR_FRG.sort_nr, 12, 4) AS BIGNUMERIC), 0) = 0
      AND WUP.mandant_id <> 1
     UNION ALL
     SELECT WUP.mandant_id,
      WUP.nb_id,
      WUP.aktuell_wup_id AS wup_id,
      amx_prf.dat_ende AS dat,
      IF(amx_frg.antwort_wert IN (1, 4), 1, 0) AS antwort_nok,
      IF(amx_frg.antwort_wert IN (0), 1, 0) AS antwort_ok,
      IF(amx_frg.antwort_wert IN (0, 1, 4), 1, 0) AS antwort_ges
     FROM (SELECT amx_frage_id,
        pruef_kapitel_id,
        antwort_wert,
        amx_frage_katalog_id
       FROM kfl_production_dbp_view.v_amx_frage
       WHERE amx_system_id = 1
        AND antwort_wert IN (0, 1, 4)) AS amx_frg
      INNER JOIN (SELECT amx_frage_katalog_id,
        hauptbereich_id,
        teilbereich_id,
        amx_handlung_typ_id
       FROM kfl_production_dbp_view.v_amx_frage_katalog
       WHERE amx_system_id = 1
        AND hauptbereich_id = 597230
        AND teilbereich_id = 597253
        AND amx_handlung_typ_id IN (1, 50000)
        AND SUBSTR(frage_nr, 6, 25) NOT IN (SELECT platzhalter_string
          FROM kfl_production_dbp_view.v_amx_filter_benutzeroberflaeche
          WHERE amx_system_id = 1
           AND amx_filter_typ_id = 3)) AS amx_kat ON amx_frg.amx_frage_katalog_id = amx_kat.amx_frage_katalog_id
      INNER JOIN (SELECT pruef_kapitel_id,
        pruefung_id
       FROM kfl_production_dbp_view.v_amx_pruef_kapitel
       WHERE amx_system_id = 1) AS amx_kap ON amx_frg.pruef_kapitel_id = amx_kap.pruef_kapitel_id
      INNER JOIN (SELECT business_process_id,
        pruefung_id
       FROM kfl_production_dbp_view.v_amx_b_process_pruefung_zu
       WHERE amx_system_id = 1
        AND business_process_id = 544687) AS amx_bpp ON amx_kap.pruefung_id = amx_bpp.pruefung_id
      INNER JOIN (SELECT mandant_id,
        wup_id,
        pruefung_id,
        dat_ende
       FROM kfl_production_dbp_view.v_amx_pruefung
       WHERE amx_system_id = 1
        AND zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041)) AS amx_prf ON amx_kap.pruefung_id = amx_prf.pruefung_id
       
      INNER JOIN kfl_production_dbp_data.wup AS WUP ON amx_prf.wup_id = WUP.wup_id AND amx_prf.mandant_id = WUP.mandant_id
        
     WHERE WUP.mandant_id <> 1) AS kmr
   INNER JOIN ZEIT_TAG_VJ AS t987 ON kmr.dat = t987.dat_vj
   INNER JOIN WUP AS t990 ON kmr.wup_id = t990.wup_id AND kmr.mandant_id = t990.mandant_id
  WHERE t990.stl_gj + 2 > t987.gj
   AND t990.neo_gj <= t987.gj
  GROUP BY kmr.mandant_id,
   kmr.nb_id,
   kmr.wup_id,
   t987.gj), VIS_REKL AS (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   t1017.gj,
   SUM(IF(VIS.reklamationsgrund_id IN (12, 19), 1, 0)) AS fehler_preis_vj,
   SUM(IF(VIS.reklamationsgrund_id IN (13, 14), 1, 0)) AS fehler_kasse_vj,
   SUM(IF(VIS.reklamationsgrund_id = 91, VIS.vk_menge_kuga, NULL)) AS warten_theke_vj,
   SUM(IF(VIS.reklamationsgrund_id = 92, VIS.vk_menge_kuga, NULL)) AS warten_kasse_vj,
   SUM(IF(VIS.reklamationsgrund_id = 93, VIS.vk_menge_kuga, NULL)) AS mangel_mhd_vj
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art AS VIS
   INNER JOIN ZEIT_TAG_VJ AS t1017 ON VIS.dat = t1017.dat_vj
   INNER JOIN WUP AS t1020 ON VIS.wup_id = t1020.wup_id AND VIS.mandant_id = t1020.mandant_id
  WHERE t1020.stl_gj + 2 > t1017.gj
   AND t1020.neo_gj <= t1017.gj
   AND VIS.reklamationsgrund_id IN (12, 13, 14, 19, 91, 92, 93)
   AND (VIS.mandant_id, VIS.art_id) IN (SELECT (mandant_id, art_id)
     FROM kfl_production_dbp_msi_view_vis.mv_art_wg_zu
     WHERE wg_id NOT IN (980))
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   t1017.gj), VIS_SHR AS (SELECT t1369.mandant_id,
   t1369.nb_id,
   t1369.wup_id,
   t1369.wrg_id,
   t1369.gj0 AS gj,
   t1369.std_ftag,
   t1369.std_mehr,
   t1369.std_spaet,
   t1369.std_we,
   t1369.std_krank,
   t1369.std_soll,
   t1369.aus_roll,
   t1369.kopf_roll,
   t1369.kopf_fil,
   t1369.kopf_ma,
   t1369.std_vtg,
   t1369.vzk_ma,
   t1369.tzk_ma
  FROM (SELECT VIS.mandant_id,
     VIS.nb_id,
     VIS.wup_id,
     VIS.wrg_id,
     t1363.gj AS gj0,
     SUM(VIS.stunden_zuschlag_feiertag) AS std_ftag,
     SUM(VIS.stunden_zuschlag_mehr) AS std_mehr,
     SUM(VIS.stunden_zuschlag_spaet_nacht) AS std_spaet,
     SUM(VIS.stunden_zuschlag_wochenende) AS std_we,
     SUM(VIS.tage_krank) AS std_krank,
     SUM(VIS.tage_arbeit_soll) AS std_soll,
     SUM(IF(t1363.mo_kj = 2, VIS.kopf_austritte_rol, 0)) AS aus_roll,
     SUM(IF(t1363.mo_kj = 2, VIS.kopf_fluktuation_rol, 0)) AS kopf_roll,
     SUM(IF(t1363.mo_kj = 2, VIS.kopf_filiale, 0)) AS kopf_fil,
     SUM(IF(t1363.mo_kj = 2, VIS.kopf_ma, 0)) AS kopf_ma,
     SUM(IF(t1363.mo_kj = 2, VIS.stunden_vertrag_ma, 0)) AS std_vtg,
     SUM(IF(t1363.mo_kj = 2, VIS.vzk_ma, 0)) AS vzk_ma,
     SUM(IF(t1363.mo_kj = 2, VIS.kopf_teilzeit, 0)) AS tzk_ma
    FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_shr_wup AS VIS
     INNER JOIN ZEIT AS t1363 ON VIS.kjmo = t1363.kjmo_vj
     INNER JOIN WUP AS t1366 ON VIS.wup_id = t1366.wup_id AND VIS.mandant_id = t1366.mandant_id
    WHERE t1366.stl_gj + 2 > t1363.gj
     AND t1366.neo_gj <= t1363.gj
    GROUP BY VIS.mandant_id,
     VIS.nb_id,
     VIS.wup_id,
     VIS.wrg_id,
     gj0) AS t1369), VIS_RUQ AS (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   t1467.gj,
   SUM(VIS.tage_urlaub_anspruch_akt_kj) AS ans_vj,
   SUM(VIS.tage_urlaub_abgeltung_kj_kum) AS abg_vj,
   SUM(VIS.tage_urlaub_rest_vj_kj) AS rst_vj,
   SUM(VIS.tage_urlaub_genommen_kj_kum) AS gen_vj
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_shr_wup_urlaub AS VIS
   INNER JOIN ZEIT AS t1467 ON VIS.kjmo = t1467.kjmo_vj AND t1467.mo_kj = 12
   INNER JOIN WUP AS t1470 ON VIS.wup_id = t1470.wup_id AND VIS.mandant_id = t1470.mandant_id
  WHERE t1470.stl_gj + 2 > t1467.gj
   AND t1470.neo_gj <= t1467.gj
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wrg_id,
   VIS.wup_id,
   t1467.gj) (SELECT *
  FROM (SELECT 10 AS metrik_id,
      zero AS typ_id,
      zero AS level_id,
      mandant_id,
      nb_id,
      wup_id,
      wrg_id,
      gj,
      ums_plan_gj AS plan_gj1,
      CAST(NULL AS BIGNUMERIC) AS plan_gj2,
      ums_plan_vj AS plan_vj1,
      CAST(NULL AS BIGNUMERIC) AS plan_vj2,
      ums_netto_vj AS wert_vj1,
      CAST(NULL AS BIGNUMERIC) AS wert_vj2,
      ums_ziel_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_vj2,
      ums_plan_gj AS plan_gj,
      ums_plan_vj AS plan_vj,
      ums_netto_vj AS wert_vj,
      ums_ziel_vj AS ziel_vj,
      faktor_vj AS check_vj,
      ums_komm_vj AS komm_vj,
       ums_netto_vj - ums_plan_vj AS delta,
        (ums_netto_vj - ums_plan_vj) / IF(ums_plan_vj = 0, NULL, ums_plan_vj) AS abw,
       ums_netto_vj - ums_ziel_vj AS delta_z,
        (ums_netto_vj - ums_ziel_vj) / IF(ums_ziel_vj = 0, NULL, ums_ziel_vj) AS abw_z
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
      sub2.ums_plan_gj AS plan_gj1,
      CAST(NULL AS BIGNUMERIC) AS plan_gj2,
      sub2.ums_plan_vj AS plan_vj1,
      CAST(NULL AS BIGNUMERIC) AS plan_vj2,
      sub1.ums_ware_vj AS wert_vj1,
      CAST(NULL AS BIGNUMERIC) AS wert_vj2,
       sub2.ums_plan_vj * vis0.faktor_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_vj2,
      sub2.ums_plan_gj AS plan_gj,
      sub2.ums_plan_vj AS plan_vj,
      sub1.ums_ware_vj AS wert_vj,
       sub2.ums_plan_vj * vis0.faktor_vj AS ziel_vj,
      vis0.faktor_vj AS check_vj,
      CAST(NULL AS STRING) AS komm_vj,
       sub1.ums_ware_vj - sub2.ums_plan_vj AS delta,
        (sub1.ums_ware_vj - sub2.ums_plan_vj) / IF(sub2.ums_plan_vj = 0, NULL, sub2.ums_plan_vj) AS abw,
       sub1.ums_ware_vj - sub2.ums_plan_vj * vis0.faktor_vj AS delta_z,
        (sub1.ums_ware_vj - sub2.ums_plan_vj * vis0.faktor_vj) / IF(sub2.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub2.ums_plan_vj
          * vis0.faktor_vj) AS abw_z
     FROM VIS_MAIN AS vis0
      INNER JOIN VIS_ABT AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      INNER JOIN VIS_ABT_PLAN AS sub2 ON vis0.mandant_id = sub2.mandant_id AND vis0.wup_id = sub2.wup_id AND vis0.wrg_id
          = sub2.wrg_id AND sub1.abt_id = sub2.abt_id
     UNION ALL
     SELECT 10 AS metrik_id,
      2 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      sub2.ums_plan_gj AS plan_gj1,
      CAST(NULL AS BIGNUMERIC) AS plan_gj2,
      sub2.ums_plan_vj AS plan_vj1,
      CAST(NULL AS BIGNUMERIC) AS plan_vj2,
      sub1.ums_ware_vj AS wert_vj1,
      CAST(NULL AS BIGNUMERIC) AS wert_vj2,
       sub2.ums_plan_vj * vis0.faktor_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_vj2,
      sub2.ums_plan_gj AS plan_gj,
      sub2.ums_plan_vj AS plan_vj,
      sub1.ums_ware_vj AS wert_vj,
       sub2.ums_plan_vj * vis0.faktor_vj AS ziel_vj,
      vis0.faktor_vj AS check_vj,
      CAST(NULL AS STRING) AS komm_vj,
       sub1.ums_ware_vj - sub2.ums_plan_vj AS delta,
        (sub1.ums_ware_vj - sub2.ums_plan_vj) / IF(sub2.ums_plan_vj = 0, NULL, sub2.ums_plan_vj) AS abw,
       sub1.ums_ware_vj - sub2.ums_plan_vj * vis0.faktor_vj AS delta_z,
        (sub1.ums_ware_vj - sub2.ums_plan_vj * vis0.faktor_vj) / IF(sub2.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub2.ums_plan_vj
          * vis0.faktor_vj) AS abw_z
     FROM VIS_MAIN AS vis0
      INNER JOIN VIS_HWG AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      INNER JOIN VIS_HWG_PLAN AS sub2 ON vis0.mandant_id = sub2.mandant_id AND vis0.wup_id = sub2.wup_id AND vis0.wrg_id
          = sub2.wrg_id AND sub1.hwg_id = sub2.hwg_id
     UNION ALL
     SELECT 10 AS metrik_id,
      3 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      sub2.ums_plan_gj AS plan_gj1,
      CAST(NULL AS BIGNUMERIC) AS plan_gj2,
      sub2.ums_plan_vj AS plan_vj1,
      CAST(NULL AS BIGNUMERIC) AS plan_vj2,
      sub1.ums_ware_vj AS wert_vj1,
      CAST(NULL AS BIGNUMERIC) AS wert_vj2,
       sub2.ums_plan_vj * vis0.faktor_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_vj2,
      sub2.ums_plan_gj AS plan_gj,
      sub2.ums_plan_vj AS plan_vj,
      sub1.ums_ware_vj AS wert_vj,
       sub2.ums_plan_vj * vis0.faktor_vj AS ziel_vj,
      vis0.faktor_vj AS check_vj,
      CAST(NULL AS STRING) AS komm_vj,
       sub1.ums_ware_vj - sub2.ums_plan_vj AS delta,
        (sub1.ums_ware_vj - sub2.ums_plan_vj) / IF(sub2.ums_plan_vj = 0, NULL, sub2.ums_plan_vj) AS abw,
       sub1.ums_ware_vj - sub2.ums_plan_vj * vis0.faktor_vj AS delta_z,
        (sub1.ums_ware_vj - sub2.ums_plan_vj * vis0.faktor_vj) / IF(sub2.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub2.ums_plan_vj
          * vis0.faktor_vj) AS abw_z
     FROM VIS_MAIN AS vis0
      INNER JOIN VIS_OWG AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      INNER JOIN VIS_OWG_PLAN AS sub2 ON vis0.mandant_id = sub2.mandant_id AND vis0.wup_id = sub2.wup_id AND vis0.wrg_id
          = sub2.wrg_id AND sub1.owg_id = sub2.owg_id
     UNION ALL
     SELECT 16 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      vis0.anz_kunde_vj AS wert_vj1,
      CAST(NULL AS BIGNUMERIC) AS wert_vj2,
      t198.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      vis0.anz_kunde_vj AS wert_vj,
      t198.zielwert_vj AS ziel_vj,
      CAST(NULL AS NUMERIC) AS check_vj,
      t198.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
       vis0.anz_kunde_vj - t198.zielwert_vj AS delta_z,
        (vis0.anz_kunde_vj - t198.zielwert_vj) / IF(t198.zielwert_vj = 0, NULL, t198.zielwert_vj) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t198 ON vis0.mandant_id = t198.mandant_id AND vis0.wup_id = t198.wup_id AND vis0.wrg_id = t198.wrg_id
            AND t198.metrik_id = 16 AND t198.typ_id = 0 AND t198.level_id = 0
     UNION ALL
     SELECT 18 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      vis0.ums_netto_vj AS wert_vj1,
      vis0.anz_kunde_vj AS wert_vj2,
      vis0.ums_ziel_vj AS ziel_vj1,
      t219.zielwert_vj AS ziel_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       vis0.ums_netto_vj / IF(vis0.anz_kunde_vj = 0, NULL, vis0.anz_kunde_vj) AS wert_vj,
       vis0.ums_ziel_vj / IF(t219.zielwert_vj = 0, NULL, t219.zielwert_vj) AS ziel_vj,
      CAST(NULL AS NUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        vis0.ums_netto_vj / IF(vis0.anz_kunde_vj = 0, NULL, vis0.anz_kunde_vj) - vis0.ums_ziel_vj / IF(t219.zielwert_vj
          = 0, NULL, t219.zielwert_vj) AS delta_z,
        (vis0.ums_netto_vj / IF(vis0.anz_kunde_vj = 0, NULL, vis0.anz_kunde_vj) - vis0.ums_ziel_vj / IF(t219.zielwert_vj
             = 0, NULL, t219.zielwert_vj)) / IF(vis0.ums_ziel_vj / IF(t219.zielwert_vj = 0, NULL, t219.zielwert_vj) = 0
        , NULL, vis0.ums_ziel_vj / IF(t219.zielwert_vj = 0, NULL, t219.zielwert_vj)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t219 ON vis0.mandant_id = t219.mandant_id AND vis0.wup_id = t219.wup_id AND vis0.wrg_id = t219.wrg_id
            AND t219.metrik_id = 16 AND t219.typ_id = 0 AND t219.level_id = 0
     UNION ALL
     SELECT 20 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.ums_plan_gj AS plan_gj1,
      vis0.std_plan_gj AS plan_gj2,
      vis0.ums_plan_vj AS plan_vj1,
      vis0.std_plan_vj AS plan_vj2,
      vis0.ums_netto_vj AS wert_vj1,
      vis0.std_netto_vj AS wert_vj2,
      vis0.ums_ziel_vj AS ziel_vj1,
      t240.zielwert_vj AS ziel_vj2,
       vis0.ums_plan_gj / IF(vis0.std_plan_gj = 0, NULL, vis0.std_plan_gj) AS plan_gj,
       vis0.ums_plan_vj / IF(vis0.std_plan_vj = 0, NULL, vis0.std_plan_vj) AS plan_vj,
       vis0.ums_netto_vj / IF(vis0.std_netto_vj = 0, NULL, vis0.std_netto_vj) AS wert_vj,
       vis0.ums_ziel_vj / IF(t240.zielwert_vj = 0, NULL, t240.zielwert_vj) AS ziel_vj,
      CAST(NULL AS NUMERIC),
      CAST(NULL AS STRING),
        (vis0.ums_netto_vj / IF(vis0.std_netto_vj = 0, NULL, vis0.std_netto_vj) - vis0.ums_plan_vj / IF(vis0.std_plan_vj
             = 0, NULL, vis0.std_plan_vj)) * 100 AS delta,
         (vis0.ums_netto_vj / IF(vis0.std_netto_vj = 0, NULL, vis0.std_netto_vj) - vis0.ums_plan_vj / IF(vis0.std_plan_vj
              = 0, NULL, vis0.std_plan_vj)) * 100 / IF(vis0.ums_plan_vj / IF(vis0.std_plan_vj = 0, NULL, vis0.std_plan_vj
           ) = 0, NULL, vis0.ums_plan_vj / IF(vis0.std_plan_vj = 0, NULL, vis0.std_plan_vj)) AS abw,
        (vis0.ums_netto_vj / IF(vis0.std_netto_vj = 0, NULL, vis0.std_netto_vj) - vis0.ums_ziel_vj / IF(t240.zielwert_vj
             = 0, NULL, t240.zielwert_vj)) * 100 AS delta_z,
         (vis0.ums_netto_vj / IF(vis0.std_netto_vj = 0, NULL, vis0.std_netto_vj) - vis0.ums_ziel_vj / IF(t240.zielwert_vj
              = 0, NULL, t240.zielwert_vj)) * 100 / IF(vis0.ums_ziel_vj / IF(t240.zielwert_vj = 0, NULL, t240.zielwert_vj
           ) = 0, NULL, vis0.ums_ziel_vj / IF(t240.zielwert_vj = 0, NULL, t240.zielwert_vj)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t240 ON vis0.mandant_id = t240.mandant_id AND vis0.wup_id = t240.wup_id AND vis0.wrg_id = t240.wrg_id
            AND t240.metrik_id = 24 AND t240.typ_id = 0 AND t240.level_id = 0
     UNION ALL
     SELECT 24 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      vis0.std_plan_gj AS plan_gj1,
      CAST(NULL AS BIGNUMERIC) AS plan_gj2,
      vis0.std_plan_vj AS plan_vj1,
      CAST(NULL AS BIGNUMERIC) AS plan_vj2,
      vis0.std_netto_vj AS wert_vj1,
      CAST(NULL AS BIGNUMERIC) AS wert_vj2,
      t261.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_vj2,
      vis0.std_plan_gj AS plan_gj,
      vis0.std_plan_vj AS plan_vj,
      vis0.std_netto_vj AS wert_vj,
      t261.zielwert_vj AS ziel_vj,
      CAST(NULL AS NUMERIC) AS check_vj,
      t261.kommentar_vj AS komm_vj,
       vis0.std_netto_vj - vis0.std_plan_vj AS delta,
        (vis0.std_netto_vj - vis0.std_plan_vj) / IF(vis0.std_plan_vj = 0, NULL, vis0.std_plan_vj) AS abw,
       vis0.std_netto_vj - t261.zielwert_vj AS delta_z,
        (vis0.std_netto_vj - t261.zielwert_vj) / IF(t261.zielwert_vj = 0, NULL, t261.zielwert_vj) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t261 ON vis0.mandant_id = t261.mandant_id AND vis0.wup_id = t261.wup_id AND vis0.wrg_id = t261.wrg_id
            AND t261.metrik_id = 24 AND t261.typ_id = 0 AND t261.level_id = 0
     UNION ALL
     SELECT 30 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.pos_ums_vj AS wert_vj1,
      sub1.pos_kstd_vj AS wert_vj2,
      t302.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.pos_ums_vj / IF(sub1.pos_kstd_vj = 0, NULL, sub1.pos_kstd_vj) AS wert_vj,
      t302.zielwert_vj AS ziel_vj,
      CAST(NULL AS NUMERIC) AS check_vj,
      t302.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        sub1.pos_ums_vj / IF(sub1.pos_kstd_vj = 0, NULL, sub1.pos_kstd_vj) - t302.zielwert_vj AS delta_z,
        (sub1.pos_ums_vj / IF(sub1.pos_kstd_vj = 0, NULL, sub1.pos_kstd_vj) - t302.zielwert_vj) / IF(sub1.pos_ums_vj /
          IF(sub1.pos_kstd_vj = 0, NULL, sub1.pos_kstd_vj) = 0, NULL, sub1.pos_ums_vj / IF(sub1.pos_kstd_vj = 0, NULL,
          sub1.pos_kstd_vj)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_KASSE AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t302 ON vis0.mandant_id = t302.mandant_id AND vis0.wup_id = t302.wup_id AND vis0.wrg_id = t302.wrg_id
            AND t302.metrik_id = 30 AND t302.typ_id = 0 AND t302.level_id = 0
     UNION ALL
     SELECT 32 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.scan_anz_vj AS wert_vj1,
      sub1.scan_min_vj AS wert_vj2,
      t333.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.scan_anz_vj / IF(sub1.scan_min_vj = 0, NULL, sub1.scan_min_vj) AS wert_vj,
      t333.zielwert_vj AS ziel_vj,
      CAST(NULL AS NUMERIC) AS check_vj,
      t333.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        sub1.scan_anz_vj / IF(sub1.scan_min_vj = 0, NULL, sub1.scan_min_vj) - t333.zielwert_vj AS delta_z,
        (sub1.scan_anz_vj / IF(sub1.scan_min_vj = 0, NULL, sub1.scan_min_vj) - t333.zielwert_vj) / IF(sub1.scan_anz_vj /
          IF(sub1.scan_min_vj = 0, NULL, sub1.scan_min_vj) = 0, NULL, sub1.scan_anz_vj / IF(sub1.scan_min_vj = 0, NULL,
          sub1.scan_min_vj)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_ODS_KA AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id
      LEFT JOIN ZIEL AS t333 ON vis0.mandant_id = t333.mandant_id AND vis0.wup_id = t333.wup_id AND vis0.wrg_id = t333.wrg_id
            AND t333.metrik_id = 32 AND t333.typ_id = 0 AND t333.level_id = 0
     UNION ALL
     SELECT 33 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.pos_art_vj AS wert_vj1,
      sub1.pos_scan_m_vj AS wert_vj2,
      t374.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.pos_art_vj / IF(sub1.pos_scan_m_vj = 0, NULL, sub1.pos_scan_m_vj) AS wert_vj,
      t374.zielwert_vj AS ziel_vj,
      CAST(NULL AS NUMERIC) AS check_vj,
      t374.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        sub1.pos_art_vj / IF(sub1.pos_scan_m_vj = 0, NULL, sub1.pos_scan_m_vj) - t374.zielwert_vj AS delta_z,
        (sub1.pos_art_vj / IF(sub1.pos_scan_m_vj = 0, NULL, sub1.pos_scan_m_vj) - t374.zielwert_vj) / IF(sub1.pos_art_vj
           / IF(sub1.pos_scan_m_vj = 0, NULL, sub1.pos_scan_m_vj) = 0, NULL, sub1.pos_art_vj / IF(sub1.pos_scan_m_vj = 0
           , NULL, sub1.pos_scan_m_vj)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_KASSE AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t374 ON vis0.mandant_id = t374.mandant_id AND vis0.wup_id = t374.wup_id AND vis0.wrg_id = t374.wrg_id
            AND t374.metrik_id = 32 AND t374.typ_id = 0 AND t374.level_id = 0
     UNION ALL
     SELECT 34 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.sco_ums_vj AS wert_vj1,
      sub1.kass_ums_vj AS wert_vj2,
      t415.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.sco_ums_vj / IF(sub1.kass_ums_vj = 0, NULL, sub1.kass_ums_vj) AS wert_vj,
      t415.zielwert_vj AS ziel_vj,
      CAST(NULL AS NUMERIC) AS check_vj,
      t415.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        (sub1.sco_ums_vj / IF(sub1.kass_ums_vj = 0, NULL, sub1.kass_ums_vj) - t415.zielwert_vj) * 100 AS delta_z,
         (sub1.sco_ums_vj / IF(sub1.kass_ums_vj = 0, NULL, sub1.kass_ums_vj) - t415.zielwert_vj) * 100 / IF(sub1.sco_ums_vj
           / IF(sub1.kass_ums_vj = 0, NULL, sub1.kass_ums_vj) = 0, NULL, sub1.sco_ums_vj / IF(sub1.kass_ums_vj = 0, NULL
          , sub1.kass_ums_vj)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_KASSE AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t415 ON vis0.mandant_id = t415.mandant_id AND vis0.wup_id = t415.wup_id AND vis0.wrg_id = t415.wrg_id
            AND t415.metrik_id = 34 AND t415.typ_id = 0 AND t415.level_id = 0
     UNION ALL
     SELECT 36 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.sco_bon_vj AS wert_vj1,
      sub1.kass_bon_vj AS wert_vj2,
      t456.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.sco_bon_vj / IF(sub1.kass_bon_vj = 0, NULL, sub1.kass_bon_vj) AS wert_vj,
      t456.zielwert_vj AS ziel_vj,
      CAST(NULL AS NUMERIC) AS check_vj,
      t456.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        (sub1.sco_bon_vj / IF(sub1.kass_bon_vj = 0, NULL, sub1.kass_bon_vj) - t456.zielwert_vj) * 100 AS delta_z,
         (sub1.sco_bon_vj / IF(sub1.kass_bon_vj = 0, NULL, sub1.kass_bon_vj) - t456.zielwert_vj) * 100 / IF(sub1.sco_bon_vj
           / IF(sub1.kass_bon_vj = 0, NULL, sub1.kass_bon_vj) = 0, NULL, sub1.sco_bon_vj / IF(sub1.kass_bon_vj = 0, NULL
          , sub1.kass_bon_vj)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_KASSE AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t456 ON vis0.mandant_id = t456.mandant_id AND vis0.wup_id = t456.wup_id AND vis0.wrg_id = t456.wrg_id
            AND t456.metrik_id = 36 AND t456.typ_id = 0 AND t456.level_id = 0
     UNION ALL
     SELECT 37 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.kscan_bon_vj AS wert_vj1,
      sub1.kass_bon_vj AS wert_vj2,
      t497.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.kscan_bon_vj / IF(sub1.kass_bon_vj = 0, NULL, sub1.kass_bon_vj) AS wert_vj,
      t497.zielwert_vj AS ziel_vj,
      CAST(NULL AS NUMERIC) AS check_vj,
      t497.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        (sub1.kscan_bon_vj / IF(sub1.kass_bon_vj = 0, NULL, sub1.kass_bon_vj) - t497.zielwert_vj) * 100 AS delta_z,
         (sub1.kscan_bon_vj / IF(sub1.kass_bon_vj = 0, NULL, sub1.kass_bon_vj) - t497.zielwert_vj) * 100 / IF(sub1.kscan_bon_vj
           / IF(sub1.kass_bon_vj = 0, NULL, sub1.kass_bon_vj) = 0, NULL, sub1.kscan_bon_vj / IF(sub1.kass_bon_vj = 0,
          NULL, sub1.kass_bon_vj)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_KASSE AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t497 ON vis0.mandant_id = t497.mandant_id AND vis0.wup_id = t497.wup_id AND vis0.wrg_id = t497.wrg_id
            AND t497.metrik_id = 37 AND t497.typ_id = 0 AND t497.level_id = 0
     UNION ALL
     SELECT 39 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.kcard_vj AS wert_vj1,
      sub1.bon_vj AS wert_vj2,
      t528.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.kcard_vj / IF(sub1.bon_vj = 0, NULL, sub1.bon_vj) AS wert_vj,
      t528.zielwert_vj AS ziel_vj,
      CAST(NULL AS NUMERIC) AS check_vj,
      t528.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        (sub1.kcard_vj / IF(sub1.bon_vj = 0, NULL, sub1.bon_vj) - t528.zielwert_vj) * 100 AS delta_z,
         (sub1.kcard_vj / IF(sub1.bon_vj = 0, NULL, sub1.bon_vj) - t528.zielwert_vj) * 100 / IF(sub1.kcard_vj / IF(sub1
            .bon_vj = 0, NULL, sub1.bon_vj) = 0, NULL, sub1.kcard_vj / IF(sub1.bon_vj = 0, NULL, sub1.bon_vj)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_WCAL AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id
      LEFT JOIN ZIEL AS t528 ON vis0.mandant_id = t528.mandant_id AND vis0.wup_id = t528.wup_id AND vis0.wrg_id = t528.wrg_id
            AND t528.metrik_id = 39 AND t528.typ_id = 0 AND t528.level_id = 0
     UNION ALL
     SELECT 40 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      sub1.abs_plan_gj AS plan_gj1,
      sub1.ums_plan_gj AS plan_gj2,
      sub1.abs_plan_vj AS plan_vj1,
      sub1.ums_plan_vj AS plan_vj2,
      sub2.abs_netto_vj AS wert_vj1,
      sub3.ums_ware_vj AS wert_vj2,
       sub1.abs_kalk_vj * vis0.faktor_vj AS ziel_vj1,
       sub1.ums_plan_vj * vis0.faktor_vj AS ziel_vj2,
       sub1.abs_plan_gj / IF(sub1.ums_plan_gj = 0, NULL, sub1.ums_plan_gj) AS plan_gj,
       sub1.abs_plan_vj / IF(sub1.ums_plan_vj = 0, NULL, sub1.ums_plan_vj) AS plan_vj,
       sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) AS wert_vj,
        sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj
         ) AS ziel_vj,
      CAST(NULL AS NUMERIC) AS check_vj,
      CAST(NULL AS STRING) AS komm_vj,
        (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_plan_vj / IF(sub1.ums_plan_vj =
            0, NULL, sub1.ums_plan_vj)) * 100 AS delta,
         (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_plan_vj / IF(sub1.ums_plan_vj
             = 0, NULL, sub1.ums_plan_vj)) * 100 / IF(sub1.abs_plan_vj / IF(sub1.ums_plan_vj = 0, NULL, sub1.ums_plan_vj
           ) = 0, NULL, sub1.abs_plan_vj / IF(sub1.ums_plan_vj = 0, NULL, sub1.ums_plan_vj)) AS abw,
        (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
             .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 AS delta_z,
         (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
              .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 / IF(sub1.abs_kalk_vj *
           vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj) = 0, NULL
        , sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj
           )) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_FIL_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
        = sub1.wrg_id
      LEFT JOIN VIS_FIL_ABS AS sub2 ON vis0.mandant_id = sub2.mandant_id AND vis0.wup_id = sub2.wup_id AND vis0.wrg_id =
        sub2.wrg_id
      LEFT JOIN VIS_FIL AS sub3 ON vis0.mandant_id = sub3.mandant_id AND vis0.wup_id = sub3.wup_id AND vis0.wrg_id =
        sub3.wrg_id
     UNION ALL
     SELECT 40 AS metrik_id,
      1 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      sub1.abs_plan_gj AS plan_gj1,
      sub1.ums_plan_gj AS plan_gj2,
      sub1.abs_plan_vj AS plan_vj1,
      sub1.ums_plan_vj AS plan_vj2,
      sub2.abs_netto_vj AS wert_vj1,
      sub3.ums_ware_vj AS wert_vj2,
       sub1.abs_kalk_vj * vis0.faktor_vj AS ziel_vj1,
       sub1.ums_plan_vj * vis0.faktor_vj AS ziel_vj2,
       sub1.abs_plan_gj / IF(sub1.ums_plan_gj = 0, NULL, sub1.ums_plan_gj) AS plan_gj,
       sub1.abs_plan_vj / IF(sub1.ums_plan_vj = 0, NULL, sub1.ums_plan_vj) AS plan_vj,
       sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) AS wert_vj,
        sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj
         ) AS ziel_vj,
      sub1.abs_eing_vj AS check_vj,
      sub2.kommentar_vj AS komm_vj,
        (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
             .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 AS delta,
         (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
              .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 / IF(sub1.abs_plan_vj /
          IF(sub1.ums_plan_vj = 0, NULL, sub1.ums_plan_vj) = 0, NULL, sub1.abs_plan_vj / IF(sub1.ums_plan_vj = 0, NULL,
          sub1.ums_plan_vj)) AS abw,
        (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
             .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 AS delta_z,
         (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
              .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 / IF(sub1.abs_kalk_vj *
           vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj) = 0, NULL
        , sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj
           )) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_ABT_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
        = sub1.wrg_id
      LEFT JOIN VIS_ABT_ABS AS sub2 ON vis0.mandant_id = sub2.mandant_id AND vis0.wup_id = sub2.wup_id AND vis0.wrg_id =
         sub2.wrg_id AND sub1.abt_id = sub2.abt_id
      LEFT JOIN VIS_ABT AS sub3 ON vis0.mandant_id = sub3.mandant_id AND vis0.wup_id = sub3.wup_id AND vis0.wrg_id =
         sub3.wrg_id AND sub1.abt_id = sub3.abt_id
     UNION ALL
     SELECT 40 AS metrik_id,
      2 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      sub1.abs_plan_gj AS plan_gj1,
      sub1.ums_plan_gj AS plan_gj2,
      sub1.abs_plan_vj AS plan_vj1,
      sub1.ums_plan_vj AS plan_vj2,
      sub2.abs_netto_vj AS wert_vj1,
      sub3.ums_ware_vj AS wert_vj2,
       sub1.abs_kalk_vj * vis0.faktor_vj AS ziel_vj1,
       sub1.ums_plan_vj * vis0.faktor_vj AS ziel_vj2,
       sub1.abs_plan_gj / IF(sub1.ums_plan_gj = 0, NULL, sub1.ums_plan_gj) AS plan_gj,
       sub1.abs_plan_vj / IF(sub1.ums_plan_vj = 0, NULL, sub1.ums_plan_vj) AS plan_vj,
       sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) AS wert_vj,
        sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj
         ) AS ziel_vj,
      sub1.abs_eing_vj AS check_vj,
      sub2.kommentar_vj AS komm_vj,
        (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
             .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 AS delta,
         (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
              .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 / IF(sub1.abs_plan_vj /
          IF(sub1.ums_plan_vj = 0, NULL, sub1.ums_plan_vj) = 0, NULL, sub1.abs_plan_vj / IF(sub1.ums_plan_vj = 0, NULL,
          sub1.ums_plan_vj)) AS abw,
        (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
             .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 AS delta_z,
         (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
              .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 / IF(sub1.abs_kalk_vj *
           vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj) = 0, NULL
        , sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj
           )) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_HWG_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
        = sub1.wrg_id
      LEFT JOIN VIS_HWG_ABS AS sub2 ON vis0.mandant_id = sub2.mandant_id AND vis0.wup_id = sub2.wup_id AND vis0.wrg_id =
         sub2.wrg_id AND sub1.hwg_id = sub2.hwg_id
      LEFT JOIN VIS_HWG AS sub3 ON vis0.mandant_id = sub3.mandant_id AND vis0.wup_id = sub3.wup_id AND vis0.wrg_id =
         sub3.wrg_id AND sub1.hwg_id = sub3.hwg_id
     UNION ALL
     SELECT 40 AS metrik_id,
      3 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      sub1.abs_plan_gj AS plan_gj1,
      sub1.ums_plan_gj AS plan_gj2,
      sub1.abs_plan_vj AS plan_vj1,
      sub1.ums_plan_vj AS plan_vj2,
      sub2.abs_netto_vj AS wert_vj1,
      sub3.ums_ware_vj AS wert_vj2,
       sub1.abs_kalk_vj * vis0.faktor_vj AS ziel_vj1,
       sub1.ums_plan_vj * vis0.faktor_vj AS ziel_vj2,
       sub1.abs_plan_gj / IF(sub1.ums_plan_gj = 0, NULL, sub1.ums_plan_gj) AS plan_gj,
       sub1.abs_plan_vj / IF(sub1.ums_plan_vj = 0, NULL, sub1.ums_plan_vj) AS plan_vj,
       sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) AS wert_vj,
        sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj
         ) AS ziel_vj,
      sub1.abs_eing_vj AS check_vj,
      sub2.kommentar_vj AS komm_vj,
        (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
             .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 AS delta,
         (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
              .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 / IF(sub1.abs_plan_vj /
          IF(sub1.ums_plan_vj = 0, NULL, sub1.ums_plan_vj) = 0, NULL, sub1.abs_plan_vj / IF(sub1.ums_plan_vj = 0, NULL,
          sub1.ums_plan_vj)) AS abw,
        (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
             .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 AS delta_z,
         (sub2.abs_netto_vj / IF(sub3.ums_ware_vj = 0, NULL, sub3.ums_ware_vj) - sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1
              .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 / IF(sub1.abs_kalk_vj *
           vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj) = 0, NULL
        , sub1.abs_kalk_vj * vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj
           )) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_OWG_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
        = sub1.wrg_id
      LEFT JOIN VIS_OWG_ABS AS sub2 ON vis0.mandant_id = sub2.mandant_id AND vis0.wup_id = sub2.wup_id AND vis0.wrg_id =
         sub2.wrg_id AND sub1.owg_id = sub2.owg_id
      LEFT JOIN VIS_OWG AS sub3 ON vis0.mandant_id = sub3.mandant_id AND vis0.wup_id = sub3.wup_id AND vis0.wrg_id =
         sub3.wrg_id AND sub1.owg_id = sub3.owg_id
     UNION ALL
     SELECT 46 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub2.inv_wert_vj AS wert_vj1,
      sub2.inv_ums_vj AS wert_vj2,
       sub1.inv_kalk_vj * vis0.faktor_vj AS ziel_vj1,
       sub1.ums_plan_vj * vis0.faktor_vj AS ziel_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub2.inv_wert_vj / IF(sub2.inv_ums_vj = 0, NULL, sub2.inv_ums_vj) AS wert_vj,
        sub1.inv_kalk_vj * vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj
         ) AS ziel_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        (sub2.inv_wert_vj / IF(sub2.inv_ums_vj = 0, NULL, sub2.inv_ums_vj) - sub1.inv_kalk_vj * vis0.faktor_vj / IF(sub1
             .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 AS delta_z,
         (sub2.inv_wert_vj / IF(sub2.inv_ums_vj = 0, NULL, sub2.inv_ums_vj) - sub1.inv_kalk_vj * vis0.faktor_vj / IF(sub1
              .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 / IF(sub1.inv_kalk_vj *
           vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj) = 0, NULL
        , sub1.inv_kalk_vj * vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj
           )) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_FIL_INV_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
         = sub1.wrg_id
      LEFT JOIN VIS_FIL_INV AS sub2 ON vis0.mandant_id = sub2.mandant_id AND vis0.wup_id = sub2.wup_id AND vis0.wrg_id =
        sub2.wrg_id
     UNION ALL
     SELECT 46 AS metrik_id,
      1 AS typ_id,
      sub1.level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub2.inv_wert_vj AS wert_vj1,
      sub2.inv_ums_vj AS wert_vj2,
       sub1.inv_kalk_vj * vis0.faktor_vj AS ziel_vj1,
       sub1.ums_plan_vj * vis0.faktor_vj AS ziel_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub2.inv_wert_vj / IF(sub2.inv_ums_vj = 0, NULL, sub2.inv_ums_vj) AS wert_vj,
        sub1.inv_kalk_vj * vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj
         ) AS ziel_vj,
      sub1.inv_eing_vj AS check_vj,
      sub1.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        (sub2.inv_wert_vj / IF(sub2.inv_ums_vj = 0, NULL, sub2.inv_ums_vj) - sub1.inv_kalk_vj * vis0.faktor_vj / IF(sub1
             .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 AS delta_z,
         (sub2.inv_wert_vj / IF(sub2.inv_ums_vj = 0, NULL, sub2.inv_ums_vj) - sub1.inv_kalk_vj * vis0.faktor_vj / IF(sub1
              .ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj)) * 100 / IF(sub1.inv_kalk_vj *
           vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj) = 0, NULL
        , sub1.inv_kalk_vj * vis0.faktor_vj / IF(sub1.ums_plan_vj * vis0.faktor_vj = 0, NULL, sub1.ums_plan_vj * vis0.faktor_vj
           )) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_ABT_INV_PLAN AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id
         = sub1.wrg_id
      LEFT JOIN VIS_ABT_INV AS sub2 ON vis0.mandant_id = sub2.mandant_id AND vis0.wup_id = sub2.wup_id AND vis0.wrg_id =
         sub2.wrg_id AND sub1.abt_id = sub2.abt_id
     UNION ALL
     SELECT 50 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.kmr_nok_vj AS wert_vj1,
      sub1.kmr_anz_vj AS wert_vj2,
      t998.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.kmr_nok_vj / IF(sub1.kmr_anz_vj = 0, NULL, sub1.kmr_anz_vj) AS wert_vj,
      t998.zielwert_vj AS ziel_vj,
      CAST(NULL AS BIGNUMERIC) AS check_vj,
      t998.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        (sub1.kmr_nok_vj / IF(sub1.kmr_anz_vj = 0, NULL, sub1.kmr_anz_vj) - t998.zielwert_vj) * 100 AS delta_z,
         (sub1.kmr_nok_vj / IF(sub1.kmr_anz_vj = 0, NULL, sub1.kmr_anz_vj) - t998.zielwert_vj) * 100 / IF(sub1.kmr_nok_vj
           / IF(sub1.kmr_anz_vj = 0, NULL, sub1.kmr_anz_vj) = 0, NULL, sub1.kmr_nok_vj / IF(sub1.kmr_anz_vj = 0, NULL,
          sub1.kmr_anz_vj)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_KURZCHECK AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id
      LEFT JOIN ZIEL AS t998 ON vis0.mandant_id = t998.mandant_id AND vis0.wup_id = t998.wup_id AND vis0.wrg_id = t998.wrg_id
            AND t998.metrik_id = 50 AND t998.typ_id = 0 AND t998.level_id = 0
     UNION ALL
     SELECT 54 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.warten_kasse_vj AS wert_vj1,
      CAST(NULL AS BIGNUMERIC) AS wert_vj2,
      t1031.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.warten_kasse_vj AS wert_vj,
      t1031.zielwert_vj AS ziel_vj,
      CAST(NULL AS BIGNUMERIC) AS check_vj,
      t1031.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
       sub1.warten_kasse_vj - t1031.zielwert_vj AS delta_z,
        (sub1.warten_kasse_vj - t1031.zielwert_vj) / IF(sub1.warten_kasse_vj = 0, NULL, sub1.warten_kasse_vj) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_REKL AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t1031 ON vis0.mandant_id = t1031.mandant_id AND vis0.wup_id = t1031.wup_id AND vis0.wrg_id =
           t1031.wrg_id AND t1031.metrik_id = 54 AND t1031.typ_id = 0 AND t1031.level_id = 0
     UNION ALL
     SELECT 55 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.warten_kasse_vj AS wert_vj1,
       vis0.anz_kunde_vj / 10000 AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.warten_kasse_vj / IF(vis0.anz_kunde_vj / 10000 = 0, NULL, vis0.anz_kunde_vj / 10000) AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_REKL AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 56 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.warten_theke_vj AS wert_vj1,
      CAST(NULL AS BIGNUMERIC) AS wert_vj2,
      t1092.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.warten_theke_vj AS wert_vj,
      t1092.zielwert_vj AS ziel_vj,
      CAST(NULL AS BIGNUMERIC) AS check_vj,
      t1092.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
       sub1.warten_theke_vj - t1092.zielwert_vj AS delta_z,
        (sub1.warten_theke_vj - t1092.zielwert_vj) / IF(sub1.warten_theke_vj = 0, NULL, sub1.warten_theke_vj) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_REKL AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t1092 ON vis0.mandant_id = t1092.mandant_id AND vis0.wup_id = t1092.wup_id AND vis0.wrg_id =
           t1092.wrg_id AND t1092.metrik_id = 56 AND t1092.typ_id = 0 AND t1092.level_id = 0
     UNION ALL
     SELECT 57 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.warten_theke_vj AS wert_vj1,
       vis0.anz_kunde_vj / 10000 AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.warten_theke_vj / IF(vis0.anz_kunde_vj / 10000 = 0, NULL, vis0.anz_kunde_vj / 10000) AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_REKL AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 58 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.mangel_mhd_vj AS wert_vj1,
      CAST(NULL AS BIGNUMERIC) AS wert_vj2,
      t1153.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.mangel_mhd_vj AS wert_vj,
      t1153.zielwert_vj AS ziel_vj,
      CAST(NULL AS BIGNUMERIC) AS check_vj,
      t1153.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
       sub1.mangel_mhd_vj - t1153.zielwert_vj AS delta_z,
        (sub1.mangel_mhd_vj - t1153.zielwert_vj) / IF(sub1.mangel_mhd_vj = 0, NULL, sub1.mangel_mhd_vj) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_REKL AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t1153 ON vis0.mandant_id = t1153.mandant_id AND vis0.wup_id = t1153.wup_id AND vis0.wrg_id =
           t1153.wrg_id AND t1153.metrik_id = 58 AND t1153.typ_id = 0 AND t1153.level_id = 0
     UNION ALL
     SELECT 59 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.mangel_mhd_vj AS wert_vj1,
       vis0.anz_kunde_vj / 10000 AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.mangel_mhd_vj / IF(vis0.anz_kunde_vj / 10000 = 0, NULL, vis0.anz_kunde_vj / 10000) AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_REKL AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 60 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.fehler_preis_vj AS wert_vj1,
      CAST(NULL AS BIGNUMERIC) AS wert_vj2,
      t1214.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.fehler_preis_vj AS wert_vj,
      t1214.zielwert_vj AS ziel_vj,
      CAST(NULL AS BIGNUMERIC) AS check_vj,
      t1214.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
       sub1.fehler_preis_vj - t1214.zielwert_vj AS delta_z,
        (sub1.fehler_preis_vj - t1214.zielwert_vj) / IF(sub1.fehler_preis_vj = 0, NULL, sub1.fehler_preis_vj) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_REKL AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t1214 ON vis0.mandant_id = t1214.mandant_id AND vis0.wup_id = t1214.wup_id AND vis0.wrg_id =
           t1214.wrg_id AND t1214.metrik_id = 60 AND t1214.typ_id = 0 AND t1214.level_id = 0
     UNION ALL
     SELECT 61 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.fehler_preis_vj AS wert_vj1,
       vis0.anz_kunde_vj / 10000 AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.fehler_preis_vj / IF(vis0.anz_kunde_vj / 10000 = 0, NULL, vis0.anz_kunde_vj / 10000) AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_REKL AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 62 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.fehler_kasse_vj AS wert_vj1,
      CAST(NULL AS BIGNUMERIC) AS wert_vj2,
      t1275.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC) AS ziel_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.fehler_kasse_vj AS wert_vj,
      t1275.zielwert_vj AS ziel_vj,
      CAST(NULL AS BIGNUMERIC) AS check_vj,
      t1275.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
       sub1.fehler_kasse_vj - t1275.zielwert_vj AS delta_z,
        (sub1.fehler_kasse_vj - t1275.zielwert_vj) / IF(sub1.fehler_kasse_vj = 0, NULL, sub1.fehler_kasse_vj) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_REKL AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t1275 ON vis0.mandant_id = t1275.mandant_id AND vis0.wup_id = t1275.wup_id AND vis0.wrg_id =
           t1275.wrg_id AND t1275.metrik_id = 62 AND t1275.typ_id = 0 AND t1275.level_id = 0
     UNION ALL
     SELECT 63 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.fehler_kasse_vj AS wert_vj1,
      sub2.pos_art100t_vj AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.fehler_kasse_vj / IF(sub2.pos_art100t_vj = 0, NULL, sub2.pos_art100t_vj) AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_REKL AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN VIS_KASSE AS sub2 ON vis0.mandant_id = sub2.mandant_id AND vis0.wup_id = sub2.wup_id AND vis0.wrg_id =
        sub2.wrg_id
     UNION ALL
     SELECT 70 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      vis0.pk_wert_vj AS wert_vj1,
      vis0.ums_netto_vj AS wert_vj2,
       vis0.ums_ziel_vj * t1344.zielwert_vj AS ziel_vj1,
      vis0.ums_ziel_vj AS ziel_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       vis0.pk_wert_vj / IF(vis0.ums_netto_vj = 0, NULL, vis0.ums_netto_vj) AS wert_vj,
        vis0.ums_ziel_vj * t1344.zielwert_vj / IF(vis0.ums_ziel_vj = 0, NULL, vis0.ums_ziel_vj) AS ziel_vj,
      t1344.zielwert_vj AS check_vj,
      t1344.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        (vis0.pk_wert_vj / IF(vis0.ums_netto_vj = 0, NULL, vis0.ums_netto_vj) - vis0.ums_ziel_vj * t1344.zielwert_vj /
          IF(vis0.ums_ziel_vj = 0, NULL, vis0.ums_ziel_vj)) * 100 AS delta_z,
         (vis0.pk_wert_vj / IF(vis0.ums_netto_vj = 0, NULL, vis0.ums_netto_vj) - vis0.ums_ziel_vj * t1344.zielwert_vj /
           IF(vis0.ums_ziel_vj = 0, NULL, vis0.ums_ziel_vj)) * 100 / IF(vis0.ums_ziel_vj * t1344.zielwert_vj / IF(vis0.ums_ziel_vj
             = 0, NULL, vis0.ums_ziel_vj) = 0, NULL, vis0.ums_ziel_vj * t1344.zielwert_vj / IF(vis0.ums_ziel_vj = 0,
          NULL, vis0.ums_ziel_vj)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t1344 ON vis0.mandant_id = t1344.mandant_id AND vis0.wup_id = t1344.wup_id AND vis0.wrg_id =
           t1344.wrg_id AND t1344.metrik_id = 70 AND t1344.typ_id = 0 AND t1344.level_id = 0
     UNION ALL
     SELECT 72 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.std_spaet AS wert_vj1,
      vis0.std_netto_vj AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.std_spaet / IF(vis0.std_netto_vj = 0, NULL, vis0.std_netto_vj) AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_SHR AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 73 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.std_we AS wert_vj1,
      vis0.std_netto_vj AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.std_we / IF(vis0.std_netto_vj = 0, NULL, vis0.std_netto_vj) AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_SHR AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 74 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.std_ftag AS wert_vj1,
      vis0.std_netto_vj AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.std_ftag / IF(vis0.std_netto_vj = 0, NULL, vis0.std_netto_vj) AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_SHR AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 75 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.std_mehr AS wert_vj1,
      vis0.std_netto_vj AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.std_mehr / IF(vis0.std_netto_vj = 0, NULL, vis0.std_netto_vj) AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_SHR AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 76 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
        sub1.ans_vj + sub1.rst_vj - (sub1.abg_vj + sub1.gen_vj) AS wert_vj1,
      sub1.ans_vj AS wert_vj2,
      t1478.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
        (sub1.ans_vj + sub1.rst_vj - (sub1.abg_vj + sub1.gen_vj)) / IF(sub1.ans_vj = 0, NULL, sub1.ans_vj) AS wert_vj,
      t1478.zielwert_vj AS ziel_vj,
      CAST(NULL AS BIGNUMERIC) AS check_vj,
      t1478.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        ((sub1.ans_vj + sub1.rst_vj - (sub1.abg_vj + sub1.gen_vj)) / IF(sub1.ans_vj = 0, NULL, sub1.ans_vj) - t1478.zielwert_vj
         ) * 100 AS delta_z,
         ((sub1.ans_vj + sub1.rst_vj - (sub1.abg_vj + sub1.gen_vj)) / IF(sub1.ans_vj = 0, NULL, sub1.ans_vj) - t1478.zielwert_vj
          ) * 100 / IF((sub1.ans_vj + sub1.rst_vj - (sub1.abg_vj + sub1.gen_vj)) / IF(sub1.ans_vj = 0, NULL, sub1.ans_vj
           ) = 0, NULL, (sub1.ans_vj + sub1.rst_vj - (sub1.abg_vj + sub1.gen_vj)) / IF(sub1.ans_vj = 0, NULL, sub1.ans_vj
          )) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_RUQ AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t1478 ON vis0.mandant_id = t1478.mandant_id AND vis0.wup_id = t1478.wup_id AND vis0.wrg_id =
           t1478.wrg_id AND t1478.metrik_id = 76 AND t1478.typ_id = 0 AND t1478.level_id = 0
     UNION ALL
     SELECT 77 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.std_krank AS wert_vj1,
      sub1.std_soll AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.std_krank / IF(sub1.std_soll = 0, NULL, sub1.std_soll) AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_SHR AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 78 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.aus_roll AS wert_vj1,
      sub1.kopf_roll AS wert_vj2,
      t1535.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.aus_roll / IF(sub1.kopf_roll = 0, NULL, sub1.kopf_roll) AS wert_vj,
      t1535.zielwert_vj AS ziel_vj,
      CAST(NULL AS BIGNUMERIC) AS check_vj,
      t1535.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        (sub1.aus_roll / IF(sub1.kopf_roll = 0, NULL, sub1.kopf_roll) - t1535.zielwert_vj) * 100 AS delta_z,
         (sub1.aus_roll / IF(sub1.kopf_roll = 0, NULL, sub1.kopf_roll) - t1535.zielwert_vj) * 100 / IF(sub1.aus_roll /
          IF(sub1.kopf_roll = 0, NULL, sub1.kopf_roll) = 0, NULL, sub1.aus_roll / IF(sub1.kopf_roll = 0, NULL, sub1.kopf_roll
          )) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_SHR AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t1535 ON vis0.mandant_id = t1535.mandant_id AND vis0.wup_id = t1535.wup_id AND vis0.wrg_id =
           t1535.wrg_id AND t1535.metrik_id = 78 AND t1535.typ_id = 0 AND t1535.level_id = 0
     UNION ALL
     SELECT 80 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.kopf_fil AS wert_vj1,
      CAST(NULL AS FLOAT64) AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.kopf_fil AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS FLOAT64)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_SHR AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 81 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.kopf_ma AS wert_vj1,
      CAST(NULL AS FLOAT64) AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.kopf_ma AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS FLOAT64)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_SHR AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 82 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.vzk_ma AS wert_vj1,
      CAST(NULL AS FLOAT64) AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.vzk_ma AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS FLOAT64)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_SHR AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 84 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.std_vtg AS wert_vj1,
      CAST(NULL AS FLOAT64) AS wert_vj2,
      t1644.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.std_vtg / IF(NULL, NULL, NULL) AS wert_vj,
      t1644.zielwert_vj AS ziel_vj,
      CAST(NULL AS BIGNUMERIC) AS check_vj,
      t1644.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        sub1.std_vtg / IF(NULL, NULL, NULL) - t1644.zielwert_vj AS delta_z,
        (sub1.std_vtg / IF(NULL, NULL, NULL) - t1644.zielwert_vj) / IF(sub1.std_vtg / IF(NULL, NULL, NULL) = 0, NULL,
         sub1.std_vtg / IF(NULL, NULL, NULL)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_SHR AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t1644 ON vis0.mandant_id = t1644.mandant_id AND vis0.wup_id = t1644.wup_id AND vis0.wrg_id =
           t1644.wrg_id AND t1644.metrik_id = 84 AND t1644.typ_id = 0 AND t1644.level_id = 0
     UNION ALL
     SELECT 86 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.std_vtg AS wert_vj1,
      sub1.kopf_ma AS wert_vj2,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.std_vtg / IF(sub1.kopf_ma = 0, NULL, sub1.kopf_ma) AS wert_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS STRING),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS FLOAT64)
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_SHR AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
     UNION ALL
     SELECT 88 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      sub1.tzk_ma AS wert_vj1,
      sub1.kopf_ma AS wert_vj2,
      t1701.zielwert_vj AS ziel_vj1,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
       sub1.tzk_ma / IF(sub1.kopf_ma = 0, NULL, sub1.kopf_ma) AS wert_vj,
      t1701.zielwert_vj AS ziel_vj,
      CAST(NULL AS BIGNUMERIC) AS check_vj,
      t1701.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
        (sub1.tzk_ma / IF(sub1.kopf_ma = 0, NULL, sub1.kopf_ma) - t1701.zielwert_vj) * 100 AS delta_z,
         (sub1.tzk_ma / IF(sub1.kopf_ma = 0, NULL, sub1.kopf_ma) - t1701.zielwert_vj) * 100 / IF(sub1.tzk_ma / IF(sub1.kopf_ma
             = 0, NULL, sub1.kopf_ma) = 0, NULL, sub1.tzk_ma / IF(sub1.kopf_ma = 0, NULL, sub1.kopf_ma)) AS abw_z
     FROM VIS_MAIN AS vis0
      LEFT JOIN VIS_SHR AS sub1 ON vis0.mandant_id = sub1.mandant_id AND vis0.wup_id = sub1.wup_id AND vis0.wrg_id =
        sub1.wrg_id
      LEFT JOIN ZIEL AS t1701 ON vis0.mandant_id = t1701.mandant_id AND vis0.wup_id = t1701.wup_id AND vis0.wrg_id =
           t1701.wrg_id AND t1701.metrik_id = 88 AND t1701.typ_id = 0 AND t1701.level_id = 0
     UNION ALL
     SELECT 91 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      t1722.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS FLOAT64)
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t1722 ON vis0.mandant_id = t1722.mandant_id AND vis0.wup_id = t1722.wup_id AND vis0.wrg_id =
           t1722.wrg_id AND t1722.metrik_id = 91 AND t1722.typ_id = 0 AND t1722.level_id = 0
     UNION ALL
     SELECT 92 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      t1743.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS FLOAT64)
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t1743 ON vis0.mandant_id = t1743.mandant_id AND vis0.wup_id = t1743.wup_id AND vis0.wrg_id =
           t1743.wrg_id AND t1743.metrik_id = 92 AND t1743.typ_id = 0 AND t1743.level_id = 0
     UNION ALL
     SELECT 93 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      t1764.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS FLOAT64)
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t1764 ON vis0.mandant_id = t1764.mandant_id AND vis0.wup_id = t1764.wup_id AND vis0.wrg_id =
           t1764.wrg_id AND t1764.metrik_id = 93 AND t1764.typ_id = 0 AND t1764.level_id = 0
     UNION ALL
     SELECT 94 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      t1785.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS FLOAT64)
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t1785 ON vis0.mandant_id = t1785.mandant_id AND vis0.wup_id = t1785.wup_id AND vis0.wrg_id =
           t1785.wrg_id AND t1785.metrik_id = 94 AND t1785.typ_id = 0 AND t1785.level_id = 0
     UNION ALL
     SELECT 95 AS metrik_id,
      vis0.zero AS typ_id,
      vis0.zero AS level_id,
      vis0.mandant_id,
      vis0.nb_id,
      vis0.wup_id,
      vis0.wrg_id,
      vis0.gj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS BIGNUMERIC),
      t1806.kommentar_vj AS komm_vj,
      CAST(NULL AS BIGNUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS FLOAT64),
      CAST(NULL AS FLOAT64)
     FROM VIS_MAIN AS vis0
      LEFT JOIN ZIEL AS t1806 ON vis0.mandant_id = t1806.mandant_id AND vis0.wup_id = t1806.wup_id AND vis0.wrg_id =
           t1806.wrg_id AND t1806.metrik_id = 95 AND t1806.typ_id = 0 AND t1806.level_id = 0));