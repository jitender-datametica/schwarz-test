CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jzg_data_ziel_1 (mandant_id, nb_id, wup_id, wrg_id, gj,
metrik_id, typ_id, level_id, eingabe, kommentar, helper, anteil1, anteil2, anteil, ziel1, ziel2, ziel) AS SELECT vis.mandant_id
 ,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 10 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 COALESCE(JZG10.wert_eingabe, 0) AS eing,
 COALESCE(JZG10.kommentar_eingabe, '') AS komm,
 CAST(NULL AS BIGNUMERIC) AS hlpr,
 1.000 AS a1,
 CAST(NULL AS BIGNUMERIC) AS a2,
 1.000 AS antl,
 COALESCE(JZG10.wert_eingabe, 0) AS z1,
 CAST(NULL AS BIGNUMERIC) AS z2,
 COALESCE(JZG10.wert_eingabe, 0) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 10 AS metrik_id,
 1 AS typ_id,
 CAST(CASE
   WHEN pln.abt_id = 4
   THEN 9999999
   ELSE pln.abt_id * 1000000
   END AS BIGNUMERIC) AS level_id,
 CAST(NULL AS BIGNUMERIC) AS eing,
 '' AS komm,
 JZG10.wert_eingabe AS hlpr,
 pln.ums_plan AS a1,
 vis.ums_plan AS a2,
  pln.ums_plan / IF(vis.ums_plan = 0, NULL, vis.ums_plan) AS antl,
  JZG10.wert_eingabe * (pln.ums_plan / IF(vis.ums_plan = 0, NULL, vis.ums_plan)) AS z1,
 CAST(NULL AS BIGNUMERIC) AS z2,
 IFNULL(JZG10.wert_eingabe * (pln.ums_plan / IF(vis.ums_plan = 0, NULL, vis.ums_plan)), 0) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT0.gj,
   ABT.abt_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLAN.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT0 ON PLAN.kjmo = ZEIT0.kjmo AND ZEIT0.akt_gj = 0
  WHERE ABT.abt_id IN (4, 5, 6, 7, 8)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ABT.abt_id,
   ZEIT0.gj) AS pln ON vis.mandant_id = pln.mandant_id AND vis.wup_id = pln.wup_id AND vis.wrg_id = pln.wrg_id AND vis.gj
    = pln.gj
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 10 AS metrik_id,
 2 AS typ_id,
 CAST(pln.abt_id * 1000000 + ABS(pln.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
 CAST(NULL AS BIGNUMERIC) AS eing,
 '' AS komm,
 JZG10.wert_eingabe AS hlpr,
 pln.ums_plan AS a1,
 vis.ums_plan AS a2,
  pln.ums_plan / IF(vis.ums_plan = 0, NULL, vis.ums_plan) AS antl,
  JZG10.wert_eingabe * (pln.ums_plan / IF(vis.ums_plan = 0, NULL, vis.ums_plan)) AS z1,
 CAST(NULL AS BIGNUMERIC) AS z2,
 IFNULL(JZG10.wert_eingabe * (pln.ums_plan / IF(vis.ums_plan = 0, NULL, vis.ums_plan)), 0) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT1.gj,
   ABT.abt_id,
   HWG.hwg_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLAN.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT1 ON PLAN.kjmo = ZEIT1.kjmo AND ZEIT1.akt_gj = 0
  WHERE ABT.abt_id IN (5, 6)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   HWG.hwg_id,
   ABT.abt_id,
   ZEIT1.gj) AS pln ON vis.mandant_id = pln.mandant_id AND vis.wup_id = pln.wup_id AND vis.wrg_id = pln.wrg_id AND vis.gj
    = pln.gj
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 10 AS metrik_id,
 3 AS typ_id,
 CAST(pln.abt_id * 1000000 + ABS(pln.hwg_id) * 10000 + pln.owg_id AS BIGNUMERIC) AS level_id,
 CAST(NULL AS BIGNUMERIC) AS eing,
 '' AS komm,
 JZG10.wert_eingabe AS hlpr,
 pln.ums_plan AS a1,
 vis.ums_plan AS a2,
  pln.ums_plan / IF(vis.ums_plan = 0, NULL, vis.ums_plan) AS antl,
  JZG10.wert_eingabe * (pln.ums_plan / IF(vis.ums_plan = 0, NULL, vis.ums_plan)) AS z1,
 CAST(NULL AS BIGNUMERIC) AS z2,
 IFNULL(JZG10.wert_eingabe * (pln.ums_plan / IF(vis.ums_plan = 0, NULL, vis.ums_plan)), 0) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT2.gj,
   ABT.abt_id,
   HWG.hwg_id,
   OWG.owg_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLAN.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT2 ON PLAN.kjmo = ZEIT2.kjmo AND ZEIT2.akt_gj = 0
  WHERE ABT.abt_id IN (5)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   OWG.owg_id,
   HWG.hwg_id,
   ABT.abt_id,
   ZEIT2.gj) AS pln ON vis.mandant_id = pln.mandant_id AND vis.wup_id = pln.wup_id AND vis.wrg_id = pln.wrg_id AND vis.gj
    = pln.gj
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 16 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 COALESCE(JZG16.wert_eingabe, 0) AS eing,
 COALESCE(JZG16.kommentar_eingabe, '') AS komm,
 CAST(NULL AS BIGNUMERIC) AS hlpr,
 1.000 AS a1,
 CAST(NULL AS BIGNUMERIC) AS a2,
 1.000 AS antl,
 COALESCE(JZG16.wert_eingabe, 0) AS z1,
 CAST(NULL AS BIGNUMERIC) AS z2,
 COALESCE(JZG16.wert_eingabe, 0) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG16 ON vis.mandant_id = JZG16.mandant_id AND vis.wup_id
         = JZG16.wup_id AND vis.wrg_id = JZG16.wrg_id AND vis.gj = JZG16.gj AND JZG16.metrik_id = 16 AND JZG16.typ_id =
    0 AND JZG16.level_id = 0
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 18 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 CAST(NULL AS BIGNUMERIC) AS eing,
 '' AS komm,
 CAST(NULL AS BIGNUMERIC) AS hlpr,
 1.000 AS a1,
 CAST(NULL AS BIGNUMERIC) AS a2,
 1.000 AS antl,
 JZG10.wert_eingabe AS z1,
 JZG16.wert_eingabe AS z2,
 IFNULL(JZG10.wert_eingabe / IF(JZG16.wert_eingabe = 0, NULL, JZG16.wert_eingabe), 0) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG16 ON vis.mandant_id = JZG16.mandant_id AND vis.wup_id
         = JZG16.wup_id AND vis.wrg_id = JZG16.wrg_id AND vis.gj = JZG16.gj AND JZG16.metrik_id = 16 AND JZG16.typ_id =
    0 AND JZG16.level_id = 0
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 20 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 CAST(NULL AS BIGNUMERIC) AS eing,
 '' AS komm,
 CAST(NULL AS BIGNUMERIC) AS hlpr,
 1.000 AS a1,
 CAST(NULL AS BIGNUMERIC) AS a2,
 1.000 AS antl,
 JZG10.wert_eingabe AS z1,
 JZG24.wert_eingabe AS z2,
  JZG10.wert_eingabe / IF(JZG24.wert_eingabe = 0, NULL, JZG24.wert_eingabe) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG24 ON vis.mandant_id = JZG24.mandant_id AND vis.wup_id
         = JZG24.wup_id AND vis.wrg_id = JZG24.wrg_id AND vis.gj = JZG24.gj AND JZG24.metrik_id = 24 AND JZG24.typ_id =
    0 AND JZG24.level_id = 0
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 24 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 COALESCE(JZG24.wert_eingabe, 0) AS eing,
 COALESCE(JZG24.kommentar_eingabe, '') AS komm,
 CAST(NULL AS BIGNUMERIC) AS hlpr,
 1.000 AS a1,
 CAST(NULL AS BIGNUMERIC) AS a2,
 1.000 AS antl,
 COALESCE(JZG24.wert_eingabe, 0) AS z1,
 CAST(NULL AS BIGNUMERIC) AS z2,
 COALESCE(JZG24.wert_eingabe, 0) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG24 ON vis.mandant_id = JZG24.mandant_id AND vis.wup_id
         = JZG24.wup_id AND vis.wrg_id = JZG24.wrg_id AND vis.gj = JZG24.gj AND JZG24.metrik_id = 24 AND JZG24.typ_id =
    0 AND JZG24.level_id = 0
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 40 AS metrik_id,
 jzg.typ AS typ_id,
 jzg.level AS level_id,
 jzg.abs_ein AS ein,
 jzg.kommentar AS komm,
 CAST(NULL AS BIGNUMERIC) AS hlpr,
 JZG10.wert_eingabe AS a1,
 vis.ums_plan AS a2,
  JZG10.wert_eingabe / IF(vis.ums_plan = 0, NULL, vis.ums_plan) AS antl,
  jzg.abs_calc * (JZG10.wert_eingabe / IF(vis.ums_plan = 0, NULL, vis.ums_plan)) AS z1,
  jzg.abs_ums * (JZG10.wert_eingabe / IF(vis.ums_plan = 0, NULL, vis.ums_plan)) AS z2,
   jzg.abs_calc * (JZG10.wert_eingabe / IF(vis.ums_plan = 0, NULL, vis.ums_plan)) / IF(jzg.abs_ums * (JZG10.wert_eingabe
        / IF(vis.ums_plan = 0, NULL, vis.ums_plan)) = 0, NULL, jzg.abs_ums * (JZG10.wert_eingabe / IF(vis.ums_plan = 0,
       NULL, vis.ums_plan))) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0
 LEFT JOIN (SELECT vis.mandant_id,
    vis.nb_id,
    vis.wup_id,
    vis.wrg_id,
    vis.gj,
    vis.abt_id,
    vis.hwg_id,
    vis.owg_id,
    vis.typ_id AS typ,
    vis.level_id AS level,
    vis.ums_plan AS abs_ums,
    COALESCE(JZG.wert_eingabe, 0) AS abs_ein,
    COALESCE(JZG.kommentar_eingabe, '') AS kommentar,
     JZG.wert_eingabe * vis.ums_plan AS abs_calc
   FROM (SELECT PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      ZEIT.gj,
      ABT.abt_id,
      HWG.hwg_id,
      OWG.owg_id,
      3 AS typ_id,
      CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id) AS BIGNUMERIC) AS level_id,
      SUM(PLN.umsatz_netto_plan) AS ums_plan
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
     WHERE OWG.owg_id IN (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1013)
     GROUP BY PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      OWG.owg_id,
      HWG.hwg_id,
      ABT.abt_id,
      ZEIT.gj) AS vis
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG ON vis.mandant_id = JZG.mandant_id AND vis.wup_id
            = JZG.wup_id AND vis.wrg_id = JZG.wrg_id AND vis.gj = JZG.gj AND JZG.metrik_id = 40 AND JZG.typ_id = 3 AND
      vis.level_id = JZG.level_id
   UNION ALL
   SELECT vis.mandant_id,
    vis.nb_id,
    vis.wup_id,
    vis.wrg_id,
    vis.gj,
    vis.abt_id,
    vis.hwg_id,
    0 AS owg_id,
    2 AS typ,
    CAST(vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 AS BIGNUMERIC) AS level,
    SUM(vis.ums_plan) AS abs_ums,
    CAST(NULL AS BIGNUMERIC) AS abs_ein,
    '' AS kommentar,
    SUM(JZG.wert_eingabe * vis.ums_plan) AS abs_calc
   FROM (SELECT PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      ZEIT.gj,
      ABT.abt_id,
      HWG.hwg_id,
      OWG.owg_id,
      3 AS typ_id,
      CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id) AS BIGNUMERIC) AS level_id,
      SUM(PLN.umsatz_netto_plan) AS ums_plan
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
     WHERE OWG.owg_id IN (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1013)
     GROUP BY PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      OWG.owg_id,
      HWG.hwg_id,
      ABT.abt_id,
      ZEIT.gj) AS vis
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG ON vis.mandant_id = JZG.mandant_id AND vis.wup_id
            = JZG.wup_id AND vis.wrg_id = JZG.wrg_id AND vis.gj = JZG.gj AND JZG.metrik_id = 40 AND JZG.typ_id = 3 AND
      vis.level_id = JZG.level_id
   GROUP BY vis.mandant_id,
    vis.nb_id,
    vis.wup_id,
    vis.wrg_id,
    vis.gj,
    vis.abt_id,
    vis.hwg_id
   UNION ALL
   SELECT vis.mandant_id,
    vis.nb_id,
    vis.wup_id,
    vis.wrg_id,
    vis.gj,
    vis.abt_id,
    vis.hwg_id,
    vis.owg_id,
    vis.typ_id,
    vis.level_id,
    vis.ums_plan AS abs_ums,
    COALESCE(JZG.wert_eingabe, 0) AS abs_ein,
    COALESCE(JZG.kommentar_eingabe, '') AS kommentar,
     JZG.wert_eingabe * vis.ums_plan AS abs_calc
   FROM (SELECT PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      ZEIT.gj,
      ABT.abt_id,
      HWG.hwg_id,
      0 AS owg_id,
      2 AS typ_id,
      CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
      SUM(PLN.umsatz_netto_plan) AS ums_plan
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
     WHERE PLN.owg_id IN (- 1027, - 1022, - 1019, - 1017, - 1015)
     GROUP BY PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      HWG.hwg_id,
      ABT.abt_id,
      ZEIT.gj) AS vis
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG ON vis.mandant_id = JZG.mandant_id AND vis.wup_id
           = JZG.wup_id AND vis.wrg_id = JZG.wrg_id AND JZG.metrik_id = 40 AND JZG.typ_id = 2 AND vis.level_id = JZG.level_id
      
   UNION ALL
   SELECT vis.mandant_id,
    vis.nb_id,
    vis.wup_id,
    vis.wrg_id,
    vis.gj,
    vis.abt_id,
    0 AS hwg_id,
    0 AS owg_id,
    1 AS typ_id,
    CAST(CASE
      WHEN vis.abt_id = 4
      THEN 9999999
      ELSE vis.abt_id * 1000000
      END AS BIGNUMERIC) AS level_id,
    SUM(vis.ums_plan) AS abs_ums,
    CAST(NULL AS BIGNUMERIC) AS abs_ein,
    '' AS kommentar,
    SUM(JZG.wert_eingabe * vis.ums_plan) AS abs_calc
   FROM (SELECT PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      ZEIT.gj,
      ABT.abt_id,
      HWG.hwg_id,
      OWG.owg_id,
      3 AS typ_id,
      CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id) AS BIGNUMERIC) AS level_id,
      SUM(PLN.umsatz_netto_plan) AS ums_plan
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
     WHERE OWG.owg_id IN (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1013)
     GROUP BY PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      OWG.owg_id,
      HWG.hwg_id,
      ABT.abt_id,
      ZEIT.gj) AS vis
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG ON vis.mandant_id = JZG.mandant_id AND vis.wup_id
            = JZG.wup_id AND vis.wrg_id = JZG.wrg_id AND vis.gj = JZG.gj AND JZG.metrik_id = 40 AND JZG.typ_id = 3 AND
      vis.level_id = JZG.level_id
   GROUP BY vis.mandant_id,
    vis.nb_id,
    vis.wup_id,
    vis.wrg_id,
    vis.gj,
    vis.abt_id
   UNION ALL
   SELECT vis.mandant_id,
    vis.nb_id,
    vis.wup_id,
    vis.wrg_id,
    vis.gj,
    vis.abt_id,
    0 AS hwg_id,
    0 AS owg_id,
    1 AS typ_id,
    CAST(CASE
      WHEN vis.abt_id = 4
      THEN 9999999
      ELSE vis.abt_id * 1000000
      END AS BIGNUMERIC) AS level_id,
    SUM(vis.ums_plan) AS abs_ums,
    CAST(NULL AS BIGNUMERIC) AS abs_ein,
    '' AS kommentar,
    SUM(JZG.wert_eingabe * vis.ums_plan) AS abs_calc
   FROM (SELECT PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      ZEIT.gj,
      ABT.abt_id,
      HWG.hwg_id,
      0 AS owg_id,
      2 AS typ_id,
      CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
      SUM(PLN.umsatz_netto_plan) AS ums_plan
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
     WHERE PLN.owg_id IN (- 1027, - 1022, - 1019, - 1017, - 1015)
     GROUP BY PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      HWG.hwg_id,
      ABT.abt_id,
      ZEIT.gj) AS vis
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG ON vis.mandant_id = JZG.mandant_id AND vis.wup_id
           = JZG.wup_id AND vis.wrg_id = JZG.wrg_id AND JZG.metrik_id = 40 AND JZG.typ_id = 2 AND vis.level_id = JZG.level_id
      
   GROUP BY vis.mandant_id,
    vis.nb_id,
    vis.wup_id,
    vis.wrg_id,
    vis.gj,
    vis.abt_id
   UNION ALL
   SELECT vis.mandant_id,
    vis.nb_id,
    vis.wup_id,
    vis.wrg_id,
    vis.gj,
    vis.abt_id,
    vis.hwg_id,
    vis.owg_id,
    vis.typ_id,
    vis.level_id,
    vis.ums_plan AS abs_ums,
    COALESCE(JZG.wert_eingabe, 0) AS abs_ein,
    COALESCE(JZG.kommentar_eingabe, '') AS kommentar,
     JZG.wert_eingabe * vis.ums_plan AS abs_calc
   FROM (SELECT PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      ZEIT.gj,
      ABT.abt_id,
      0 AS hwg_id,
      0 AS owg_id,
      1 AS typ_id,
      CAST(CASE
        WHEN ABT.abt_id = 4
        THEN 9999999
        ELSE ABT.abt_id * 1000000
        END AS BIGNUMERIC) AS level_id,
      SUM(PLN.umsatz_netto_plan) AS ums_plan
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
     WHERE PLN.owg_id IN (- 1092, - 1068, - 1028)
     GROUP BY PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      ABT.abt_id,
      ZEIT.gj) AS vis
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG ON vis.mandant_id = JZG.mandant_id AND vis.wup_id
            = JZG.wup_id AND vis.wrg_id = JZG.wrg_id AND vis.gj = JZG.gj AND JZG.metrik_id = 40 AND JZG.typ_id = 1 AND
      vis.level_id = JZG.level_id
   UNION ALL
   SELECT vis.mandant_id,
    vis.nb_id,
    vis.wup_id,
    vis.wrg_id,
    vis.gj,
    0 AS abt_id,
    0 AS hwg_id,
    0 AS owg_id,
    0 AS typ,
    0 AS level,
    SUM(vis.ums_plan) AS abs_ums,
    CAST(NULL AS BIGNUMERIC) AS abs_ein,
    '' AS kommentar,
    SUM(JZG.wert_eingabe * vis.ums_plan) AS abs_calc
   FROM (SELECT PLN.mandant_id,
       PLN.nb_id,
       PLN.wup_id,
       PLN.wrg_id,
       ZEIT.gj,
       ABT.abt_id,
       HWG.hwg_id,
       OWG.owg_id,
       3 AS typ_id,
       CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id) AS BIGNUMERIC) AS level_id,
       SUM(PLN.umsatz_netto_plan) AS ums_plan
      FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
       INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
       INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
       INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
       INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
      WHERE OWG.owg_id IN (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1013)
      GROUP BY PLN.mandant_id,
       PLN.nb_id,
       PLN.wup_id,
       PLN.wrg_id,
       OWG.owg_id,
       HWG.hwg_id,
       ABT.abt_id,
       ZEIT.gj
      UNION ALL
      SELECT PLN.mandant_id,
       PLN.nb_id,
       PLN.wup_id,
       PLN.wrg_id,
       ZEIT.gj,
       ABT.abt_id,
       HWG.hwg_id,
       0 AS owg_id,
       2 AS typ_id,
       CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
       SUM(PLN.umsatz_netto_plan) AS ums_plan
      FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
       INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
       INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
       INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
       INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
      WHERE PLN.owg_id IN (- 1027, - 1022, - 1019, - 1017, - 1015)
      GROUP BY PLN.mandant_id,
       PLN.nb_id,
       PLN.wup_id,
       PLN.wrg_id,
       HWG.hwg_id,
       ABT.abt_id,
       ZEIT.gj
      UNION ALL
      SELECT PLN.mandant_id,
       PLN.nb_id,
       PLN.wup_id,
       PLN.wrg_id,
       ZEIT.gj,
       ABT.abt_id,
       0 AS hwg_id,
       0 AS owg_id,
       1 AS typ_id,
       CAST(CASE
         WHEN ABT.abt_id = 4
         THEN 9999999
         ELSE ABT.abt_id * 1000000
         END AS BIGNUMERIC) AS level_id,
       SUM(PLN.umsatz_netto_plan) AS ums_plan
      FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
       INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
       INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
       INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
       INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
      WHERE PLN.owg_id IN (- 1092, - 1068, - 1028)
      GROUP BY PLN.mandant_id,
       PLN.nb_id,
       PLN.wup_id,
       PLN.wrg_id,
       ABT.abt_id,
       ZEIT.gj) AS vis
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG ON vis.mandant_id = JZG.mandant_id AND vis.wup_id
           = JZG.wup_id AND vis.wrg_id = JZG.wrg_id AND vis.gj = JZG.gj AND JZG.metrik_id = 40 AND vis.level_id = JZG.level_id
      
   GROUP BY vis.mandant_id,
    vis.nb_id,
    vis.wup_id,
    vis.wrg_id,
    vis.gj) AS jzg ON vis.mandant_id = jzg.mandant_id AND vis.wup_id = jzg.wup_id AND vis.wrg_id = jzg.wrg_id AND vis.gj
    = jzg.gj
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 46 AS metrik_id,
 pln.typ_id,
 pln.level_id,
 pln.inv_ein AS eing,
 pln.kommentar AS komm,
 CAST(NULL AS BIGNUMERIC) AS hlpr,
 JZG10.wert_eingabe AS a1,
 vis.ums_plan AS a2,
  JZG10.wert_eingabe / IF(vis.ums_plan = 0, NULL, vis.ums_plan) AS antl,
  pln.inv_calc * (JZG10.wert_eingabe / IF(vis.ums_plan = 0, NULL, vis.ums_plan)) AS z1,
  pln.ums_plan * (JZG10.wert_eingabe / IF(vis.ums_plan = 0, NULL, vis.ums_plan)) AS z2,
   pln.inv_calc * (JZG10.wert_eingabe / IF(vis.ums_plan = 0, NULL, vis.ums_plan)) / IF(pln.ums_plan * (JZG10.wert_eingabe
        / IF(vis.ums_plan = 0, NULL, vis.ums_plan)) = 0, NULL, pln.ums_plan * (JZG10.wert_eingabe / IF(vis.ums_plan = 0
       , NULL, vis.ums_plan))) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0
 LEFT JOIN (SELECT PLN.mandant_id,
    PLN.nb_id,
    PLN.wup_id,
    ZEIT.gj,
    PLN.wrg_id,
    ABT.abt_id,
    1 AS typ_id,
    CAST(CASE
      WHEN ABT.abt_id = 4
      THEN 9999999
      ELSE ABT.abt_id * 1000000
      END AS BIGNUMERIC) AS level_id,
    SUM(PLN.umsatz_netto_plan) AS ums_plan,
    MAX(JZG50.wert_eingabe) AS inv_ein,
    MAX(JZG50.kommentar_eingabe) AS kommentar,
    SUM(PLN.umsatz_netto_plan * JZG50.wert_eingabe) AS inv_calc
   FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
    INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG50 ON PLN.mandant_id = JZG50.mandant_id AND PLN
           .wup_id = JZG50.wup_id AND PLN.wrg_id = JZG50.wrg_id AND ZEIT.gj = JZG50.gj AND JZG50.metrik_id = 46 AND
       JZG50.typ_id = 1 AND JZG50.level_id = CASE
       WHEN ABT.abt_id = 4
       THEN 9999999
       ELSE ABT.abt_id * 1000000
       END
   WHERE ABT.abt_id IN (4, 5, 6, 7, 8)
   GROUP BY PLN.mandant_id,
    PLN.nb_id,
    PLN.wup_id,
    ZEIT.gj,
    PLN.wrg_id,
    ABT.abt_id
   UNION ALL
   SELECT PLN.mandant_id,
    PLN.nb_id,
    PLN.wup_id,
    ZEIT.gj,
    PLN.wrg_id,
    0,
    0 AS typ_id,
    0 AS level_id,
    SUM(PLN.umsatz_netto_plan) AS ums_plan,
    CAST(NULL AS BIGNUMERIC) AS inv_ein,
    '' AS kommentar,
    SUM(PLN.umsatz_netto_plan * JZG50.wert_eingabe) AS inv_calc
   FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
    INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG50 ON PLN.mandant_id = JZG50.mandant_id AND PLN
          .wup_id = JZG50.wup_id AND PLN.wrg_id = JZG50.wrg_id AND ZEIT.gj = JZG50.gj AND JZG50.metrik_id = 46 AND JZG50
      .level_id = CASE
       WHEN ABT.abt_id = 4
       THEN 9999999
       ELSE ABT.abt_id * 1000000
       END
   WHERE ABT.abt_id IN (4, 5, 6, 7, 8)
   GROUP BY PLN.mandant_id,
    PLN.nb_id,
    PLN.wup_id,
    ZEIT.gj,
    PLN.wrg_id) AS pln ON vis.mandant_id = pln.mandant_id AND vis.wup_id = pln.wup_id AND vis.wrg_id = pln.wrg_id AND
   vis.gj = pln.gj
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 70 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 COALESCE(JZG70.wert_eingabe, 0) AS eing,
 COALESCE(JZG70.kommentar_eingabe, '') AS komm,
 COALESCE(JZG10.wert_eingabe, 0) AS hlpr,
 1.000 AS a1,
 CAST(NULL AS BIGNUMERIC) AS a2,
 1.000 AS antl,
  COALESCE(JZG10.wert_eingabe, 0) * COALESCE(JZG70.wert_eingabe, 0) AS z1,
 COALESCE(JZG10.wert_eingabe, 0) AS z2,
 COALESCE(JZG70.wert_eingabe, 0) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG70 ON vis.mandant_id = JZG70.mandant_id AND vis.wup_id
         = JZG70.wup_id AND vis.wrg_id = JZG70.wrg_id AND vis.gj = JZG70.gj AND JZG70.metrik_id = 70 AND JZG70.typ_id =
    0 AND JZG70.level_id = 0
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 jzg.metrik_id,
 0 AS typ_id,
 0 AS level_id,
 CAST(NULL AS BIGNUMERIC) AS eing,
 COALESCE(JZG90.kommentar_eingabe, '') AS komm,
 CAST(NULL AS BIGNUMERIC) AS hlpr,
 CAST(NULL AS BIGNUMERIC) AS a1,
 CAST(NULL AS BIGNUMERIC) AS a2,
 CAST(NULL AS NUMERIC) AS antl,
 CAST(NULL AS BIGNUMERIC) AS z1,
 CAST(NULL AS BIGNUMERIC) AS z2,
 CAST(NULL AS BIGNUMERIC) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 INNER JOIN (SELECT 91 AS metrik_id
   UNION ALL
   SELECT 92 AS metrik_id
   UNION ALL
   SELECT 93 AS metrik_id
   UNION ALL
   SELECT 94 AS metrik_id
   UNION ALL
   SELECT 95 AS metrik_id) AS jzg ON TRUE
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG90 ON vis.mandant_id = JZG90.mandant_id AND vis.wup_id
         = JZG90.wup_id AND vis.wrg_id = JZG90.wrg_id AND vis.gj = JZG90.gj AND jzg.metrik_id = JZG90.metrik_id AND
    JZG90.typ_id = 0 AND JZG90.level_id = 0
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 jzg.metrik_id,
 0 AS typ_id,
 0 AS level_id,
 CAST(NULL AS BIGNUMERIC) AS eing,
 '' AS komm,
 CAST(NULL AS BIGNUMERIC) AS hlpr,
 CAST(NULL AS BIGNUMERIC) AS a1,
 CAST(NULL AS BIGNUMERIC) AS a2,
 CAST(NULL AS NUMERIC) AS antl,
 CAST(NULL AS BIGNUMERIC) AS z1,
 CAST(NULL AS BIGNUMERIC) AS z2,
 CAST(NULL AS BIGNUMERIC) AS ziel
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_1
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 INNER JOIN (SELECT 30 AS metrik_id
   UNION ALL
   SELECT 32 AS metrik_id
   UNION ALL
   SELECT 34 AS metrik_id
   UNION ALL
   SELECT 36 AS metrik_id
   UNION ALL
   SELECT 50 AS metrik_id
   UNION ALL
   SELECT 54 AS metrik_id
   UNION ALL
   SELECT 55 AS metrik_id
   UNION ALL
   SELECT 56 AS metrik_id
   UNION ALL
   SELECT 57 AS metrik_id
   UNION ALL
   SELECT 58 AS metrik_id
   UNION ALL
   SELECT 59 AS metrik_id
   UNION ALL
   SELECT 60 AS metrik_id
   UNION ALL
   SELECT 61 AS metrik_id
   UNION ALL
   SELECT 62 AS metrik_id
   UNION ALL
   SELECT 63 AS metrik_id
   UNION ALL
   SELECT 72 AS metrik_id
   UNION ALL
   SELECT 73 AS metrik_id
   UNION ALL
   SELECT 74 AS metrik_id
   UNION ALL
   SELECT 75 AS metrik_id
   UNION ALL
   SELECT 76 AS metrik_id
   UNION ALL
   SELECT 77 AS metrik_id
   UNION ALL
   SELECT 78 AS metrik_id
   UNION ALL
   SELECT 80 AS metrik_id
   UNION ALL
   SELECT 81 AS metrik_id
   UNION ALL
   SELECT 82 AS metrik_id
   UNION ALL
   SELECT 84 AS metrik_id
   UNION ALL
   SELECT 86 AS metrik_id
   UNION ALL
   SELECT 88 AS metrik_id) AS jzg ON TRUE;