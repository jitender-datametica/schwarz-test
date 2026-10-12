CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jzg_data_main_2 (mandant_id, nb_id, wup_id, wrg_id, gj,
metrik_id, typ_id, level_id, wert_vj1, wert_vj2, plan_vj1, plan_vj2, plan_gj1, plan_gj2, wert_vj, plan_vj, plan_gj,
delta, abw) AS SELECT t0.mandant_id,
 t0.nb_id,
 t0.wup_id,
 t0.wrg_id,
  t0.gj + 1 AS gj,
 10 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 t0.ums_wert AS wert_vj1,
 CAST(NULL AS BIGNUMERIC) AS wert_vj2,
 t0.ums_plan AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 t2.ums_plan AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
 t0.ums_wert AS wert_vj,
 t0.ums_plan AS plan_vj,
 t2.ums_plan AS plan_gj,
  t0.ums_wert - t0.ums_plan AS delta,
   (t0.ums_wert - t0.ums_plan) / IF(t0.ums_plan = 0, NULL, t0.ums_plan) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto) AS ums_wert,
   SUM(VIS.ums_netto_plan) AS ums_plan,
   SUM(VIS.anz_kunde) AS anz_kunde,
   SUM(VIS.pers_std) AS std_wert,
   SUM(VIS.pers_std_plan) AS std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_2
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS t0
 INNER JOIN (SELECT VIS0.mandant_id,
   VIS0.nb_id,
   VIS0.wup_id,
   VIS0.wrg_id,
   ZEIT0.gj,
   SUM(VIS0.ums_netto_plan) AS ums_plan,
   SUM(VIS0.pers_std_plan) AS std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS0
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT0 ON VIS0.kjmo = ZEIT0.kjmo AND ZEIT0.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP0 ON VIS0.wup_id = WUP0.wup_id AND VIS0.mandant_id = WUP0.mandant_id AND
       WUP0.nb_id = 0 AND WUP0.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP0.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP0.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT0.gj + 1
  GROUP BY VIS0.mandant_id,
   VIS0.nb_id,
   VIS0.wup_id,
   VIS0.wrg_id,
   ZEIT0.gj) AS t2 ON t0.mandant_id = t2.mandant_id AND t0.wup_id = t2.wup_id AND t0.wrg_id = t2.wrg_id AND t2.gj = t0.gj
     + 1
UNION ALL
SELECT t5.mandant_id,
 t5.nb_id,
 t5.wup_id,
 t5.wrg_id,
  t5.gj + 1 AS gj,
 10 AS metrik_id,
 1 AS typ_id,
 CAST(CASE
   WHEN t5.abt_id = 4
   THEN 9999999
   ELSE t5.abt_id * 1000000
   END AS BIGNUMERIC) AS level_id,
 t5.ums_wert AS wert_vj1,
 CAST(NULL AS BIGNUMERIC) AS wert_vj2,
 t7.ums_plan AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 t9.ums_plan AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
 t5.ums_wert AS wert_vj,
 t7.ums_plan AS plan_vj,
 t9.ums_plan AS plan_gj,
  t5.ums_wert - t7.ums_plan AS delta,
   (t5.ums_wert - t7.ums_plan) / IF(t7.ums_plan = 0, NULL, t7.ums_plan) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   ABT.abt_id,
   SUM(VIS.ums_netto) AS ums_wert
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_2 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT_2 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_2
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   ABT.abt_id,
   ZEIT.gj) AS t5
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT1.gj,
   ABT0.abt_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG0 ON PLAN.owg_id = OWG0.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG0 ON OWG0.hwg_id = HWG0.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT0 ON HWG0.abt_id = ABT0.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT1 ON PLAN.kjmo = ZEIT1.kjmo AND ZEIT1.akt_gj = - 1
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ABT0.abt_id,
   ZEIT1.gj) AS t7 ON t5.mandant_id = t7.mandant_id AND t5.wup_id = t7.wup_id AND t5.wrg_id = t7.wrg_id AND t5.gj = t7.gj
     AND t5.abt_id = t7.abt_id
 LEFT JOIN (SELECT PLAN0.mandant_id,
   PLAN0.nb_id,
   PLAN0.wup_id,
   PLAN0.wrg_id,
   ZEIT2.gj,
   ABT1.abt_id,
   SUM(PLAN0.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN0.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN0
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG1 ON PLAN0.owg_id = OWG1.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG1 ON OWG1.hwg_id = HWG1.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT1 ON HWG1.abt_id = ABT1.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT2 ON PLAN0.kjmo = ZEIT2.kjmo AND ZEIT2.akt_gj = 0
  GROUP BY PLAN0.mandant_id,
   PLAN0.nb_id,
   PLAN0.wup_id,
   PLAN0.wrg_id,
   ABT1.abt_id,
   ZEIT2.gj) AS t9 ON t5.mandant_id = t9.mandant_id AND t5.wup_id = t9.wup_id AND t5.wrg_id = t9.wrg_id AND t9.gj = t5.gj
      + 1 AND t5.abt_id = t9.abt_id
UNION ALL
SELECT t13.mandant_id,
 t13.nb_id,
 t13.wup_id,
 t13.wrg_id,
  t13.gj + 1 AS gj,
 10 AS metrik_id,
 2 AS typ_id,
 CAST(t13.abt_id * 1000000 + ABS(t13.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
 t13.ums_wert AS wert_vj1,
 CAST(NULL AS BIGNUMERIC) AS wert_vj2,
 t16.ums_plan AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 t19.ums_plan AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
 t13.ums_wert AS wert_vj,
 t16.ums_plan AS plan_vj,
 t19.ums_plan AS plan_gj,
  t13.ums_wert - t16.ums_plan AS delta,
   (t13.ums_wert - t16.ums_plan) / IF(t16.ums_plan = 0, NULL, t16.ums_plan) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   ABT.abt_id,
   HWG.hwg_id,
   SUM(VIS.ums_netto) AS ums_wert
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_2 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT_2 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_2
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  WHERE ABT.abt_id IN (5, 6)
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   HWG.hwg_id,
   ABT.abt_id,
   ZEIT.gj) AS t13
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT1.gj,
   ABT2.abt_id,
   HWG2.hwg_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG2 ON PLAN.owg_id = OWG2.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG2 ON OWG2.hwg_id = HWG2.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT2 ON HWG2.abt_id = ABT2.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT1 ON PLAN.kjmo = ZEIT1.kjmo AND ZEIT1.akt_gj = - 1
  WHERE ABT2.abt_id IN (5, 6)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   HWG2.hwg_id,
   ABT2.abt_id,
   ZEIT1.gj) AS t16 ON t13.mandant_id = t16.mandant_id AND t13.wup_id = t16.wup_id AND t13.wrg_id = t16.wrg_id AND t13.gj
     = t16.gj AND t13.hwg_id = t16.hwg_id
 LEFT JOIN (SELECT PLAN1.mandant_id,
   PLAN1.nb_id,
   PLAN1.wup_id,
   PLAN1.wrg_id,
   ZEIT3.gj,
   ABT3.abt_id,
   HWG3.hwg_id,
   SUM(PLAN1.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN1.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN1
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG3 ON PLAN1.owg_id = OWG3.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG3 ON OWG3.hwg_id = HWG3.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT3 ON HWG3.abt_id = ABT3.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT3 ON PLAN1.kjmo = ZEIT3.kjmo AND ZEIT3.akt_gj = 0
  WHERE ABT3.abt_id IN (5, 6)
  GROUP BY PLAN1.mandant_id,
   PLAN1.nb_id,
   PLAN1.wup_id,
   PLAN1.wrg_id,
   HWG3.hwg_id,
   ABT3.abt_id,
   ZEIT3.gj) AS t19 ON t13.mandant_id = t19.mandant_id AND t13.wup_id = t19.wup_id AND t13.wrg_id = t19.wrg_id AND t19.gj
     = t13.gj + 1 AND t13.hwg_id = t19.hwg_id
UNION ALL
SELECT t23.mandant_id,
 t23.nb_id,
 t23.wup_id,
 t23.wrg_id,
  t23.gj + 1 AS gj,
 10 AS metrik_id,
 3 AS typ_id,
 CAST(t23.abt_id * 1000000 + ABS(t23.hwg_id) * 10000 + ABS(t23.owg_id) AS BIGNUMERIC) AS level_id,
 t23.ums_wert AS wert_vj1,
 CAST(NULL AS BIGNUMERIC) AS wert_vj2,
 pln.ums_plan AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 plngj.ums_plan AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
 t23.ums_wert AS wert_vj,
 pln.ums_plan AS plan_vj,
 plngj.ums_plan AS plan_gj,
  t23.ums_wert - pln.ums_plan AS delta,
   (t23.ums_wert - pln.ums_plan) / IF(pln.ums_plan = 0, NULL, pln.ums_plan) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   ABT.abt_id,
   HWG.hwg_id,
   OWG.owg_id,
   SUM(VIS.ums_netto) AS ums_wert
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_2 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT_2 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_2
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  WHERE ABT.abt_id = 5
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   OWG.owg_id,
   HWG.hwg_id,
   ABT.abt_id,
   ZEIT.gj) AS t23
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT1.gj,
   ABT4.abt_id,
   HWG4.hwg_id,
   OWG4.owg_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG4 ON PLAN.owg_id = OWG4.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG4 ON OWG4.hwg_id = HWG4.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT4 ON HWG4.abt_id = ABT4.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT1 ON PLAN.kjmo = ZEIT1.kjmo AND ZEIT1.akt_gj = - 1
  WHERE ABT4.abt_id IN (5)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   OWG4.owg_id,
   HWG4.hwg_id,
   ABT4.abt_id,
   ZEIT1.gj) AS pln ON t23.mandant_id = pln.mandant_id AND t23.wup_id = pln.wup_id AND t23.wrg_id = pln.wrg_id AND t23.gj
     = pln.gj AND t23.owg_id = pln.owg_id
 LEFT JOIN (SELECT PLAN2.mandant_id,
   PLAN2.nb_id,
   PLAN2.wup_id,
   PLAN2.wrg_id,
   ZEIT4.gj,
   ABT5.abt_id,
   HWG5.hwg_id,
   OWG5.owg_id,
   SUM(PLAN2.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN2.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN2
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG5 ON PLAN2.owg_id = OWG5.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG5 ON OWG5.hwg_id = HWG5.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT5 ON HWG5.abt_id = ABT5.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT4 ON PLAN2.kjmo = ZEIT4.kjmo AND ZEIT4.akt_gj = 0
  WHERE ABT5.abt_id IN (5)
  GROUP BY PLAN2.mandant_id,
   PLAN2.nb_id,
   PLAN2.wup_id,
   PLAN2.wrg_id,
   OWG5.owg_id,
   HWG5.hwg_id,
   ABT5.abt_id,
   ZEIT4.gj) AS plngj ON t23.mandant_id = plngj.mandant_id AND t23.wup_id = plngj.wup_id AND t23.wrg_id = plngj.wrg_id
   AND plngj.gj = t23.gj + 1 AND t23.owg_id = plngj.owg_id
UNION ALL
SELECT VIS.mandant_id,
 VIS.nb_id,
 VIS.wup_id,
 VIS.wrg_id,
  ZEIT.gj + 1 AS gj,
 16 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 SUM(VIS.anz_kunde) AS wert_vj1,
 CAST(NULL AS BIGNUMERIC) AS wert_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
 SUM(VIS.anz_kunde) AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
 INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
 INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP.nb_id
      = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
     WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
     THEN - 1
     ELSE 0
     END > ZEIT.gj + 1
GROUP BY VIS.mandant_id,
 VIS.nb_id,
 VIS.wup_id,
 VIS.wrg_id,
 ZEIT.gj
UNION ALL
SELECT VIS.mandant_id,
 VIS.nb_id,
 VIS.wup_id,
 VIS.wrg_id,
  ZEIT.gj + 1 AS gj,
 18 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 SUM(VIS.ums_netto) AS wert_vj1,
 SUM(VIS.anz_kunde) AS wert_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
  SUM(VIS.ums_netto) / IF(SUM(VIS.anz_kunde) = 0, NULL, SUM(VIS.anz_kunde)) AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
 INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
 INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP.nb_id
      = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
     WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
     THEN - 1
     ELSE 0
     END > ZEIT.gj + 1
GROUP BY VIS.mandant_id,
 VIS.nb_id,
 VIS.wup_id,
 VIS.wrg_id,
 ZEIT.gj
UNION ALL
SELECT t40.mandant_id,
 t40.nb_id,
 t40.wup_id,
 t40.wrg_id,
  t40.gj + 1 AS gj,
 20 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 t40.ums_wert AS wert_vj1,
 t40.std_wert AS wert_vj2,
 t40.ums_plan AS plan_vj1,
 t40.std_plan AS plan_vj2,
 t42.ums_plan AS plan_gj1,
 t42.std_plan AS plan_gj2,
  t40.ums_wert / IF(t40.std_wert = 0, NULL, t40.std_wert) AS wert_vj,
  t40.ums_plan / IF(t40.std_plan = 0, NULL, t40.std_plan) AS plan_vj,
  t42.ums_plan / IF(t42.std_plan = 0, NULL, t42.std_plan) AS plan_gj,
   t40.ums_wert / IF(t40.std_wert = 0, NULL, t40.std_wert) - t40.ums_plan / IF(t40.std_plan = 0, NULL, t40.std_plan) AS
 delta,
   (t40.ums_wert / IF(t40.std_wert = 0, NULL, t40.std_wert) - t40.ums_plan / IF(t40.std_plan = 0, NULL, t40.std_plan)) /
  IF(t40.ums_plan / IF(t40.std_plan = 0, NULL, t40.std_plan) = 0, NULL, t40.ums_plan / IF(t40.std_plan = 0, NULL, t40.std_plan
     )) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto) AS ums_wert,
   SUM(VIS.ums_netto_plan) AS ums_plan,
   SUM(VIS.anz_kunde) AS anz_kunde,
   SUM(VIS.pers_std) AS std_wert,
   SUM(VIS.pers_std_plan) AS std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_2
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS t40
 INNER JOIN (SELECT VIS1.mandant_id,
   VIS1.nb_id,
   VIS1.wup_id,
   VIS1.wrg_id,
   ZEIT1.gj,
   SUM(VIS1.ums_netto_plan) AS ums_plan,
   SUM(VIS1.pers_std_plan) AS std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS1
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT1 ON VIS1.kjmo = ZEIT1.kjmo AND ZEIT1.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP1 ON VIS1.wup_id = WUP1.wup_id AND VIS1.mandant_id = WUP1.mandant_id AND
       WUP1.nb_id = 0 AND WUP1.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP1.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP1.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT1.gj + 1
  GROUP BY VIS1.mandant_id,
   VIS1.nb_id,
   VIS1.wup_id,
   VIS1.wrg_id,
   ZEIT1.gj) AS t42 ON t40.mandant_id = t42.mandant_id AND t40.wup_id = t42.wup_id AND t40.wrg_id = t42.wrg_id AND t42.gj
    = t40.gj + 1
