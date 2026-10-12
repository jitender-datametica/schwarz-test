/* JZG Inventur - Filiale */ /* JZG510 - Inventur ABTEILUNG */ /* JZG520 - Inventur HWG */
/* JZG Inventur - ABTEILUNG */ /* Ultra-Frische + Wurst SB alt/neu */ /* KEIN PLAN */ /* ZIEL = Eingabe */
/* Eingabe Inventur Proz */ /* 50 Inventur */ /* Eingabe Inventur Proz */ /* JZG 500 - Inventur FILIALE */
/* ZIEL = Eingabe */ /* JZG Inventur - HWG */ /* 50 Inventur */ /* KEIN PLAN */ /* KEIN PLAN */
/* Eingabe Inventur Proz */ /* Eingabe Inventur Proz */ /* 50 Inventur */ /* ZIEL = Eingabe */
/* FAKT DENORM - Jahreszielgespräch 
   JZG DATA INVENTUR: Inventur Historie inkl. Eingabe
   2023-02-01 ssch0611 : Initial. AP0144461 */
/* ZIEL = Eingabe */ /* JZG Inventur - HWG */ /* 50 Inventur */ /* KEIN PLAN */ /* JZG520 - Inventur OWG */
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jzg_data_inventur (mandant_id, nb_id, wup_id, gj, wrg_id,
metrik_id, typ_id, level_id, metrik_vgj1, metrik_vgj2, metrik_vgj, metrik_plan_vgj1, metrik_plan_vgj2, metrik_plan_vgj,
metrik_delta, metrik_abw, metrik_plan_gj1, metrik_plan_gj2, metrik_plan_gj, metrik_eingabe, metrik_anteil, metrik_ziel1
, metrik_ziel2, metrik_ziel3, metrik_ziel) AS SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.gj,
 vis.wrg_id,
 50 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 vis.inv_wert AS metrik_vgj1,
 vis.inv_ums AS metrik_vgj2,
  vis.inv_wert / IF(vis.inv_ums = 0, NULL, vis.inv_ums) AS metrik_vgj,
 NULL AS metrik_plan_vgj1,
 NULL AS metrik_plan_vgj2,
 NULL AS metrik_plan_vgj,
 NULL AS metrik_delta,
 NULL AS metrik_abw,
 NULL AS metrik_plan_gj1,
 NULL AS metrik_plan_gj2,
 NULL AS metrik_plan_gj,
 JZG50.wert_eingabe AS metrik_eingabe,
 NULL AS metrik_anteil,
 JZG50.wert_eingabe AS metrik_ziel1,
 1.00 AS metrik_ziel2,
  JZG50.wert_eingabe / IF(1.00 = 0, NULL, 1.00) AS metrik_ziel3,
 COALESCE(JZG50.wert_eingabe / IF(1.00 = 0, NULL, 1.00), 0) AS metrik_ziel
FROM (SELECT VIS_INV.mandant_id,
   VIS_INV.nb_id,
   VIS_INV.wup_id,
    VIS_INV.gj + 1 AS gj,
   VIS_INV.wrg_id,
   SUM(VIS_INV.inventur_wert_netto) AS inv_wert,
   SUM(VIS_INV.inventur_ums_netto) AS inv_ums,
    SUM(VIS_INV.inventur_wert_netto) / IF(SUM(VIS_INV.inventur_ums_netto) = 0, NULL, SUM(VIS_INV.inventur_ums_netto)) AS
   inv_quote
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur AS VIS_INV
   INNER JOIN kfl_production_dbp_data.tag AS ZEIT ON VIS_INV.dat_plan_zaehlung = ZEIT.dat
  WHERE ZEIT.akt_gj = - 1
   AND VIS_INV.nb_id = 0
   AND VIS_INV.inventurart_int_id IN (8)
  GROUP BY VIS_INV.mandant_id,
   VIS_INV.nb_id,
   VIS_INV.wup_id,
   VIS_INV.gj,
   VIS_INV.wrg_id) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert AS JZG50 ON vis.mandant_id = JZG50.mandant_id AND vis.wup_id
         = JZG50.wup_id AND vis.wrg_id = JZG50.wrg_id AND vis.gj = JZG50.gj AND JZG50.metrik_id = 50 AND JZG50.typ_id =
    0 AND JZG50.level_id = 0
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.gj,
 vis.wrg_id,
 50 AS metrik_id,
 1 AS typ_id,
 CAST(CASE
   WHEN vis.abt_id = 4
   THEN 9999999
   ELSE vis.abt_id * 1000000
   END AS BIGNUMERIC) AS level_id,
 vis.inv_wert AS metrik_vgj1,
 vis.inv_ums AS metrik_vgj2,
  vis.inv_wert / IF(vis.inv_ums = 0, NULL, vis.inv_ums) AS metrik_vgj,
 NULL AS metrik_plan_vgj1,
 NULL AS metrik_plan_vgj2,
 NULL AS metrik_plan_vgj,
 NULL AS metrik_delta,
 NULL AS metrik_abw,
 NULL AS metrik_plan_gj1,
 NULL AS metrik_plan_gj2,
 NULL AS metrik_plan_gj,
 JZG50.wert_eingabe AS metrik_eingabe,
 NULL AS metrik_anteil,
 JZG50.wert_eingabe AS metrik_ziel1,
 1.00 AS metrik_ziel2,
  JZG50.wert_eingabe / IF(1.00 = 0, NULL, 1.00) AS metrik_ziel3,
 COALESCE(JZG50.wert_eingabe / IF(1.00 = 0, NULL, 1.00), 0) AS metrik_ziel