UNION ALL
SELECT t45.mandant_id,
 t45.nb_id,
 t45.wup_id,
 t45.wrg_id,
  t45.gj + 1 AS gj,
 24 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 t45.std_wert AS wert_vj1,
 CAST(NULL AS BIGNUMERIC) AS wert_vj2,
 t45.std_plan AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 t47.std_plan AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
 t45.std_wert AS wert_vj,
 t45.std_plan AS plan_vj,
 t47.std_plan AS plan_gj,
  t45.std_wert - t45.std_plan AS delta,
   (t45.std_wert - t45.std_plan) / IF(t45.std_plan = 0, NULL, t45.std_plan) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto) AS ums_wert,
   SUM(VIS.ums_netto_plan) AS ums_plan,
   SUM(VIS.anz_kunde) AS anz_kunde,
   SUM(VIS.pers_std) AS std_wert,
   SUM(VIS.pers_std_plan) AS std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_2
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS t45
 INNER JOIN (SELECT VIS2.mandant_id,
   VIS2.nb_id,
   VIS2.wup_id,
   VIS2.wrg_id,
   ZEIT1.gj,
   SUM(VIS2.ums_netto_plan) AS ums_plan,
   SUM(VIS2.pers_std_plan) AS std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS2
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT1 ON VIS2.kjmo = ZEIT1.kjmo AND ZEIT1.akt_gj = 0
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP2 ON VIS2.wup_id = WUP2.wup_id AND VIS2.mandant_id = WUP2.mandant_id AND
       WUP2.nb_id = 0 AND WUP2.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP2.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP2.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT1.gj + 1
  GROUP BY VIS2.mandant_id,
   VIS2.nb_id,
   VIS2.wup_id,
   VIS2.wrg_id,
   ZEIT1.gj) AS t47 ON t45.mandant_id = t47.mandant_id AND t45.wup_id = t47.wup_id AND t45.wrg_id = t47.wrg_id AND t47.gj
    = t45.gj + 1
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 jzg.metrik_id,
 0 AS typ_id,
 0 AS level_id,
  CASE
  WHEN jzg.metrik_id = 30
  THEN vis.ums_chk
  WHEN jzg.metrik_id = 32
  THEN vis.anz_artikel
  WHEN jzg.metrik_id = 34
  THEN vis.ums_sco
  WHEN jzg.metrik_id = 36
  THEN vis.kun_sco
  ELSE NULL
  END AS wert_vj1,
  CASE
  WHEN jzg.metrik_id = 30
  THEN vis.kassier_zeit
  WHEN jzg.metrik_id = 32
  THEN vis.scan_zeit
  WHEN jzg.metrik_id = 34
  THEN vis.ums_sco + vis.ums_chk
  WHEN jzg.metrik_id = 36
  THEN vis.kun_sco + vis.kun_chk
  ELSE NULL
  END AS wert_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
   CASE
   WHEN jzg.metrik_id = 30
   THEN vis.ums_chk
   WHEN jzg.metrik_id = 32
   THEN vis.anz_artikel
   WHEN jzg.metrik_id = 34
   THEN vis.ums_sco
   WHEN jzg.metrik_id = 36
   THEN vis.kun_sco
   ELSE NULL
   END / IF(CASE
     WHEN jzg.metrik_id = 30
     THEN vis.kassier_zeit
     WHEN jzg.metrik_id = 32
     THEN vis.scan_zeit
     WHEN jzg.metrik_id = 34
     THEN vis.ums_sco + vis.ums_chk
     WHEN jzg.metrik_id = 36
     THEN vis.kun_sco + vis.kun_chk
     ELSE NULL
     END = 0, NULL, CASE
    WHEN jzg.metrik_id = 30
    THEN vis.kassier_zeit
    WHEN jzg.metrik_id = 32
    THEN vis.scan_zeit
    WHEN jzg.metrik_id = 34
    THEN vis.ums_sco + vis.ums_chk
    WHEN jzg.metrik_id = 36
    THEN vis.kun_sco + vis.kun_chk
    ELSE NULL
    END) AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM (SELECT VTK.mandant_id,
   VTK.nb_id,
   VTK.wup_id,
   VTK.wrg_id,
   ZEIT.gj,
   SUM(CASE
     WHEN KTP.kasse_typ_id = 1
     THEN VTK.umsatz_netto
     ELSE 0
     END) AS ums_chk,
   SUM(CASE
     WHEN KTP.kasse_typ_id IN (8, 9, 10, 11)
     THEN VTK.umsatz_netto
     ELSE 0
     END) AS ums_sco,
   SUM(CASE
     WHEN KTP.kasse_typ_id = 1
     THEN VTK.anz_kunden
     ELSE 0
     END) AS kun_chk,
   SUM(CASE
     WHEN KTP.kasse_typ_id IN (8, 9, 10, 11)
     THEN VTK.anz_kunden
     ELSE 0
     END) AS kun_sco,
   SUM(CASE
     WHEN KTP.kasse_typ_id = 1
     THEN VTK.kassierzeit / 3600
     ELSE 0
     END) AS kassier_zeit,
   SUM(CASE
     WHEN KTP.kasse_typ_id = 1
     THEN VTK.anz_artikel
     ELSE 0
     END) AS anz_artikel,
   SUM(CASE
     WHEN KTP.kasse_typ_id = 1
     THEN VTK.registrierzeit / 60
     ELSE 0
     END) AS scan_zeit
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_kasse_2 AS VTK
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_kasse_typ_per_2 AS KTP ON VTK.mandant_id = KTP.mandant_id AND VTK.wup_id
       = KTP.wup_id AND VTK.dat = KTP.dat AND VTK.kasse_nr = KTP.kasse_nr
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS ZEIT_2 ON VTK.dat = ZEIT.dat AND ZEIT.akt_gj = - 1
  GROUP BY VTK.mandant_id,
   VTK.nb_id,
   VTK.wup_id,
   VTK.wrg_id,
   ZEIT.gj) AS vis
 INNER JOIN (SELECT 30 AS metrik_id
   UNION ALL
   SELECT 32 AS metrik_id
   UNION ALL
   SELECT 34 AS metrik_id
   UNION ALL
   SELECT 36 AS metrik_id) AS jzg ON TRUE
UNION ALL
SELECT t55.mandant_id,
 t55.nb_id,
 t55.wup_id,
 t55.wrg_id,
  t55.gj + 1 AS gj,
 40 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 visabs.abs_netto AS wert_vj1,
 t55.ums_netto AS wert_vj2,
 plnvj.abs_plan AS plan_vj1,
 plnvj.ums_plan AS plan_vj2,
 plngj.abs_plan AS plan_gj1,
 plngj.ums_plan AS plan_gj2,
  visabs.abs_netto / IF(t55.ums_netto = 0, NULL, t55.ums_netto) AS wert_vj,
  plnvj.abs_plan / IF(plnvj.ums_plan = 0, NULL, plnvj.ums_plan) AS plan_vj,
  plngj.abs_plan / IF(plngj.ums_plan = 0, NULL, plngj.ums_plan) AS plan_gj,
   (visabs.abs_netto / IF(t55.ums_netto = 0, NULL, t55.ums_netto) - plnvj.abs_plan / IF(plnvj.ums_plan = 0, NULL, plnvj
      .ums_plan)) * 100 AS delta,
    (visabs.abs_netto / IF(t55.ums_netto = 0, NULL, t55.ums_netto) - plnvj.abs_plan / IF(plnvj.ums_plan = 0, NULL, plnvj
       .ums_plan)) * - 1 / IF(plnvj.abs_plan / IF(plnvj.ums_plan = 0, NULL, plnvj.ums_plan) = 0, NULL, plnvj.abs_plan /
    IF(plnvj.ums_plan = 0, NULL, plnvj.ums_plan)) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto) AS ums_netto
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_2 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT_2 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
  WHERE ABT.abt_id IN (4, 5, 6, 7, 8)
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   ZEIT.gj) AS t55
 LEFT JOIN (SELECT VIS3.mandant_id,
   VIS3.nb_id,
   VIS3.wup_id,
   ZEIT1.gj,
   VIS3.wrg_id,
   SUM(CASE
      WHEN VIS3.mandant_id IN (6) AND VIS3.abschriftart_id = 2 OR VIS3.mandant_id IN (3) AND VIS3.abschriftart_id = 11
         OR VIS3.mandant_id IN (2, 4, 5, 7, 8) AND VIS3.abschriftart_id = 7 OR VIS3.mandant_id IN (2, 5) AND VIS3.abschriftart_id
           = 10 OR VIS3.abschriftart_id = 20 AND VIS3.mandant_id NOT IN (1)
      THEN 1
      ELSE - 1
      END * VIS3.abschrift_netto) AS abs_netto
  FROM kfl_production_dbp_msi_data.vis_tag_abschriften_wg_2 AS VIS3
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG0 ON VIS3.wg_id = WG0.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG6 ON WG0.owg_id = OWG6.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG6 ON OWG6.hwg_id = HWG6.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT6 ON HWG6.abt_id = ABT6.abt_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu_2 AS AAZ ON VIS3.abschriftart_id = AAZ.abschriftart_id
      AND VIS3.mandant_id = AAZ.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu_2 AS ATZ ON AAZ.abschriftart_int_id = ATZ.abschriftart_int_id
    
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT1 ON VIS3.kjmo = ZEIT1.kjmo AND ZEIT1.akt_gj = - 1
  WHERE ATZ.abschriftart_thema_int_id IN (1, 4)
   AND ABT6.abt_id IN (4, 5, 6, 7, 8)
  GROUP BY VIS3.mandant_id,
   VIS3.nb_id,
   VIS3.wup_id,
   ZEIT1.gj,
   VIS3.wrg_id) AS visabs ON t55.mandant_id = visabs.mandant_id AND t55.wup_id = visabs.wup_id AND t55.wrg_id = visabs.wrg_id
     AND t55.gj = visabs.gj
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT5.gj,
   SUM(PLAN.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG7 ON PLAN.owg_id = OWG7.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG7 ON OWG7.hwg_id = HWG7.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT7 ON HWG7.abt_id = ABT7.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT5 ON PLAN.kjmo = ZEIT5.kjmo AND ZEIT5.akt_gj = - 1
  WHERE ABT7.abt_id IN (4, 5, 6, 7, 8)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT5.gj) AS plnvj ON t55.mandant_id = plnvj.mandant_id AND t55.wup_id = plnvj.wup_id AND t55.wrg_id = plnvj.wrg_id
  AND t55.gj = plnvj.gj
 LEFT JOIN (SELECT PLAN3.mandant_id,
   PLAN3.nb_id,
   PLAN3.wup_id,
   PLAN3.wrg_id,
   ZEIT6.gj,
   SUM(PLAN3.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN3.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN3
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG8 ON PLAN3.owg_id = OWG8.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG8 ON OWG8.hwg_id = HWG8.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT8 ON HWG8.abt_id = ABT8.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT6 ON PLAN3.kjmo = ZEIT6.kjmo AND ZEIT6.akt_gj = 0
  WHERE ABT8.abt_id IN (4, 5, 6, 7, 8)
  GROUP BY PLAN3.mandant_id,
   PLAN3.nb_id,
   PLAN3.wup_id,
   PLAN3.wrg_id,
   ZEIT6.gj) AS plngj ON t55.mandant_id = plngj.mandant_id AND t55.wup_id = plngj.wup_id AND t55.wrg_id = plngj.wrg_id
  AND plngj.gj = t55.gj + 1
UNION ALL
SELECT t66.mandant_id,
 t66.nb_id,
 t66.wup_id,
 t66.wrg_id,
  t66.gj + 1 AS gj,
 40 AS metrik_id,
 1 AS typ_id,
 CAST(CASE
   WHEN t66.abt_id = 4
   THEN 9999999
   ELSE t66.abt_id * 1000000
   END AS BIGNUMERIC) AS level_id,
 visabs.abs_netto AS wert_vj1,
 t66.ums_netto AS wert_vj2,
 t72.abs_plan AS plan_vj1,
 t72.ums_plan AS plan_vj2,
 t75.abs_plan AS plan_gj1,
 t75.ums_plan AS plan_gj2,
  visabs.abs_netto / IF(t66.ums_netto = 0, NULL, t66.ums_netto) AS wert_vj,
  t72.abs_plan / IF(t72.ums_plan = 0, NULL, t72.ums_plan) AS plan_vj,
  t75.abs_plan / IF(t75.ums_plan = 0, NULL, t75.ums_plan) AS plan_gj,
   (visabs.abs_netto / IF(t66.ums_netto = 0, NULL, t66.ums_netto) - t72.abs_plan / IF(t72.ums_plan = 0, NULL, t72.ums_plan
      )) * 100 AS delta,
    (visabs.abs_netto / IF(t66.ums_netto = 0, NULL, t66.ums_netto) - t72.abs_plan / IF(t72.ums_plan = 0, NULL, t72.ums_plan
       )) * - 1 / IF(t72.abs_plan / IF(t72.ums_plan = 0, NULL, t72.ums_plan) = 0, NULL, t72.abs_plan / IF(t72.ums_plan =
      0, NULL, t72.ums_plan)) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   ABT.abt_id,
   SUM(VIS.ums_netto) AS ums_netto
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_2 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT_2 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
  WHERE ABT.abt_id IN (4, 5, 6, 7, 8)
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   ABT.abt_id,
   ZEIT.gj) AS t66
 LEFT JOIN (SELECT VIS4.mandant_id,
   VIS4.nb_id,
   VIS4.wup_id,
   ZEIT1.gj,
   VIS4.wrg_id,
   ABT9.abt_id,
   SUM(CASE
      WHEN VIS4.mandant_id IN (6) AND VIS4.abschriftart_id = 2 OR VIS4.mandant_id IN (3) AND VIS4.abschriftart_id = 11
         OR VIS4.mandant_id IN (2, 4, 5, 7, 8) AND VIS4.abschriftart_id = 7 OR VIS4.mandant_id IN (2, 5) AND VIS4.abschriftart_id
           = 10 OR VIS4.abschriftart_id = 20 AND VIS4.mandant_id NOT IN (1)
      THEN 1
      ELSE - 1
      END * VIS4.abschrift_netto) AS abs_netto
  FROM kfl_production_dbp_msi_data.vis_tag_abschriften_wg_2 AS VIS4
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG1 ON VIS4.wg_id = WG1.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG9 ON WG1.owg_id = OWG9.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG9 ON OWG9.hwg_id = HWG9.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT9 ON HWG9.abt_id = ABT9.abt_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu_2 AS AAZ ON VIS4.abschriftart_id = AAZ.abschriftart_id
      AND VIS4.mandant_id = AAZ.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu_2 AS ATZ ON AAZ.abschriftart_int_id = ATZ.abschriftart_int_id
    
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT1 ON VIS4.kjmo = ZEIT1.kjmo AND ZEIT1.akt_gj = - 1
  WHERE ATZ.abschriftart_thema_int_id IN (1, 4)
   AND ABT9.abt_id IN (4, 5, 6, 7, 8)
  GROUP BY VIS4.mandant_id,
   VIS4.nb_id,
   VIS4.wup_id,
   ZEIT1.gj,
   VIS4.wrg_id,
   ABT9.abt_id) AS visabs ON t66.mandant_id = visabs.mandant_id AND t66.wup_id = visabs.wup_id AND t66.wrg_id = visabs.wrg_id
      AND t66.gj = visabs.gj AND t66.abt_id = visabs.abt_id
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT7.gj,
   ABT10.abt_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG10 ON PLAN.owg_id = OWG10.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG10 ON OWG10.hwg_id = HWG10.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT10 ON HWG10.abt_id = ABT10.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT7 ON PLAN.kjmo = ZEIT7.kjmo AND ZEIT7.akt_gj = - 1
  WHERE ABT10.abt_id IN (4, 5, 6, 7, 8)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ABT10.abt_id,
   ZEIT7.gj) AS t72 ON t66.mandant_id = t72.mandant_id AND t66.wup_id = t72.wup_id AND t66.wrg_id = t72.wrg_id AND t66.gj
     = t72.gj AND t66.abt_id = t72.abt_id
 LEFT JOIN (SELECT PLAN4.mandant_id,
   PLAN4.nb_id,
   PLAN4.wup_id,
   PLAN4.wrg_id,
   ZEIT8.gj,
   ABT11.abt_id,
   SUM(PLAN4.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN4.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN4
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG11 ON PLAN4.owg_id = OWG11.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG11 ON OWG11.hwg_id = HWG11.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT11 ON HWG11.abt_id = ABT11.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT8 ON PLAN4.kjmo = ZEIT8.kjmo AND ZEIT8.akt_gj = 0
  WHERE ABT11.abt_id IN (4, 5, 6, 7, 8)
  GROUP BY PLAN4.mandant_id,
   PLAN4.nb_id,
   PLAN4.wup_id,
   PLAN4.wrg_id,
   ABT11.abt_id,
   ZEIT8.gj) AS t75 ON t66.mandant_id = t75.mandant_id AND t66.wup_id = t75.wup_id AND t66.wrg_id = t75.wrg_id AND t75.gj
     = t66.gj + 1 AND t66.abt_id = t75.abt_id
UNION ALL
SELECT t79.mandant_id,
 t79.nb_id,
 t79.wup_id,
 t79.wrg_id,
  t79.gj + 1 AS gj,
 40 AS metrik_id,
 2 AS typ_id,
 CAST(t79.abt_id * 1000000 + ABS(t79.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
 visabs.abs_netto AS wert_vj1,
 t79.ums_netto AS wert_vj2,
 t85.abs_plan AS plan_vj1,
 t85.ums_plan AS plan_vj2,
 t88.abs_plan AS plan_gj1,
 t88.ums_plan AS plan_gj2,
  visabs.abs_netto / IF(t79.ums_netto = 0, NULL, t79.ums_netto) AS wert_vj,
  t85.abs_plan / IF(t85.ums_plan = 0, NULL, t85.ums_plan) AS plan_vj,
  t88.abs_plan / IF(t88.ums_plan = 0, NULL, t88.ums_plan) AS plan_gj,
   (visabs.abs_netto / IF(t79.ums_netto = 0, NULL, t79.ums_netto) - t85.abs_plan / IF(t85.ums_plan = 0, NULL, t85.ums_plan
      )) * 100 AS delta,
    (visabs.abs_netto / IF(t79.ums_netto = 0, NULL, t79.ums_netto) - t85.abs_plan / IF(t85.ums_plan = 0, NULL, t85.ums_plan
       )) * - 1 / IF(t85.abs_plan / IF(t85.ums_plan = 0, NULL, t85.ums_plan) = 0, NULL, t85.abs_plan / IF(t85.ums_plan =
      0, NULL, t85.ums_plan)) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   ABT.abt_id,
   HWG.hwg_id,
   SUM(VIS.ums_netto) AS ums_netto
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_2 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT_2 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
  WHERE ABT.abt_id IN (5, 6)
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   HWG.hwg_id,
   ABT.abt_id,
   ZEIT.gj) AS t79
 LEFT JOIN (SELECT VIS5.mandant_id,
   VIS5.nb_id,
   VIS5.wup_id,
   ZEIT1.gj,
   VIS5.wrg_id,
   ABT12.abt_id,
   HWG12.hwg_id,
   SUM(CASE
      WHEN VIS5.mandant_id IN (6) AND VIS5.abschriftart_id = 2 OR VIS5.mandant_id IN (3) AND VIS5.abschriftart_id = 11
         OR VIS5.mandant_id IN (2, 4, 5, 7, 8) AND VIS5.abschriftart_id = 7 OR VIS5.mandant_id IN (2, 5) AND VIS5.abschriftart_id
           = 10 OR VIS5.abschriftart_id = 20 AND VIS5.mandant_id NOT IN (1)
      THEN 1
      ELSE - 1
      END * VIS5.abschrift_netto) AS abs_netto
  FROM kfl_production_dbp_msi_data.vis_tag_abschriften_wg_2 AS VIS5
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG2 ON VIS5.wg_id = WG2.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG12 ON WG2.owg_id = OWG12.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG12 ON OWG12.hwg_id = HWG12.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT12 ON HWG12.abt_id = ABT12.abt_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu_2 AS AAZ ON VIS5.abschriftart_id = AAZ.abschriftart_id
      AND VIS5.mandant_id = AAZ.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu_2 AS ATZ ON AAZ.abschriftart_int_id = ATZ.abschriftart_int_id
    
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT1 ON VIS5.kjmo = ZEIT1.kjmo AND ZEIT1.akt_gj = - 1
  WHERE ATZ.abschriftart_thema_int_id IN (1, 4)
   AND ABT12.abt_id IN (5, 6)
  GROUP BY VIS5.mandant_id,
   VIS5.nb_id,
   VIS5.wup_id,
   ZEIT1.gj,
   VIS5.wrg_id,
   ABT12.abt_id,
   HWG12.hwg_id) AS visabs ON t79.mandant_id = visabs.mandant_id AND t79.wup_id = visabs.wup_id AND t79.wrg_id = visabs
     .wrg_id AND t79.gj = visabs.gj AND t79.hwg_id = visabs.hwg_id
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT9.gj,
   ABT13.abt_id,
   HWG13.hwg_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG13 ON PLAN.owg_id = OWG13.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG13 ON OWG13.hwg_id = HWG13.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT13 ON HWG13.abt_id = ABT13.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT9 ON PLAN.kjmo = ZEIT9.kjmo AND ZEIT9.akt_gj = - 1
  WHERE ABT13.abt_id IN (5, 6)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   HWG13.hwg_id,
   ABT13.abt_id,
   ZEIT9.gj) AS t85 ON t79.mandant_id = t85.mandant_id AND t79.wup_id = t85.wup_id AND t79.wrg_id = t85.wrg_id AND t79.gj
     = t85.gj AND t79.hwg_id = t85.hwg_id
 LEFT JOIN (SELECT PLAN5.mandant_id,
   PLAN5.nb_id,
   PLAN5.wup_id,
   PLAN5.wrg_id,
   ZEIT10.gj,
   ABT14.abt_id,
   HWG14.hwg_id,
   SUM(PLAN5.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN5.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN5
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG14 ON PLAN5.owg_id = OWG14.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG14 ON OWG14.hwg_id = HWG14.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT14 ON HWG14.abt_id = ABT14.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT10 ON PLAN5.kjmo = ZEIT10.kjmo AND ZEIT10.akt_gj = 0
  WHERE ABT14.abt_id IN (5, 6)
  GROUP BY PLAN5.mandant_id,
   PLAN5.nb_id,
   PLAN5.wup_id,
   PLAN5.wrg_id,
   HWG14.hwg_id,
   ABT14.abt_id,
   ZEIT10.gj) AS t88 ON t79.mandant_id = t88.mandant_id AND t79.wup_id = t88.wup_id AND t79.wrg_id = t88.wrg_id AND t88
    .gj = t79.gj + 1 AND t79.hwg_id = t88.hwg_id
UNION ALL
SELECT t92.mandant_id,
 t92.nb_id,
 t92.wup_id,
 t92.wrg_id,
  t92.gj + 1 AS gj,
 40 AS metrik_id,
 3 AS typ_id,
 CAST(t92.abt_id * 1000000 + ABS(t92.hwg_id) * 10000 + ABS(t92.owg_id) AS BIGNUMERIC) AS level_id,
 visabs.abs_netto AS wert_vj1,
 t92.ums_netto AS wert_vj2,
 t98.abs_plan AS plan_vj1,
 t98.ums_plan AS plan_vj2,
 t101.abs_plan AS plan_gj1,
 t101.ums_plan AS plan_gj2,
  visabs.abs_netto / IF(t92.ums_netto = 0, NULL, t92.ums_netto) AS wert_vj,
  t98.abs_plan / IF(t98.ums_plan = 0, NULL, t98.ums_plan) AS plan_vj,
  t101.abs_plan / IF(t101.ums_plan = 0, NULL, t101.ums_plan) AS plan_gj,
   (visabs.abs_netto / IF(t92.ums_netto = 0, NULL, t92.ums_netto) - t98.abs_plan / IF(t98.ums_plan = 0, NULL, t98.ums_plan
      )) * 100 AS delta,
    (visabs.abs_netto / IF(t92.ums_netto = 0, NULL, t92.ums_netto) - t98.abs_plan / IF(t98.ums_plan = 0, NULL, t98.ums_plan
       )) * - 1 / IF(t98.abs_plan / IF(t98.ums_plan = 0, NULL, t98.ums_plan) = 0, NULL, t98.abs_plan / IF(t98.ums_plan =
      0, NULL, t98.ums_plan)) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   ABT.abt_id,
   HWG.hwg_id,
   OWG.owg_id,
   SUM(VIS.ums_netto) AS ums_netto
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_2 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT_2 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
  WHERE ABT.abt_id IN (5)
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   OWG.owg_id,
   HWG.hwg_id,
   ABT.abt_id,
   ZEIT.gj) AS t92
 LEFT JOIN (SELECT VIS6.mandant_id,
   VIS6.nb_id,
   VIS6.wup_id,
   ZEIT1.gj,
   VIS6.wrg_id,
   ABT15.abt_id,
   HWG15.hwg_id,
   OWG15.owg_id,
   SUM(CASE
      WHEN VIS6.mandant_id IN (6) AND VIS6.abschriftart_id = 2 OR VIS6.mandant_id IN (3) AND VIS6.abschriftart_id = 11
         OR VIS6.mandant_id IN (2, 4, 5, 7, 8) AND VIS6.abschriftart_id = 7 OR VIS6.mandant_id IN (2, 5) AND VIS6.abschriftart_id
           = 10 OR VIS6.abschriftart_id = 20 AND VIS6.mandant_id NOT IN (1)
      THEN 1
      ELSE - 1
      END * VIS6.abschrift_netto) AS abs_netto
  FROM kfl_production_dbp_msi_data.vis_tag_abschriften_wg_2 AS VIS6
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG3 ON VIS6.wg_id = WG3.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG15 ON WG3.owg_id = OWG15.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG15 ON OWG15.hwg_id = HWG15.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT15 ON HWG15.abt_id = ABT15.abt_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu_2 AS AAZ ON VIS6.abschriftart_id = AAZ.abschriftart_id
      AND VIS6.mandant_id = AAZ.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu_2 AS ATZ ON AAZ.abschriftart_int_id = ATZ.abschriftart_int_id
    
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT1 ON VIS6.kjmo = ZEIT1.kjmo AND ZEIT1.akt_gj = - 1
  WHERE ATZ.abschriftart_thema_int_id IN (1, 4)
   AND ABT15.abt_id IN (5)
  GROUP BY VIS6.mandant_id,
   VIS6.nb_id,
   VIS6.wup_id,
   ZEIT1.gj,
   VIS6.wrg_id,
   ABT15.abt_id,
   HWG15.hwg_id,
   OWG15.owg_id) AS visabs ON t92.mandant_id = visabs.mandant_id AND t92.wup_id = visabs.wup_id AND t92.wrg_id = visabs
     .wrg_id AND t92.gj = visabs.gj AND t92.owg_id = visabs.owg_id
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT11.gj,
   ABT16.abt_id,
   HWG16.hwg_id,
   OWG16.owg_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG16 ON PLAN.owg_id = OWG16.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG16 ON OWG16.hwg_id = HWG16.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT16 ON HWG16.abt_id = ABT16.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT11 ON PLAN.kjmo = ZEIT11.kjmo AND ZEIT11.akt_gj = - 1
  WHERE ABT16.abt_id IN (5)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   OWG16.owg_id,
   HWG16.hwg_id,
   ABT16.abt_id,
   ZEIT11.gj) AS t98 ON t92.mandant_id = t98.mandant_id AND t92.wup_id = t98.wup_id AND t92.wrg_id = t98.wrg_id AND t92
    .gj = t98.gj AND t92.owg_id = t98.owg_id
 LEFT JOIN (SELECT PLAN6.mandant_id,
   PLAN6.nb_id,
   PLAN6.wup_id,
   PLAN6.wrg_id,
   ZEIT12.gj,
   ABT17.abt_id,
   HWG17.hwg_id,
   OWG17.owg_id,
   SUM(PLAN6.umsatz_netto_plan) AS ums_plan,
   SUM(PLAN6.abschriften_netto_operativ_plan) AS abs_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN6
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG17 ON PLAN6.owg_id = OWG17.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG17 ON OWG17.hwg_id = HWG17.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT17 ON HWG17.abt_id = ABT17.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT12 ON PLAN6.kjmo = ZEIT12.kjmo AND ZEIT12.akt_gj = 0
  WHERE ABT17.abt_id IN (5)
  GROUP BY PLAN6.mandant_id,
   PLAN6.nb_id,
   PLAN6.wup_id,
   PLAN6.wrg_id,
   OWG17.owg_id,
   HWG17.hwg_id,
   ABT17.abt_id,
   ZEIT12.gj) AS t101 ON t92.mandant_id = t101.mandant_id AND t92.wup_id = t101.wup_id AND t92.wrg_id = t101.wrg_id AND
    t101.gj = t92.gj + 1 AND t92.owg_id = t101.owg_id