FROM (SELECT VIS_INV.mandant_id,
   VIS_INV.nb_id,
   VIS_INV.wup_id,
    VIS_INV.gj + 1 AS gj,
   VIS_INV.wrg_id,
   ABT.abt_id,
   CAST(CASE
     WHEN ABT.abt_id = 4
     THEN 9999999
     ELSE ABT.abt_id * 1000000
     END AS BIGNUMERIC) AS level_id,
   SUM(VIS_INV.inventur_wert_netto) AS inv_wert,
   SUM(VIS_INV.inventur_ums_netto) AS inv_ums,
    SUM(VIS_INV.inventur_wert_netto) / IF(SUM(VIS_INV.inventur_ums_netto) = 0, NULL, SUM(VIS_INV.inventur_ums_netto)) AS
   inv_quote
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur AS VIS_INV
   INNER JOIN kfl_production_dbp_data.tag AS ZEIT ON VIS_INV.dat_plan_zaehlung = ZEIT.dat
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int AS OWG ON VIS_INV.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int AS ABT ON HWG.abt_id = ABT.abt_id
  WHERE ZEIT.akt_gj = - 1
   AND VIS_INV.nb_id = 0
   AND VIS_INV.inventurart_int_id IN (8)
   AND ABT.abt_id IN (5, 6) /* Ultra-Frische + Food Frische */
  GROUP BY VIS_INV.mandant_id,
   VIS_INV.nb_id,
   VIS_INV.wup_id,
   VIS_INV.gj,
   VIS_INV.wrg_id,
   ABT.abt_id,
   level_id) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert AS JZG50 ON vis.mandant_id = JZG50.mandant_id AND vis.wup_id
         = JZG50.wup_id AND vis.wrg_id = JZG50.wrg_id AND vis.gj = JZG50.gj AND JZG50.metrik_id = 50 AND JZG50.typ_id =
    1 AND vis.level_id = JZG50.level_id
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.gj,
 vis.wrg_id,
 50 AS metrik_id,
 2 AS typ_id,
 CAST(vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
 vis.inv_wert AS metrik_vgj1,
 vis.inv_ums AS metrik_vgj2,
  vis.inv_wert / IF(vis.inv_ums = 0, NULL, vis.inv_ums) AS metrik_vgj,
 NULL AS metrik_plan_vgj1,
 NULL AS metrik_plan_vgj2,
 NULL AS metrik_plan_vgj,
 NULL AS metrik_delta,
 NULL AS metrik_abw,
 NULL AS metrik_plan_gj1,
 NULL AS metrik_plan_gj2,
 NULL AS metrik_plan_gj,
 JZG50.wert_eingabe AS metrik_eingabe,
 NULL AS metrik_anteil,
 JZG50.wert_eingabe AS metrik_ziel1,
 1.00 AS metrik_ziel2,
  JZG50.wert_eingabe / IF(1.00 = 0, NULL, 1.00) AS metrik_ziel3,
 COALESCE(JZG50.wert_eingabe / IF(1.00 = 0, NULL, 1.00), 0) AS metrik_ziel
FROM (SELECT VIS_INV.mandant_id,
   VIS_INV.nb_id,
   VIS_INV.wup_id,
    VIS_INV.gj + 1 AS gj,
   VIS_INV.wrg_id,
   ABT.abt_id,
   HWG.hwg_id,
   CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
   SUM(VIS_INV.inventur_wert_netto) AS inv_wert,
   SUM(VIS_INV.inventur_ums_netto) AS inv_ums,
    SUM(VIS_INV.inventur_wert_netto) / IF(SUM(VIS_INV.inventur_ums_netto) = 0, NULL, SUM(VIS_INV.inventur_ums_netto)) AS
   inv_quote
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur AS VIS_INV
   INNER JOIN kfl_production_dbp_data.tag AS ZEIT ON VIS_INV.dat_plan_zaehlung = ZEIT.dat
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int AS OWG ON VIS_INV.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int AS ABT ON HWG.abt_id = ABT.abt_id
  WHERE ZEIT.akt_gj = - 1
   AND VIS_INV.nb_id = 0
   AND VIS_INV.inventurart_int_id IN (8)
   AND (ABT.abt_id IN (5) OR HWG.hwg_id IN (65, 81))
  GROUP BY VIS_INV.mandant_id,
   VIS_INV.nb_id,
   VIS_INV.wup_id,
   VIS_INV.gj,
   VIS_INV.wrg_id,
   ABT.abt_id,
   HWG.hwg_id,
   level_id) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert AS JZG50 ON vis.mandant_id = JZG50.mandant_id AND vis.wup_id
         = JZG50.wup_id AND vis.wrg_id = JZG50.wrg_id AND vis.gj = JZG50.gj AND JZG50.metrik_id = 50 AND JZG50.typ_id =
    2 AND vis.level_id = JZG50.level_id
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.gj,
 vis.wrg_id,
 50 AS metrik_id,
 3 AS typ_id,
 CAST(vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 + ABS(vis.owg_id) AS BIGNUMERIC) AS level_id,
 vis.inv_wert AS metrik_vgj1,
 vis.inv_ums AS metrik_vgj2,
  vis.inv_wert / IF(vis.inv_ums = 0, NULL, vis.inv_ums) AS metrik_vgj,
 NULL AS metrik_plan_vgj1,
 NULL AS metrik_plan_vgj2,
 NULL AS metrik_plan_vgj,
 NULL AS metrik_delta,
 NULL AS metrik_abw,
 NULL AS metrik_plan_gj1,
 NULL AS metrik_plan_gj2,
 NULL AS metrik_plan_gj,
 JZG50.wert_eingabe AS metrik_eingabe,
 NULL AS metrik_anteil,
 JZG50.wert_eingabe AS metrik_ziel1,
 1.00 AS metrik_ziel2,
  JZG50.wert_eingabe / IF(1.00 = 0, NULL, 1.00) AS metrik_ziel3,
 COALESCE(JZG50.wert_eingabe / IF(1.00 = 0, NULL, 1.00), 0) AS metrik_ziel
FROM (SELECT VIS_INV.mandant_id,
   VIS_INV.nb_id,
   VIS_INV.wup_id,
    VIS_INV.gj + 1 AS gj,
   VIS_INV.wrg_id,
   ABT.abt_id,
   HWG.hwg_id,
   OWG.owg_id,
   CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id) AS BIGNUMERIC) AS level_id,
   SUM(VIS_INV.inventur_wert_netto) AS inv_wert,
   SUM(VIS_INV.inventur_ums_netto) AS inv_ums,
    SUM(VIS_INV.inventur_wert_netto) / IF(SUM(VIS_INV.inventur_ums_netto) = 0, NULL, SUM(VIS_INV.inventur_ums_netto)) AS
   inv_quote
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur AS VIS_INV
   INNER JOIN kfl_production_dbp_data.tag AS ZEIT ON VIS_INV.dat_plan_zaehlung = ZEIT.dat
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int AS OWG ON VIS_INV.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int AS ABT ON HWG.abt_id = ABT.abt_id
  WHERE ZEIT.akt_gj = - 1
   AND VIS_INV.nb_id = 0
   AND VIS_INV.inventurart_int_id IN (8)
   AND ABT.abt_id IN (5) /* Ultra-Frische */
  GROUP BY VIS_INV.mandant_id,
   VIS_INV.nb_id,
   VIS_INV.wup_id,
   VIS_INV.gj,
   VIS_INV.wrg_id,
   ABT.abt_id,
   HWG.hwg_id,
   OWG.owg_id,
   level_id) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert AS JZG50 ON vis.mandant_id = JZG50.mandant_id AND vis.wup_id
         = JZG50.wup_id AND vis.wrg_id = JZG50.wrg_id AND vis.gj = JZG50.gj AND JZG50.metrik_id = 50 AND JZG50.typ_id =
    3 AND vis.level_id = JZG50.level_id;