UNION ALL
SELECT t104.mandant_id,
 t104.nb_id,
 t104.wup_id,
 t104.wrg_id,
  t104.gj + 1 AS gj,
 46 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 t107.inv_wert AS wert_vj1,
 t107.inv_ums AS wert_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
  t107.inv_wert / IF(t107.inv_ums = 0, NULL, t107.inv_ums) AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto) AS ums_wert,
   SUM(VIS.ums_netto_plan) AS ums_plan,
   SUM(VIS.anz_kunde) AS anz_kunde,
   SUM(VIS.pers_std) AS std_wert,
   SUM(VIS.pers_std_plan) AS std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_2
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS t104
 LEFT JOIN (SELECT VIS_INV.mandant_id,
   VIS_INV.nb_id,
   VIS_INV.wup_id,
   VIS_INV.wrg_id,
   VIS_INV.gj,
   SUM(VIS_INV.inventur_wert_netto) AS inv_wert,
   SUM(VIS_INV.inventur_ums_netto) AS inv_ums
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur_2 AS VIS_INV
   INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT1 ON VIS_INV.dat_plan_zaehlung = ZEIT1.dat AND ZEIT1.akt_gj = - 1
  WHERE VIS_INV.inventurart_int_id IN (8)
  GROUP BY VIS_INV.mandant_id,
   VIS_INV.nb_id,
   VIS_INV.wup_id,
   VIS_INV.gj,
   VIS_INV.wrg_id) AS t107 ON t104.mandant_id = t107.mandant_id AND t104.wup_id = t107.wup_id AND t104.wrg_id = t107.wrg_id
     AND t104.gj = t107.gj
UNION ALL
SELECT t110.mandant_id,
 t110.nb_id,
 t110.wup_id,
 t110.wrg_id,
  t110.gj + 1 AS gj,
 46 AS metrik_id,
 1 AS typ_id,
 CAST(CASE
   WHEN t113.abt_id = 4
   THEN 9999999
   ELSE t113.abt_id * 1000000
   END AS BIGNUMERIC) AS level_id,
 t113.inv_wert AS wert_vj1,
 t113.inv_ums AS wert_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
  t113.inv_wert / IF(t113.inv_ums = 0, NULL, t113.inv_ums) AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto) AS ums_wert,
   SUM(VIS.ums_netto_plan) AS ums_plan,
   SUM(VIS.anz_kunde) AS anz_kunde,
   SUM(VIS.pers_std) AS std_wert,
   SUM(VIS.pers_std_plan) AS std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_2
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS t110
 LEFT JOIN (SELECT VIS_INV.mandant_id,
   VIS_INV.nb_id,
   VIS_INV.wup_id,
   VIS_INV.wrg_id,
   VIS_INV.gj,
   ABT.abt_id,
   SUM(VIS_INV.inventur_wert_netto) AS inv_wert,
   SUM(VIS_INV.inventur_ums_netto) AS inv_ums
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur_2 AS VIS_INV
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG ON VIS_INV.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT_2 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT1 ON VIS_INV.dat_plan_zaehlung = ZEIT1.dat AND ZEIT1.akt_gj = - 1
  WHERE VIS_INV.inventurart_int_id IN (8)
   AND ABT.abt_id IN (4, 5, 6, 7, 8)
  GROUP BY VIS_INV.mandant_id,
   VIS_INV.nb_id,
   VIS_INV.wup_id,
   VIS_INV.gj,
   VIS_INV.wrg_id,
   ABT.abt_id) AS t113 ON t110.mandant_id = t113.mandant_id AND t110.wup_id = t113.wup_id AND t110.wrg_id = t113.wrg_id
  AND t110.gj = t113.gj
UNION ALL
SELECT t116.mandant_id,
 t116.nb_id,
 t116.wup_id,
 t116.wrg_id,
  t116.gj + 1 AS gj,
 50 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
  CASE
  WHEN t121.kc_anzahl > 0
  THEN IFNULL(t126.kc_feststell, 0)
  ELSE NULL
  END AS wert_vj1,
 t121.kc_anzahl AS wert_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
   CASE
   WHEN t121.kc_anzahl > 0
   THEN IFNULL(t126.kc_feststell, 0)
   ELSE NULL
   END / IF(t121.kc_anzahl = 0, NULL, t121.kc_anzahl) AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto) AS ums_wert,
   SUM(VIS.ums_netto_plan) AS ums_plan,
   SUM(VIS.anz_kunde) AS anz_kunde,
   SUM(VIS.pers_std) AS std_wert,
   SUM(VIS.pers_std_plan) AS std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_2
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS t116
 LEFT JOIN (SELECT A15.mandant_id,
   A15.wup_id,
   ZEIT1.gj,
   COUNT(A11.amx_frage_id) AS kc_anzahl
  FROM kfl_production_dbp_msi_view_vis.mv_amx_frage_2 AS A11
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS ZEIT1 ON A11.dat_ende = ZEIT1.dat AND ZEIT1.akt_gj = - 1
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_pruef_kapitel_2 AS A14 ON A11.pruef_kapitel_id = A14.pruef_kapitel_id
    
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_pruefung_2 AS A15 ON A11.dat_ende = A15.dat_ende AND A14.pruefung_id
     = A15.pruefung_id
  WHERE EXISTS (SELECT S21.amx_frage_id,
     S21.kmr_quelle_id
    FROM kfl_production_dbp_msi_view_vis.mv_amx_frage_2 AS S21
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_frage_katalog_2 AS S23 ON S21.amx_frage_katalog_id = S23.amx_frage_katalog_id
        AND S21.kmr_quelle_id = S23.kmr_quelle_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_teilbereich_spr_zu_2 AS S24 ON S23.teilbereich_id = S24.teilbereich_id
      
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_pruef_kapitel_2 AS S25 ON S21.pruef_kapitel_id = S25.pruef_kapitel_id
      
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_pruefung_2 AS S26 ON S21.dat_ende = S26.dat_ende AND S25.pruefung_id
        = S26.pruefung_id
    WHERE S21.antwort_wert IN (0, 1, 4)
     AND S23.hauptbereich_id IN (597230)
     AND S24.invers_kat_id IN (7)
     AND S23.amx_handlung_typ_id IN (1, 50000)
     AND S21.amx_frage_id = A11.amx_frage_id
     AND S21.kmr_quelle_id = A11.kmr_quelle_id
    GROUP BY S21.amx_frage_id,
     S21.kmr_quelle_id)
  GROUP BY ZEIT1.gj,
   A15.mandant_id,
   A15.wup_id) AS t121 ON t116.mandant_id = t121.mandant_id AND t116.wup_id = t121.wup_id AND t116.gj = t121.gj
 LEFT JOIN (SELECT A150.mandant_id,
   A150.wup_id,
   ZEIT13.gj,
   COUNT(A110.amx_frage_id) AS kc_feststell
  FROM kfl_production_dbp_msi_view_vis.mv_amx_frage_2 AS A110
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS ZEIT13 ON A110.dat_ende = ZEIT13.dat AND ZEIT13.akt_gj = - 1
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_pruef_kapitel_2 AS A140 ON A110.pruef_kapitel_id = A140.pruef_kapitel_id
    
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_pruefung_2 AS A150 ON A110.dat_ende = A150.dat_ende AND A140.pruefung_id
      = A150.pruefung_id
  WHERE EXISTS (SELECT S210.amx_frage_id,
     S210.kmr_quelle_id
    FROM kfl_production_dbp_msi_view_vis.mv_amx_frage_2 AS S210
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_frage_katalog_2 AS S230 ON S210.amx_frage_katalog_id = S230.amx_frage_katalog_id
        AND S210.kmr_quelle_id = S230.kmr_quelle_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_teilbereich_spr_zu_2 AS S240 ON S230.teilbereich_id = S240.teilbereich_id
      
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_pruef_kapitel_2 AS S250 ON S210.pruef_kapitel_id = S250.pruef_kapitel_id
      
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_amx_pruefung_2 AS S260 ON S210.dat_ende = S260.dat_ende AND S250.pruefung_id
        = S260.pruefung_id
    WHERE S210.antwort_wert IN (1, 4)
     AND S230.hauptbereich_id IN (597230)
     AND S240.invers_kat_id IN (7)
     AND S230.amx_handlung_typ_id IN (1, 50000)
     AND S210.amx_frage_id = A110.amx_frage_id
     AND S210.kmr_quelle_id = A110.kmr_quelle_id
    GROUP BY S210.amx_frage_id,
     S210.kmr_quelle_id)
  GROUP BY ZEIT13.gj,
   A150.mandant_id,
   A150.wup_id) AS t126 ON t116.mandant_id = t126.mandant_id AND t116.wup_id = t126.wup_id AND t116.gj = t126.gj
UNION ALL
SELECT t129.mandant_id,
 t129.nb_id,
 t129.wup_id,
 t129.wrg_id,
  t129.gj + 1 AS gj,
 jzg.metrik_id,
 0 AS typ_id,
 0 AS level_id,
  CASE
  WHEN jzg.metrik_id IN (54, 55)
  THEN rekl.warten_kasse
  WHEN jzg.metrik_id IN (56, 57)
  THEN rekl.warten_theke
  WHEN jzg.metrik_id IN (58, 59)
  THEN rekl.mangel_mhd
  WHEN jzg.metrik_id IN (60, 61)
  THEN CAST(rekl.fehler_preis AS BIGNUMERIC)
  WHEN jzg.metrik_id IN (62, 63)
  THEN CAST(rekl.fehler_kasse AS BIGNUMERIC)
  ELSE NULL
  END AS wert_vj1,
  CASE
  WHEN jzg.metrik_id IN (55, 57, 59, 61)
  THEN t129.anz_kunde / 10000.00
  WHEN jzg.metrik_id IN (63)
  THEN vtg.art_anz / 100000.00
  ELSE NULL
  END AS wert_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
  CASE
  WHEN jzg.metrik_id IN (54, 56, 58, 60, 62)
  THEN CASE
   WHEN jzg.metrik_id IN (54, 55)
   THEN rekl.warten_kasse
   WHEN jzg.metrik_id IN (56, 57)
   THEN rekl.warten_theke
   WHEN jzg.metrik_id IN (58, 59)
   THEN rekl.mangel_mhd
   WHEN jzg.metrik_id IN (60, 61)
   THEN CAST(rekl.fehler_preis AS BIGNUMERIC)
   WHEN jzg.metrik_id IN (62, 63)
   THEN CAST(rekl.fehler_kasse AS BIGNUMERIC)
   ELSE NULL
   END
  WHEN jzg.metrik_id IN (55, 57, 59, 61, 63)
  THEN CASE
    WHEN jzg.metrik_id IN (54, 55)
    THEN rekl.warten_kasse
    WHEN jzg.metrik_id IN (56, 57)
    THEN rekl.warten_theke
    WHEN jzg.metrik_id IN (58, 59)
    THEN rekl.mangel_mhd
    WHEN jzg.metrik_id IN (60, 61)
    THEN CAST(rekl.fehler_preis AS BIGNUMERIC)
    WHEN jzg.metrik_id IN (62, 63)
    THEN CAST(rekl.fehler_kasse AS BIGNUMERIC)
    ELSE NULL
    END / IF(CASE
      WHEN jzg.metrik_id IN (55, 57, 59, 61)
      THEN t129.anz_kunde / 10000.00
      WHEN jzg.metrik_id IN (63)
      THEN vtg.art_anz / 100000.00
      ELSE NULL
      END = 0, NULL, CASE
     WHEN jzg.metrik_id IN (55, 57, 59, 61)
     THEN t129.anz_kunde / 10000.00
     WHEN jzg.metrik_id IN (63)
     THEN vtg.art_anz / 100000.00
     ELSE NULL
     END)
  ELSE NULL
  END AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto) AS ums_wert,
   SUM(VIS.ums_netto_plan) AS ums_plan,
   SUM(VIS.anz_kunde) AS anz_kunde,
   SUM(VIS.pers_std) AS std_wert,
   SUM(VIS.pers_std_plan) AS std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_2
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS t129
 LEFT JOIN (SELECT REKL.mandant_id,
   REKL.nb_id,
   REKL.wup_id,
   REKL.wrg_id,
   ZEIT1.gj,
   SUM(CASE
     WHEN REKL.reklamationsgrund_id IN (12, 19)
     THEN 1
     ELSE 0
     END) AS fehler_preis,
   SUM(CASE
     WHEN REKL.reklamationsgrund_id IN (13, 14)
     THEN 1
     ELSE 0
     END) AS fehler_kasse,
   SUM(CASE
     WHEN REKL.reklamationsgrund_id = 91
     THEN REKL.vk_menge_kuga
     ELSE NULL
     END) AS warten_theke,
   SUM(CASE
     WHEN REKL.reklamationsgrund_id = 92
     THEN REKL.vk_menge_kuga
     ELSE NULL
     END) AS warten_kasse,
   SUM(CASE
     WHEN REKL.reklamationsgrund_id = 93 AND REKL.mandant_id <> 6
     THEN REKL.vk_menge_kuga
     ELSE NULL
     END) AS mangel_mhd
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art_2 AS REKL_2
   INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT1 ON REKL.dat = ZEIT1.dat AND ZEIT1.akt_gj = - 1
  WHERE REKL.reklamationsgrund_id IN (12, 13, 14, 19, 91, 92, 93)
   AND (REKL.mandant_id, REKL.art_id) IN (SELECT (mandant_id, art_id)
     FROM kfl_production_dbp_msi_view_vis.mv_art_wg_zu_2
     WHERE wg_id NOT IN (980))
  GROUP BY REKL.mandant_id,
   REKL.nb_id,
   REKL.wup_id,
   REKL.wrg_id,
   ZEIT1.gj) AS rekl_2 ON t129.mandant_id = rekl.mandant_id AND t129.wup_id = rekl.wup_id AND t129.wrg_id = rekl.wrg_id
  AND t129.gj = rekl.gj
 LEFT JOIN (SELECT VIS7.mandant_id,
   VIS7.nb_id,
   VIS7.wup_id,
   VIS7.wrg_id,
   ZEIT15.gj,
   SUM(CASE
     WHEN KTP.kasse_typ_id IN (1)
     THEN VIS7.anz_artikel
     ELSE NULL
     END) AS art_anz
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_kasse_2 AS VIS7
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_kasse_typ_per_2 AS KTP ON VIS7.mandant_id = KTP.mandant_id AND VIS7.wup_id
        = KTP.wup_id AND VIS7.dat = KTP.dat AND VIS7.kasse_nr = KTP.kasse_nr
   INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT14 ON VIS7.dat = ZEIT14.dat
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT15 ON ZEIT14.kjmo = ZEIT15.kjmo AND ZEIT15.akt_gj IN (- 1)
  WHERE KTP.kasse_typ_id IN (1, 8, 9, 10, 11)
  GROUP BY VIS7.mandant_id,
   VIS7.nb_id,
   VIS7.wup_id,
   VIS7.wrg_id,
   ZEIT15.gj) AS vtg ON t129.mandant_id = vtg.mandant_id AND t129.wup_id = vtg.wup_id AND t129.wrg_id = vtg.wrg_id AND
   t129.gj = vtg.gj
 INNER JOIN (SELECT 54 AS metrik_id
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
   SELECT 63 AS metrik_id) AS jzg ON TRUE
UNION ALL
SELECT VISU.mandant_id,
 VISU.nb_id,
 VISU.wup_id,
 VISU.wrg_id,
  ZEIT.gj + 1 AS gj,
 76 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
   SUM(VISU.tage_urlaub_anspruch_akt_kj) + SUM(VISU.tage_urlaub_rest_vj_kj) - (SUM(VISU.tage_urlaub_abgeltung_kj_kum) +
    SUM(VISU.tage_urlaub_genommen_kj_kum)) AS wert_vgj1,
 SUM(VISU.tage_urlaub_anspruch_akt_kj) AS wert_vgj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
   (SUM(VISU.tage_urlaub_anspruch_akt_kj) + SUM(VISU.tage_urlaub_rest_vj_kj) - (SUM(VISU.tage_urlaub_abgeltung_kj_kum) +
      SUM(VISU.tage_urlaub_genommen_kj_kum))) / IF(SUM(VISU.tage_urlaub_anspruch_akt_kj) = 0, NULL, SUM(VISU.tage_urlaub_anspruch_akt_kj
    )) AS wert_vgj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_shr_wup_urlaub_2 AS VISU
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_monat_2 AS ZEIT_2 ON VISU.kjmo = ZEIT.kjmo
WHERE ZEIT.mo_kj = 12
 AND ZEIT.akt_gj = - 1
 AND VISU.nb_id = 0
GROUP BY VISU.mandant_id,
 VISU.nb_id,
 VISU.wrg_id,
 VISU.wup_id,
 ZEIT.gj
UNION ALL
SELECT t145.mandant_id,
 t145.nb_id,
 t145.wup_id,
 t145.wrg_id,
  t145.gj + 1 AS gj,
 jzg.metrik_id,
 0 AS typ_id,
 0 AS level_id,
  CASE
  WHEN jzg.metrik_id = 70
  THEN t145.pk_wert
  WHEN jzg.metrik_id = 72
  THEN shr.std_spaet
  WHEN jzg.metrik_id = 73
  THEN shr.std_wende
  WHEN jzg.metrik_id = 74
  THEN shr.std_ftag
  WHEN jzg.metrik_id = 75
  THEN shr.std_mehr
  WHEN jzg.metrik_id = 77
  THEN shr.krank
  WHEN jzg.metrik_id = 78
  THEN shr.austr_roll
  WHEN jzg.metrik_id = 80
  THEN shr.kopf_ges
  WHEN jzg.metrik_id = 81
  THEN shr.kopf_ma
  WHEN jzg.metrik_id = 82
  THEN shr.vzk_ma
  WHEN jzg.metrik_id IN (84, 86)
  THEN shr.std_vtg
  WHEN jzg.metrik_id = 88
  THEN shr.tzk_ma
  ELSE NULL
  END AS wert_vj1,
  CASE
  WHEN jzg.metrik_id = 70
  THEN CAST(t145.ums_wert AS FLOAT64)
  WHEN jzg.metrik_id IN (72, 73, 74, 75)
  THEN CAST(t145.std_wert AS FLOAT64)
  WHEN jzg.metrik_id = 77
  THEN CAST(shr.soll AS FLOAT64)
  WHEN jzg.metrik_id = 78
  THEN shr.kopf_roll
  WHEN jzg.metrik_id IN (80, 81, 82, 84)
  THEN 1.00
  WHEN jzg.metrik_id IN (86, 88)
  THEN CAST(shr.kopf_ma AS FLOAT64)
  ELSE NULL
  END AS wert_vj2,
  CASE
  WHEN jzg.metrik_id = 70
  THEN t145.pk_plan
  ELSE NULL
  END AS plan_vj1,
  CASE
  WHEN jzg.metrik_id = 70
  THEN t145.ums_plan
  ELSE NULL
  END AS plan_vj2,
  CASE
  WHEN jzg.metrik_id = 70
  THEN t147.pk_plan
  ELSE NULL
  END AS plan_gj1,
  CASE
  WHEN jzg.metrik_id = 70
  THEN t147.ums_plan
  ELSE NULL
  END AS plan_gj2,
   CASE
   WHEN jzg.metrik_id = 70
   THEN t145.pk_wert
   WHEN jzg.metrik_id = 72
   THEN shr.std_spaet
   WHEN jzg.metrik_id = 73
   THEN shr.std_wende
   WHEN jzg.metrik_id = 74
   THEN shr.std_ftag
   WHEN jzg.metrik_id = 75
   THEN shr.std_mehr
   WHEN jzg.metrik_id = 77
   THEN shr.krank
   WHEN jzg.metrik_id = 78
   THEN shr.austr_roll
   WHEN jzg.metrik_id = 80
   THEN shr.kopf_ges
   WHEN jzg.metrik_id = 81
   THEN shr.kopf_ma
   WHEN jzg.metrik_id = 82
   THEN shr.vzk_ma
   WHEN jzg.metrik_id IN (84, 86)
   THEN shr.std_vtg
   WHEN jzg.metrik_id = 88
   THEN shr.tzk_ma
   ELSE NULL
   END / IF(CASE
     WHEN jzg.metrik_id = 70
     THEN CAST(t145.ums_wert AS FLOAT64)
     WHEN jzg.metrik_id IN (72, 73, 74, 75)
     THEN CAST(t145.std_wert AS FLOAT64)
     WHEN jzg.metrik_id = 77
     THEN CAST(shr.soll AS FLOAT64)
     WHEN jzg.metrik_id = 78
     THEN shr.kopf_roll
     WHEN jzg.metrik_id IN (80, 81, 82, 84)
     THEN 1.00
     WHEN jzg.metrik_id IN (86, 88)
     THEN CAST(shr.kopf_ma AS FLOAT64)
     ELSE NULL
     END = 0, NULL, CASE
    WHEN jzg.metrik_id = 70
    THEN CAST(t145.ums_wert AS FLOAT64)
    WHEN jzg.metrik_id IN (72, 73, 74, 75)
    THEN CAST(t145.std_wert AS FLOAT64)
    WHEN jzg.metrik_id = 77
    THEN CAST(shr.soll AS FLOAT64)
    WHEN jzg.metrik_id = 78
    THEN shr.kopf_roll
    WHEN jzg.metrik_id IN (80, 81, 82, 84)
    THEN 1.00
    WHEN jzg.metrik_id IN (86, 88)
    THEN CAST(shr.kopf_ma AS FLOAT64)
    ELSE NULL
    END) AS wert_vj,
   CASE
   WHEN jzg.metrik_id = 70
   THEN t145.pk_plan
   ELSE NULL
   END / IF(CASE
     WHEN jzg.metrik_id = 70
     THEN t145.ums_plan
     ELSE NULL
     END = 0, NULL, CASE
    WHEN jzg.metrik_id = 70
    THEN t145.ums_plan
    ELSE NULL
    END) AS plan_vj,
   CASE
   WHEN jzg.metrik_id = 70
   THEN t147.pk_plan
   ELSE NULL
   END / IF(CASE
     WHEN jzg.metrik_id = 70
     THEN t147.ums_plan
     ELSE NULL
     END = 0, NULL, CASE
    WHEN jzg.metrik_id = 70
    THEN t147.ums_plan
    ELSE NULL
    END) AS plan_gj,
  IF(CASE
      WHEN jzg.metrik_id = 70
      THEN t145.pk_wert
      WHEN jzg.metrik_id = 72
      THEN shr.std_spaet
      WHEN jzg.metrik_id = 73
      THEN shr.std_wende
      WHEN jzg.metrik_id = 74
      THEN shr.std_ftag
      WHEN jzg.metrik_id = 75
      THEN shr.std_mehr
      WHEN jzg.metrik_id = 77
      THEN shr.krank
      WHEN jzg.metrik_id = 78
      THEN shr.austr_roll
      WHEN jzg.metrik_id = 80
      THEN shr.kopf_ges
      WHEN jzg.metrik_id = 81
      THEN shr.kopf_ma
      WHEN jzg.metrik_id = 82
      THEN shr.vzk_ma
      WHEN jzg.metrik_id IN (84, 86)
      THEN shr.std_vtg
      WHEN jzg.metrik_id = 88
      THEN shr.tzk_ma
      ELSE NULL
      END / IF(CASE
        WHEN jzg.metrik_id = 70
        THEN CAST(t145.ums_wert AS FLOAT64)
        WHEN jzg.metrik_id IN (72, 73, 74, 75)
        THEN CAST(t145.std_wert AS FLOAT64)
        WHEN jzg.metrik_id = 77
        THEN CAST(shr.soll AS FLOAT64)
        WHEN jzg.metrik_id = 78
        THEN shr.kopf_roll
        WHEN jzg.metrik_id IN (80, 81, 82, 84)
        THEN 1.00
        WHEN jzg.metrik_id IN (86, 88)
        THEN CAST(shr.kopf_ma AS FLOAT64)
        ELSE NULL
        END = 0, NULL, CASE
       WHEN jzg.metrik_id = 70
       THEN CAST(t145.ums_wert AS FLOAT64)
       WHEN jzg.metrik_id IN (72, 73, 74, 75)
       THEN CAST(t145.std_wert AS FLOAT64)
       WHEN jzg.metrik_id = 77
       THEN CAST(shr.soll AS FLOAT64)
       WHEN jzg.metrik_id = 78
       THEN shr.kopf_roll
       WHEN jzg.metrik_id IN (80, 81, 82, 84)
       THEN 1.00
       WHEN jzg.metrik_id IN (86, 88)
       THEN CAST(shr.kopf_ma AS FLOAT64)
       ELSE NULL
       END) = 0, NULL, CASE
     WHEN jzg.metrik_id = 70
     THEN t145.pk_wert
     WHEN jzg.metrik_id = 72
     THEN shr.std_spaet
     WHEN jzg.metrik_id = 73
     THEN shr.std_wende
     WHEN jzg.metrik_id = 74
     THEN shr.std_ftag
     WHEN jzg.metrik_id = 75
     THEN shr.std_mehr
     WHEN jzg.metrik_id = 77
     THEN shr.krank
     WHEN jzg.metrik_id = 78
     THEN shr.austr_roll
     WHEN jzg.metrik_id = 80
     THEN shr.kopf_ges
     WHEN jzg.metrik_id = 81
     THEN shr.kopf_ma
     WHEN jzg.metrik_id = 82
     THEN shr.vzk_ma
     WHEN jzg.metrik_id IN (84, 86)
     THEN shr.std_vtg
     WHEN jzg.metrik_id = 88
     THEN shr.tzk_ma
     ELSE NULL
     END / IF(CASE
       WHEN jzg.metrik_id = 70
       THEN CAST(t145.ums_wert AS FLOAT64)
       WHEN jzg.metrik_id IN (72, 73, 74, 75)
       THEN CAST(t145.std_wert AS FLOAT64)
       WHEN jzg.metrik_id = 77
       THEN CAST(shr.soll AS FLOAT64)
       WHEN jzg.metrik_id = 78
       THEN shr.kopf_roll
       WHEN jzg.metrik_id IN (80, 81, 82, 84)
       THEN 1.00
       WHEN jzg.metrik_id IN (86, 88)
       THEN CAST(shr.kopf_ma AS FLOAT64)
       ELSE NULL
       END = 0, NULL, CASE
      WHEN jzg.metrik_id = 70
      THEN CAST(t145.ums_wert AS FLOAT64)
      WHEN jzg.metrik_id IN (72, 73, 74, 75)
      THEN CAST(t145.std_wert AS FLOAT64)
      WHEN jzg.metrik_id = 77
      THEN CAST(shr.soll AS FLOAT64)
      WHEN jzg.metrik_id = 78
      THEN shr.kopf_roll
      WHEN jzg.metrik_id IN (80, 81, 82, 84)
      THEN 1.00
      WHEN jzg.metrik_id IN (86, 88)
      THEN CAST(shr.kopf_ma AS FLOAT64)
      ELSE NULL
      END)) - IF(CASE
      WHEN jzg.metrik_id = 70
      THEN t145.pk_plan
      ELSE NULL
      END / IF(CASE
        WHEN jzg.metrik_id = 70
        THEN t145.ums_plan
        ELSE NULL
        END = 0, NULL, CASE
       WHEN jzg.metrik_id = 70
       THEN t145.ums_plan
       ELSE NULL
       END) = 0, NULL, CASE
     WHEN jzg.metrik_id = 70
     THEN t145.pk_plan
     ELSE NULL
     END / IF(CASE
       WHEN jzg.metrik_id = 70
       THEN t145.ums_plan
       ELSE NULL
       END = 0, NULL, CASE
      WHEN jzg.metrik_id = 70
      THEN t145.ums_plan
      ELSE NULL
      END)) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto) AS ums_wert,
   SUM(VIS.ums_netto_plan) AS ums_plan,
   SUM(VIS.anz_kunde) AS anz_kunde,
   SUM(VIS.pers_std) AS std_wert,
   SUM(VIS.pers_std_plan) AS std_plan,
   SUM(VIS.pers_kosten) AS pk_wert,
   SUM(VIS.pers_kosten_plan) AS pk_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id AND WUP_2
       .nb_id = 0 AND WUP.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT.gj + 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS t145
 INNER JOIN (SELECT VIS8.mandant_id,
   VIS8.nb_id,
   VIS8.wup_id,
   VIS8.wrg_id,
   ZEIT1.gj,
   SUM(VIS8.ums_netto_plan) AS ums_plan,
   SUM(VIS8.pers_std_plan) AS std_plan,
   SUM(VIS8.pers_kosten) AS pk_wert,
   SUM(VIS8.pers_kosten_plan) AS pk_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS8
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT1 ON VIS8.kjmo = ZEIT1.kjmo AND ZEIT1.akt_gj = 0
  GROUP BY VIS8.mandant_id,
   VIS8.nb_id,
   VIS8.wup_id,
   VIS8.wrg_id,
   ZEIT1.gj) AS t147 ON t145.mandant_id = t147.mandant_id AND t145.wup_id = t147.wup_id AND t145.wrg_id = t147.wrg_id
  AND t147.gj = t145.gj + 1
 LEFT JOIN (SELECT VIS_SHR.mandant_id,
   VIS_SHR.nb_id,
   VIS_SHR.wup_id,
   VIS_SHR.wrg_id,
   ZEIT16.gj,
   SUM(VIS_SHR.stunden_zuschlag_feiertag) AS std_ftag,
   SUM(VIS_SHR.stunden_zuschlag_mehr) AS std_mehr,
   SUM(VIS_SHR.stunden_zuschlag_spaet_nacht) AS std_spaet,
   SUM(VIS_SHR.stunden_zuschlag_wochenende) AS std_wende,
   SUM(VIS_SHR.tage_krank) AS krank,
   SUM(VIS_SHR.tage_arbeit_soll) AS soll,
   SUM(CASE
     WHEN ZEIT16.mo_kj = 2
     THEN VIS_SHR.kopf_austritte_rol
     ELSE 0
     END) AS austr_roll,
   SUM(CASE
     WHEN ZEIT16.mo_kj = 2
     THEN VIS_SHR.kopf_fluktuation_rol
     ELSE 0
     END) AS kopf_roll,
   SUM(CASE
     WHEN ZEIT16.mo_kj = 2
     THEN VIS_SHR.kopf_filiale
     ELSE 0
     END) AS kopf_ges,
   SUM(CASE
     WHEN ZEIT16.mo_kj = 2
     THEN VIS_SHR.kopf_ma
     ELSE 0
     END) AS kopf_ma,
   SUM(CASE
     WHEN ZEIT16.mo_kj = 2
     THEN VIS_SHR.stunden_vertrag_ma
     ELSE 0
     END) AS std_vtg,
   SUM(CASE
     WHEN ZEIT16.mo_kj = 2
     THEN VIS_SHR.vzk_ma
     ELSE 0
     END) AS vzk_ma,
   SUM(CASE
     WHEN ZEIT16.mo_kj = 2
     THEN VIS_SHR.kopf_teilzeit
     ELSE 0
     END) AS tzk_ma
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_shr_wup_2 AS VIS_SHR
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_monat_2 AS ZEIT16 ON VIS_SHR.kjmo = ZEIT16.kjmo AND ZEIT16.akt_gj = - 1
   INNER JOIN kfl_production_dbp_data.wup_2 AS WUP3 ON VIS_SHR.wup_id = WUP3.wup_id AND VIS_SHR.mandant_id = WUP3.mandant_id
         AND WUP3.nb_id = 0 AND WUP3.dat_eroeffnung < DATE '2090-12-31' AND EXTRACT(YEAR FROM WUP3.dat_bis) + CASE
       WHEN EXTRACT(MONTH FROM WUP3.dat_bis) < 3
       THEN - 1
       ELSE 0
       END > ZEIT16.gj + 1
  GROUP BY VIS_SHR.mandant_id,
   VIS_SHR.nb_id,
   VIS_SHR.wup_id,
   VIS_SHR.wrg_id,
   ZEIT16.gj) AS shr ON t145.mandant_id = shr.mandant_id AND t145.wup_id = shr.wup_id AND t145.wrg_id = shr.wrg_id AND
   t145.gj = shr.gj
 INNER JOIN (SELECT 70 AS metrik_id
   UNION ALL
   SELECT 72 AS metrik_id
   UNION ALL
   SELECT 73 AS metrik_id
   UNION ALL
   SELECT 74 AS metrik_id
   UNION ALL
   SELECT 75 AS metrik_id
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
   SELECT 88 AS metrik_id
   UNION ALL
   SELECT 91 AS metrik_id
   UNION ALL
   SELECT 92 AS metrik_id
   UNION ALL
   SELECT 93 AS metrik_id
   UNION ALL
   SELECT 94 AS metrik_id
   UNION ALL
   SELECT 95 AS metrik_id) AS jzg ON TRUE;