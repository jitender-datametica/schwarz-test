
/* nur auf Ebene Eingabe */ /* JZG HWG - Plan inkl. Eingabe */ /* Eingabe Abschriften_1 OWG */ /* berechnet Umsatz */
/* ABTEILUNG - Abteilung 5 CROSS JOIN Level OWG */ /* JZG Filiale - MAIN */ /* berechnet Abschriften_1 */
/* 40 Abschriften_1 Abteilung */ /* Plan Ware */ /* 10 Kunde */ /* Umsatz Plan Filiale Gesamt */ /* 503 Inventur_1 Abt_1 */
/* 10 Umsatz Filiale */ /* JZG OWG - Plan VJ */ /* berechnet Umsatz */ /* 100 Umsatz Filiale */ /* Plan Ware */
/* berechnet Abschriften_1 */ /* Eingabe Umsatz Filiale */ /* Eingabe OWG Level */ /* kein Plan */ /* Plan Filiale */
/* JZG Filiale - MAIN */ /* 10 Umsatz Filiale */ /* 40 Abschriften_1 OWG */ /* berechnet Umsatz */
/* ABTEILUNG - Abteilung 6 Grouping */ /* JZG OWG - Abschriften_1 Plan inkl. Eingabe */ /* JZG Filiale - PK */
/* Eingabe = Ebene Filiale */ /* Basis = Plan Filiale */ /* Abteilung 7,8,4 */ /* ABTEILUNG - Abteilung 5 Grouping */
/* 10 Umsatz Filiale */ /* Abteilung 6 HWG */ /* Eingabe Abschriften_1 ABT_1 */ /* 40 Abschriften_1 OWG */
/* HWG - Abteilung 5 Grouping */ /* Eingabe Umsatz Filiale */ /* Ziel = Eingabe Stunden_1 Filiale */
/* Umsatz Plan Filiale */ /* 503 Inventur_1 HWG */ /* Eingabe Abschriften_1 HWG */ /* 13 Kunde */ /* JZG Abteilung - Ware */
/* Plan Ware */ /* JZG Filiale */ /* kein Plan */ /* Eingabe Kunden Filiale */ /* Umsatz Plan Filiale */
/* Umsatz Plan Filiale */ /* 503 Inventur_1 Filiale */ /* berechnet Abschriften_1 */ /* nur auf Ebene Eingabe */
/* 10 Umsatz Filiale */ /* JZG Filiale - MAIN */ /* 10 Umsatz Filiale */ /* nur auf Ebene Eingabe */
/* Abteilung 5 CROSS JOIN Level OWG */ /* 10 Umsatz */ /* 10 Umsatz */ /* Eingabe Umsatz Filiale */
/* JZG HWG - Plan Filiale */ /* JZG 100-0 - Umsatz Filiale */ /* INAKTIV */ /* kein Plan */
/* ABTEILUNG - Abteilung 6 CROSS JOIN Level HWG */ /* ZIEL = Eingabe */ /* Eingabe = Ebene Filiale */
/* berechnet Abschriften_1 */ /* Eingabe Umsatz Filiale */ /* nur auf Ebene Eingabe */ /* 10 Umsatz */ /* Plan Filiale */
/* Eingabe Inventur_1 Prozent */ /* ABTEILUNG - Abteilung 7,8,4 inkl Eingabe */ /* Eingabe = Ebene Filiale */
/* 10 Umsatz */ /* JZG Filiale - Plan/Eingabe */ /* nur auf Ebene Eingabe */
/* JZG Inventur_1 - Berechnung Abteilung Ultra Frische */ /* Basis = Plan Filiale */ /* Plan Ware */ /* Plan Ware */
/* 23 Stunden_1 */ /* JZG Abteilung - Umsatz Ware */ /* JZG Abteilung - Plan Filiale */ /* JZG HWG - Ware */
/* JZG Inventur_1 - Eingabe Abteilung Food Frische */ /* JZG Filiale - MAIN */ /* 503 Inventur_1 OWG */ /* ZIEL = Eingabe */
/* Eingabe Stunden_1 Filiale */ /* JZG OWG - Plan Filiale */ /* Ziel berechnet */ /* 40 Abschriften_1 HWG */
/* HWG - Abteilung 5 CROSS JOIN Level OWG */ /* Plan Ware */ /* berechnet Umsatz */ /* Eingabe Umsatz Filiale */
/* Plan Ware */ /* JZG HWG - Plan VJ */ /* nur auf Ebene Eingabe */ /* Plan Ware */ /* Eingabe PK Prozent */
/* 23 Stunden_1 */ /* 503 Inventur_1 OWG */ /* 503 Inventur_1 OWG */ /* Umsatz Plan Filiale */ /* nur auf Ebene Eingabe */
/* JZG Abteilung - Plan VJ */ /* JZG Filiale - MAIN */ /* ZIEL Umsatz berechnet */ /* JZG HWG - Umsatz Ware */
/* 10 Umsatz */ /* JZG OWG - Ware */ /* JZG Abteilung - Plan/Eingabe */ /* Eingabe Umsatz Filiale */
/* Ziel berechnet */ /* ZIEL Inventur_1 berechnet */ /* 40 Abschriften_1 HWG */ /* Kunden */ /* JZG Dummies */
/* JZG Filiale - MAIN */ /*  */ /* Filiale - Abteilung 5 > CROSS JOIN Level OWG */
/* Berechnung auf 3 Leveln - OWG, HWG, Abteilung */ /* nur auf Ebene Eingabe */ /* 70 Personalkosten_1 */
/* Plan Filiale */ /* Abteilung 5 OWG */
/* FAKT DENORM JZG - Jahreszielgespräch Plan / Eingabe / Ziel
   2023-02-15 ssch0611 : Setup inkl. Dummies. AP0144461
   2023-02-24 ssch0611 : Finetuning & Bugfix. 
   2023-03-01 ssch0611 : Inventur_1 Berechnung. */
/* INAKTIV */ /* Eingabe Abschriften_1 HWG */ /* Umsatz Plan Filiale */ /* keine Eingabe Filiale */
/* Umsatz Plan Filiale */ /* JZG OWG - Umsatz Ware */ /* Umsatz Plan Filiale */ /* nur auf Ebene Eingabe */
/* JZG Inventur_1 - Eingabe Filiale */ /* Plan Filiale */ /* JZG Filiale - MAIN */ /* 10 Umsatz */ /* Plan Filiale */
/* Ziel berechnet */ /* BERECHNET */ /* BERECHNET */ /* Basis = Plan Filiale */
/* HWG - Abteilung 6 CROSS JOIN Level HWG = Eingabe */ /* Umsatz Plan Filiale */
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jzg_data_plan_1 (mandant_id, nb_id, wup_id, wrg_id, gj,
metrik_id, typ_id, level_id, plan_gj1, plan_gj2, plan_gj, eingabe, anteil, ziel1, ziel2, ziel, kommentar) AS SELECT vis
 .mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 10 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 vis.ums_netto_plan AS plan_gj1,
 1.00 AS plan_gj2,
 vis.ums_netto_plan AS plan_gj,
 JZG10.wert_eingabe AS eingabe,
 1 AS anteil,
 JZG10.wert_eingabe AS ziel1,
 1.00 AS ziel2,
 COALESCE(JZG10.wert_eingabe, 0) AS ziel,
 COALESCE(JZG10.kommentar_eingabe, '') AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_netto_plan,
   SUM(VIS.pers_std_plan) AS pers_std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0 /* JZG 101-x000000 - Umsatz Abteilung */
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 10 AS metrik_id,
 1 AS typ_id,
 CAST(CASE
   WHEN vis.abt_id = 4
   THEN 9999999
   ELSE vis.abt_id * 1000000
   END AS BIGNUMERIC) AS level_id,
 plan.ums_netto_plan AS plan_gj1,
 1.00 AS plan_gj2,
 plan.ums_netto_plan AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS eingabe,
  plan.ums_netto_plan / IF(fil.ums_netto_plan = 0, NULL, fil.ums_netto_plan) AS anteil,
  JZG10.wert_eingabe * (plan.ums_netto_plan / IF(fil.ums_netto_plan = 0, NULL, fil.ums_netto_plan)) AS ziel1,
 1.00 AS ziel2,
 COALESCE(JZG10.wert_eingabe * (plan.ums_netto_plan / IF(fil.ums_netto_plan = 0, NULL, fil.ums_netto_plan)), 0) AS ziel
 ,
 '' AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   ABT.abt_id,
   SUM(VIS.ums_netto) AS ums_netto
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_1 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_1 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   ABT.abt_id,
   ZEIT.gj) AS vis
 INNER JOIN (SELECT VIS0.mandant_id,
   VIS0.nb_id,
   VIS0.wup_id,
   VIS0.wrg_id,
   ZEIT0.gj,
   SUM(VIS0.ums_netto_plan) AS ums_netto_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS0
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT0 ON VIS0.kjmo = ZEIT0.kjmo AND ZEIT0.akt_gj = 0
  GROUP BY VIS0.mandant_id,
   VIS0.nb_id,
   VIS0.wup_id,
   VIS0.wrg_id,
   ZEIT0.gj) AS fil ON vis.mandant_id = fil.mandant_id AND vis.wup_id = fil.wup_id AND vis.wrg_id = fil.wrg_id AND vis.gj
    = fil.gj
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT1.gj,
   ABT0.abt_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_netto_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG0 ON PLAN.owg_id = OWG0.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG0 ON OWG0.hwg_id = HWG0.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT0 ON HWG0.abt_id = ABT0.abt_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT1 ON PLAN.kjmo = ZEIT1.kjmo AND ZEIT1.akt_gj = 0
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ABT0.abt_id,
   ZEIT1.gj) AS plan ON vis.mandant_id = plan.mandant_id AND vis.wup_id = plan.wup_id AND vis.wrg_id = plan.wrg_id AND
    vis.gj = plan.gj AND vis.abt_id = plan.abt_id
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0 /* JZG 102-x000000 - Umsatz HWG */
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 10 AS metrik_id,
 2 AS typ_id,
 CAST(vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
 plan.ums_netto_plan AS plan_gj1,
 1.00 AS plan_gj2,
 plan.ums_netto_plan AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS eingabe,
  plan.ums_netto_plan / IF(fil.ums_netto_plan = 0, NULL, fil.ums_netto_plan) AS anteil,
  JZG10.wert_eingabe * (plan.ums_netto_plan / IF(fil.ums_netto_plan = 0, NULL, fil.ums_netto_plan)) AS ziel1,
 1.00 AS ziel2,
 COALESCE(JZG10.wert_eingabe * (plan.ums_netto_plan / IF(fil.ums_netto_plan = 0, NULL, fil.ums_netto_plan)), 0) AS ziel
 ,
 '' AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   ABT.abt_id,
   HWG.hwg_id,
   SUM(VIS.ums_netto) AS ums_netto
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_1 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_1 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
  WHERE ABT.abt_id IN (5, 6)
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   HWG.hwg_id,
   ABT.abt_id,
   ZEIT.gj) AS vis
 INNER JOIN (SELECT VIS1.mandant_id,
   VIS1.nb_id,
   VIS1.wup_id,
   VIS1.wrg_id,
   ZEIT2.gj,
   SUM(VIS1.ums_netto_plan) AS ums_netto_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS1
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT2 ON VIS1.kjmo = ZEIT2.kjmo AND ZEIT2.akt_gj = 0
  GROUP BY VIS1.mandant_id,
   VIS1.nb_id,
   VIS1.wup_id,
   VIS1.wrg_id,
   ZEIT2.gj) AS fil ON vis.mandant_id = fil.mandant_id AND vis.wup_id = fil.wup_id AND vis.wrg_id = fil.wrg_id AND vis.gj
    = fil.gj
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT3.gj,
   ABT1.abt_id,
   HWG1.hwg_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_netto_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG1 ON PLAN.owg_id = OWG1.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG1 ON OWG1.hwg_id = HWG1.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT1 ON HWG1.abt_id = ABT1.abt_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT3 ON PLAN.kjmo = ZEIT3.kjmo AND ZEIT3.akt_gj = 0
  WHERE ABT1.abt_id IN (5, 6)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   HWG1.hwg_id,
   ABT1.abt_id,
   ZEIT3.gj) AS plan ON vis.mandant_id = plan.mandant_id AND vis.wup_id = plan.wup_id AND vis.wrg_id = plan.wrg_id AND
    vis.gj = plan.gj AND vis.hwg_id = plan.hwg_id
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0 /* JZG 103-5xxxxxx - Umsatz OWG */
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 10 AS metrik_id,
 2 AS typ_id,
 CAST(vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
 plan.ums_netto_plan AS plan_gj1,
 1.00 AS plan_gj2,
 plan.ums_netto_plan AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS eingabe,
  plan.ums_netto_plan / IF(fil.ums_netto_plan = 0, NULL, fil.ums_netto_plan) AS anteil,
  JZG10.wert_eingabe * (plan.ums_netto_plan / IF(fil.ums_netto_plan = 0, NULL, fil.ums_netto_plan)) AS ziel1,
 1.00 AS ziel2,
 COALESCE(JZG10.wert_eingabe * (plan.ums_netto_plan / IF(fil.ums_netto_plan = 0, NULL, fil.ums_netto_plan)), 0) AS ziel
 ,
 '' AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   ABT.abt_id,
   HWG.hwg_id,
   OWG.owg_id,
   SUM(VIS.ums_netto) AS ums_netto
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_1 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_1 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
  WHERE ABT.abt_id IN (5)
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   OWG.owg_id,
   HWG.hwg_id,
   ABT.abt_id,
   ZEIT.gj) AS vis
 INNER JOIN (SELECT VIS2.mandant_id,
   VIS2.nb_id,
   VIS2.wup_id,
   VIS2.wrg_id,
   ZEIT4.gj,
   SUM(VIS2.ums_netto_plan) AS ums_netto_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS2
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT4 ON VIS2.kjmo = ZEIT4.kjmo AND ZEIT4.akt_gj = 0
  GROUP BY VIS2.mandant_id,
   VIS2.nb_id,
   VIS2.wup_id,
   VIS2.wrg_id,
   ZEIT4.gj) AS fil ON vis.mandant_id = fil.mandant_id AND vis.wup_id = fil.wup_id AND vis.wrg_id = fil.wrg_id AND vis.gj
    = fil.gj
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT5.gj,
   ABT2.abt_id,
   HWG2.hwg_id,
   OWG2.owg_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_netto_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG2 ON PLAN.owg_id = OWG2.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG2 ON OWG2.hwg_id = HWG2.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT2 ON HWG2.abt_id = ABT2.abt_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT5 ON PLAN.kjmo = ZEIT5.kjmo AND ZEIT5.akt_gj = 0
  WHERE ABT2.abt_id IN (5)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   OWG2.owg_id,
   HWG2.hwg_id,
   ABT2.abt_id,
   ZEIT5.gj) AS plan ON vis.mandant_id = plan.mandant_id AND vis.wup_id = plan.wup_id AND vis.wrg_id = plan.wrg_id AND
    vis.gj = plan.gj AND vis.owg_id = plan.owg_id
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0 /* JZG 130-0 - Kunden Filiale */
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 13 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 CAST(NULL AS BIGNUMERIC) AS plan_gj1,
 CAST(NULL AS NUMERIC) AS plan_gj2,
 CAST(NULL AS BIGNUMERIC) AS plan_gj,
 JZG13.wert_eingabe AS eingabe,
 CAST(NULL AS NUMERIC) AS anteil,
 JZG13.wert_eingabe AS ziel1,
 1.00 AS ziel2,
 COALESCE(JZG13.wert_eingabe, 0) AS ziel,
 COALESCE(JZG13.kommentar_eingabe, '') AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0 AND ZEIT.mo_kj = 2) AS
 vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG13 ON vis.mandant_id = JZG13.mandant_id AND vis.wup_id
         = JZG13.wup_id AND vis.wrg_id = JZG13.wrg_id AND vis.gj = JZG13.gj AND JZG13.metrik_id = 13 AND JZG13.typ_id =
    0 AND JZG13.level_id = 0 /* JZG 160-0 - Ø Bon Filiale */
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 16 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 CAST(NULL AS BIGNUMERIC) AS plan_gj1,
 CAST(NULL AS NUMERIC) AS plan_gj2,
 CAST(NULL AS BIGNUMERIC) AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS eingabe,
 CAST(NULL AS NUMERIC) AS anteil,
 JZG10.wert_eingabe AS ziel1,
 JZG13.wert_eingabe AS ziel2,
 COALESCE(JZG10.wert_eingabe / IF(JZG13.wert_eingabe = 0, NULL, JZG13.wert_eingabe), 0) AS ziel,
 '' AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0 AND ZEIT.mo_kj = 2) AS
 vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG13 ON vis.mandant_id = JZG13.mandant_id AND vis.wup_id
         = JZG13.wup_id AND vis.wrg_id = JZG13.wrg_id AND vis.gj = JZG13.gj AND JZG13.metrik_id = 13 AND JZG13.typ_id =
    0 AND JZG13.level_id = 0 /* JZG 200-0 - Nettoleistung Filiale */
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 20 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 vis.ums_netto_plan AS plan_gj1,
 vis.pers_std_plan AS plan_gj2,
  vis.ums_netto_plan / IF(vis.pers_std_plan = 0, NULL, vis.pers_std_plan) AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS eingabe,
 CAST(NULL AS NUMERIC) AS anteil,
 JZG10.wert_eingabe AS ziel1,
 JZG23.wert_eingabe AS ziel2,
 COALESCE(JZG10.wert_eingabe / IF(JZG23.wert_eingabe = 0, NULL, JZG23.wert_eingabe), 0) AS ziel,
 '' AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_netto_plan,
   SUM(VIS.pers_std_plan) AS pers_std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis.mandant_id = JZG10.mandant_id AND vis.wup_id
         = JZG10.wup_id AND vis.wrg_id = JZG10.wrg_id AND vis.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10.typ_id =
    0 AND JZG10.level_id = 0
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG23 ON vis.mandant_id = JZG23.mandant_id AND vis.wup_id
         = JZG23.wup_id AND vis.wrg_id = JZG23.wrg_id AND vis.gj = JZG23.gj AND JZG23.metrik_id = 23 AND JZG23.typ_id =
    0 AND JZG23.level_id = 0 /* JZG 230-0 - Nettostunden Filiale */
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 23 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 vis.pers_std_plan AS plan_gj1,
 1.00 AS plan_gj2,
 vis.pers_std_plan AS plan_gj,
 JZG23.wert_eingabe AS eingabe,
 CAST(NULL AS NUMERIC) AS anteil,
 JZG23.wert_eingabe AS ziel1,
 1.00 AS ziel2,
 COALESCE(JZG23.wert_eingabe, 0) AS ziel,
 COALESCE(JZG23.kommentar_eingabe, '') AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_netto_plan,
   SUM(VIS.pers_std_plan) AS pers_std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG23 ON vis.mandant_id = JZG23.mandant_id AND vis.wup_id
         = JZG23.wup_id AND vis.wrg_id = JZG23.wrg_id AND vis.gj = JZG23.gj AND JZG23.metrik_id = 23 AND JZG23.typ_id =
    0 AND JZG23.level_id = 0 /* JZG 400-0 - Abschriften_1 Filiale v2 */
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 40 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 vis_agg.abs_plan AS plan_gj1,
 vis_agg.ums_plan AS plan_gj2,
  vis_agg.abs_plan / IF(vis_agg.ums_plan = 0, NULL, vis_agg.ums_plan) AS plan_gj,
 CAST(NULL AS BIGNUMERIC) AS eingabe,
 vis_agg.anteil,
 vis_agg.abs_ziel AS ziel1,
 vis_agg.ums_ziel AS ziel2,
 COALESCE(vis_agg.abs_ziel / IF(vis_agg.ums_ziel = 0, NULL, vis_agg.ums_ziel), 0) AS ziel,
 COALESCE(vis_agg.kommentar, '') AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_netto_plan,
   SUM(VIS.pers_std_plan) AS pers_std_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   SUM(abs_plan) AS abs_plan,
   SUM(ums_plan) AS ums_plan,
   SUM(anteil) AS anteil,
   cast(NULL as string) AS kommentar,
   SUM(ums_ziel) AS ums_ziel,
   SUM(abs_ziel) AS abs_ziel
  FROM (SELECT vis_plan.mandant_id,
      vis_plan.nb_id,
      vis_plan.wup_id,
      vis_plan.wrg_id,
      vis_plan.gj,
      vis_plan.abt_id,
      vis_plan.hwg_id,
      vis_plan.owg_id,
      vis_plan.abschriften_netto_operativ_plan AS abs_plan,
      vis_plan.umsatz_netto_plan AS ums_plan,
       vis_plan.abschriften_netto_operativ_plan / IF(vis_plan.umsatz_netto_plan = 0, NULL, vis_plan.umsatz_netto_plan)
      AS co_plan,
       vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) AS anteil,
        vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe
      AS ums_ziel,
         vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe
       * COALESCE(JZG40.wert_eingabe, vis_plan.abschriften_netto_operativ_plan / IF(vis_plan.umsatz_netto_plan = 0, NULL
          , vis_plan.umsatz_netto_plan)) AS abs_ziel
     FROM (SELECT PLAN.mandant_id,
        PLAN.nb_id,
        PLAN.wup_id,
        PLAN.wrg_id,
        ZEIT.gj,
        ABT.abt_id,
        HWG.hwg_id,
        OWG.owg_id,
        CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id) AS BIGNUMERIC) AS level_id,
        SUM(PLAN.umsatz_netto_plan) AS umsatz_netto_plan,
        SUM(PLAN.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
       FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
        INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLAN.owg_id = OWG.owg_id
        INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
        INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
        INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLAN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
       WHERE ABT.abt_id = 5
       GROUP BY PLAN.mandant_id,
        PLAN.nb_id,
        PLAN.wup_id,
        ZEIT.gj,
        PLAN.wrg_id,
        ABT.abt_id,
        HWG.hwg_id,
        OWG.owg_id,
        level_id) AS vis_plan
      LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG40 ON vis_plan.mandant_id = JZG40.mandant_id
           AND vis_plan.wup_id = JZG40.wup_id AND vis_plan.wrg_id = JZG40.wrg_id AND vis_plan.gj = JZG40.gj AND JZG40.metrik_id
          = 40 AND vis_plan.level_id = JZG40.level_id
      LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis_plan.mandant_id = JZG10.mandant_id
            AND vis_plan.wup_id = JZG10.wup_id AND vis_plan.wrg_id = JZG10.wrg_id AND vis_plan.gj = JZG10.gj AND JZG10.metrik_id
           = 10 AND JZG10.typ_id = 0 AND JZG10.level_id = 0
      INNER JOIN (SELECT VIS.mandant_id,
        VIS.nb_id,
        VIS.wup_id,
        VIS.wrg_id,
        ZEIT6.gj,
        SUM(VIS.ums_netto_plan) AS ums_netto_plan
       FROM kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup_1 AS VIS
        INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT6 ON VIS.kjmo = ZEIT6.kjmo AND ZEIT6.akt_gj = 0
       GROUP BY VIS.mandant_id,
        VIS.nb_id,
        VIS.wup_id,
        VIS.wrg_id,
        ZEIT6.gj) AS vis_tag ON vis_plan.mandant_id = vis_tag.mandant_id AND vis_plan.wup_id = vis_tag.wup_id AND
         vis_plan.wrg_id = vis_tag.wrg_id AND vis_plan.gj /* Filiale - Abteilung 6 > CROSS JOIN Level HWG */ = vis_tag.gj
        
     UNION ALL
     SELECT vis_plan.mandant_id,
      vis_plan.nb_id,
      vis_plan.wup_id,
      vis_plan.wrg_id,
      vis_plan.gj,
      vis_plan.abt_id,
      vis_plan.hwg_id,
      0 AS owg_id,
      vis_plan.abschriften_netto_operativ_plan AS abs_plan,
      vis_plan.umsatz_netto_plan AS ums_plan,
       vis_plan.abschriften_netto_operativ_plan / IF(vis_plan.umsatz_netto_plan = 0, NULL, vis_plan.umsatz_netto_plan)
      AS co_plan,
       vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) AS anteil,
        vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe
      AS ums_ziel,
         vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe
       * COALESCE(JZG40.wert_eingabe, vis_plan.abschriften_netto_operativ_plan / IF(vis_plan.umsatz_netto_plan = 0, NULL
          , vis_plan.umsatz_netto_plan)) AS abs_ziel
     FROM (SELECT PLAN.mandant_id,
        PLAN.nb_id,
        PLAN.wup_id,
        PLAN.wrg_id,
        ZEIT.gj,
        ABT.abt_id,
        HWG.hwg_id,
        CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
        SUM(PLAN.umsatz_netto_plan) AS umsatz_netto_plan,
        SUM(PLAN.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
       FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
        INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLAN.owg_id = OWG.owg_id
        INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
        INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
        INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLAN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
       WHERE ABT.abt_id = 6
       GROUP BY PLAN.mandant_id,
        PLAN.nb_id,
        PLAN.wup_id,
        PLAN.wrg_id,
        ZEIT.gj,
        ABT.abt_id,
        HWG.hwg_id,
        level_id) AS vis_plan
      LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG40 ON vis_plan.mandant_id = JZG40.mandant_id
           AND vis_plan.wup_id = JZG40.wup_id AND vis_plan.wrg_id = JZG40.wrg_id AND vis_plan.gj = JZG40.gj AND JZG40.metrik_id
          = 40 AND vis_plan.level_id = JZG40.level_id
      LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis_plan.mandant_id = JZG10.mandant_id
            AND vis_plan.wup_id = JZG10.wup_id AND vis_plan.wrg_id = JZG10.wrg_id AND vis_plan.gj = JZG10.gj AND JZG10.metrik_id
           = 10 AND JZG10.typ_id = 0 AND JZG10.level_id = 0
      INNER JOIN (SELECT VIS.mandant_id,
        VIS.nb_id,
        VIS.wup_id,
        ZEIT7.gj,
        VIS.wrg_id,
        SUM(VIS.ums_netto_plan) AS ums_netto_plan
       FROM kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup_1 AS VIS
        INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT7 ON VIS.kjmo = ZEIT7.kjmo AND ZEIT7.akt_gj = 0
       GROUP BY VIS.mandant_id,
        VIS.nb_id,
        VIS.wup_id,
        VIS.wrg_id,
        ZEIT7.gj) AS vis_tag ON vis_plan.mandant_id = vis_tag.mandant_id AND vis_plan.wup_id = vis_tag.wup_id AND
         vis_plan.wrg_id = vis_tag.wrg_id AND vis_plan.gj /* ABTEILUNG - Abteilung 7,8,4 > CROSS JOIN Level Abteilung */
        = vis_tag.gj
     UNION ALL
     SELECT vis_plan.mandant_id,
      vis_plan.nb_id,
      vis_plan.wup_id,
      vis_plan.wrg_id,
      vis_plan.gj,
      vis_plan.abt_id,
      0 AS hwg_id,
      0 AS owg_id,
      vis_plan.abschriften_netto_operativ_plan AS abs_plan,
      vis_plan.umsatz_netto_plan AS ums_plan,
       vis_plan.abschriften_netto_operativ_plan / IF(vis_plan.umsatz_netto_plan = 0, NULL, vis_plan.umsatz_netto_plan)
      AS co_plan,
       vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) AS anteil,
        vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe
      AS ums_ziel,
         vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe
       * COALESCE(JZG40.wert_eingabe, vis_plan.abschriften_netto_operativ_plan / IF(vis_plan.umsatz_netto_plan = 0, NULL
          , vis_plan.umsatz_netto_plan)) AS abs_ziel
     FROM (SELECT PLAN.mandant_id,
        PLAN.nb_id,
        PLAN.wup_id,
        PLAN.wrg_id,
        ZEIT.gj,
        ABT.abt_id,
        CAST(CASE
          WHEN ABT.abt_id = 4
          THEN 9999999
          ELSE ABT.abt_id * 1000000
          END AS BIGNUMERIC) AS level_id,
        SUM(PLAN.umsatz_netto_plan) AS umsatz_netto_plan,
        SUM(PLAN.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
       FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
        INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLAN.owg_id = OWG.owg_id
        INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
        INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
        INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLAN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
       WHERE ABT.abt_id IN (4, 7, 8)
       GROUP BY PLAN.mandant_id,
        PLAN.nb_id,
        PLAN.wup_id,
        PLAN.wrg_id,
        ZEIT.gj,
        ABT.abt_id,
        level_id) AS vis_plan
      LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG40 ON vis_plan.mandant_id = JZG40.mandant_id
           AND vis_plan.wup_id = JZG40.wup_id AND vis_plan.wrg_id = JZG40.wrg_id AND vis_plan.gj = JZG40.gj AND JZG40.metrik_id
          = 40 AND vis_plan.level_id = JZG40.level_id
      LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis_plan.mandant_id = JZG10.mandant_id
            AND vis_plan.wup_id = JZG10.wup_id AND vis_plan.wrg_id = JZG10.wrg_id AND vis_plan.gj = JZG10.gj AND JZG10.metrik_id
           = 10 AND JZG10.typ_id = 0 AND JZG10.level_id = 0
      INNER JOIN (SELECT VIS.mandant_id,
        VIS.nb_id,
        VIS.wup_id,
        ZEIT8.gj,
        VIS.wrg_id,
        SUM(VIS.ums_netto_plan) AS ums_netto_plan
       FROM kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup_1 AS VIS
        INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT8 ON VIS.kjmo = ZEIT8.kjmo AND ZEIT8.akt_gj = 0
       GROUP BY VIS.mandant_id,
        VIS.nb_id,
        VIS.wup_id,
        VIS.wrg_id,
        ZEIT8.gj) AS vis_tag ON vis_plan.mandant_id = vis_tag.mandant_id AND vis_plan.wup_id = vis_tag.wup_id AND
         vis_plan.wrg_id = vis_tag.wrg_id AND vis_plan.gj = vis_tag.gj) AS vis_plan_fil
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj) AS vis_agg ON vis.mandant_id = vis_agg.mandant_id AND vis.wup_id = vis_agg.wup_id AND vis.wrg_id = vis_agg.wrg_id
     AND vis.gj /* JZG 401-x000000 - Abschriften_1 Abteilung v2 */ = vis_agg.gj
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 40 AS metrik_id,
 1 AS typ_id,
 CAST(CASE
   WHEN vis.abt_id = 4
   THEN 9999999
   ELSE vis.abt_id * 1000000
   END AS BIGNUMERIC) AS level_id,
 vis_agg.abs_plan AS plan_gj1,
 vis_agg.ums_plan AS plan_gj2,
  vis_agg.abs_plan / IF(vis_agg.ums_plan = 0, NULL, vis_agg.ums_plan) AS plan_gj,
 vis_agg.eingabe,
 vis_agg.anteil,
 vis_agg.abs_ziel AS ziel1,
 vis_agg.ums_ziel AS ziel2,
 COALESCE(vis_agg.abs_ziel / IF(vis_agg.ums_ziel = 0, NULL, vis_agg.ums_ziel), 0) AS ziel,
 COALESCE(vis_agg.kommentar, '') AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   ABT.abt_id,
   SUM(VIS.ums_netto) AS ums_netto
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_1 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_1 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
  WHERE ABT.abt_id > 0
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   ABT.abt_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT vis_plan.mandant_id,
    vis_plan.nb_id,
    vis_plan.wup_id,
    vis_plan.gj,
    vis_plan.wrg_id,
    vis_plan.abt_id,
    SUM(vis_plan.abschriften_netto_operativ_plan) AS abs_plan,
    SUM(vis_plan.umsatz_netto_plan) AS ums_plan,
    SUM(vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan)) AS anteil,
    CAST(NULL AS BIGNUMERIC) AS eingabe,
    CAST(NULL AS STRING) AS kommentar,
    SUM(vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe)
    AS ums_ziel,
    SUM(vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe *
      COALESCE(JZG40.wert_eingabe, vis_plan.abschriften_netto_operativ_plan / IF(vis_plan.umsatz_netto_plan = 0, NULL,
         vis_plan.umsatz_netto_plan))) AS abs_ziel
   FROM (SELECT PLAN.mandant_id,
      PLAN.nb_id,
      PLAN.wup_id,
      ZEIT.gj,
      PLAN.wrg_id,
      ABT.abt_id,
      HWG.hwg_id,
      OWG.owg_id,
      CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id) AS BIGNUMERIC) AS level_id,
      SUM(PLAN.umsatz_netto_plan) AS umsatz_netto_plan,
      SUM(PLAN.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLAN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLAN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
     WHERE ABT.abt_id = 5
     GROUP BY PLAN.mandant_id,
      PLAN.nb_id,
      PLAN.wup_id,
      ZEIT.gj,
      PLAN.wrg_id,
      ABT.abt_id,
      HWG.hwg_id,
      OWG.owg_id,
      level_id) AS vis_plan
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG40 ON vis_plan.mandant_id = JZG40.mandant_id
         AND vis_plan.wup_id = JZG40.wup_id AND vis_plan.wrg_id = JZG40.wrg_id AND vis_plan.gj = JZG40.gj AND JZG40.metrik_id
        = 40 AND vis_plan.level_id = JZG40.level_id
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis_plan.mandant_id = JZG10.mandant_id
          AND vis_plan.wup_id = JZG10.wup_id AND vis_plan.wrg_id = JZG10.wrg_id AND vis_plan.gj = JZG10.gj AND JZG10.metrik_id
         = 10 AND JZG10.typ_id = 0 AND JZG10.level_id = 0
    INNER JOIN (SELECT VIS.mandant_id,
      VIS.nb_id,
      VIS.wup_id,
      ZEIT9.gj,
      VIS.wrg_id,
      SUM(VIS.ums_netto_plan) AS ums_netto_plan
     FROM kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup_1 AS VIS
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT9 ON VIS.kjmo = ZEIT9.kjmo AND ZEIT9.akt_gj = 0
     GROUP BY VIS.mandant_id,
      VIS.nb_id,
      VIS.wup_id,
      VIS.wrg_id,
      ZEIT9.gj) AS vis_tag ON vis_plan.mandant_id = vis_tag.mandant_id AND vis_plan.wup_id = vis_tag.wup_id AND vis_plan
       .wrg_id = vis_tag.wrg_id AND vis_plan.gj = vis_tag.gj
   GROUP BY vis_plan.mandant_id,
    vis_plan.nb_id,
    vis_plan.wup_id,
    vis_plan.gj,
    vis_plan.wrg_id,
    vis_plan.abt_id
   UNION ALL
   SELECT vis_plan.mandant_id,
    vis_plan.nb_id,
    vis_plan.wup_id,
    vis_plan.gj,
    vis_plan.wrg_id,
    vis_plan.abt_id,
    SUM(vis_plan.abschriften_netto_operativ_plan) AS abs_plan,
    SUM(vis_plan.umsatz_netto_plan) AS ums_plan,
    SUM(vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan)) AS anteil,
    CAST(NULL AS BIGNUMERIC) AS eingabe,
    CAST(NULL AS STRING) AS kommentar,
    SUM(vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe)
    AS ums_ziel,
    SUM(vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe *
      COALESCE(JZG40.wert_eingabe, vis_plan.abschriften_netto_operativ_plan / IF(vis_plan.umsatz_netto_plan = 0, NULL,
         vis_plan.umsatz_netto_plan))) AS abs_ziel
   FROM (SELECT PLAN.mandant_id,
      PLAN.nb_id,
      PLAN.wup_id,
      ZEIT.gj,
      PLAN.wrg_id,
      ABT.abt_id,
      HWG.hwg_id,
      CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
      SUM(PLAN.umsatz_netto_plan) AS umsatz_netto_plan,
      SUM(PLAN.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLAN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLAN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
     WHERE ABT.abt_id = 6
     GROUP BY PLAN.mandant_id,
      PLAN.nb_id,
      PLAN.wup_id,
      ZEIT.gj,
      PLAN.wrg_id,
      ABT.abt_id,
      HWG.hwg_id,
      level_id) AS vis_plan
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG40 ON vis_plan.mandant_id = JZG40.mandant_id
         AND vis_plan.wup_id = JZG40.wup_id AND vis_plan.wrg_id = JZG40.wrg_id AND vis_plan.gj = JZG40.gj AND JZG40.metrik_id
        = 40 AND vis_plan.level_id = JZG40.level_id
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis_plan.mandant_id = JZG10.mandant_id
          AND vis_plan.wup_id = JZG10.wup_id AND vis_plan.wrg_id = JZG10.wrg_id AND vis_plan.gj = JZG10.gj AND JZG10.metrik_id
         = 10 AND JZG10.typ_id = 0 AND JZG10.level_id = 0
    INNER JOIN (SELECT VIS.mandant_id,
      VIS.nb_id,
      VIS.wup_id,
      ZEIT10.gj,
      VIS.wrg_id,
      SUM(VIS.ums_netto_plan) AS ums_netto_plan
     FROM kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup_1 AS VIS
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT10 ON VIS.kjmo = ZEIT10.kjmo AND ZEIT10.akt_gj = 0
     GROUP BY VIS.mandant_id,
      VIS.nb_id,
      VIS.wup_id,
      VIS.wrg_id,
      ZEIT10.gj) AS vis_tag ON vis_plan.mandant_id = vis_tag.mandant_id AND vis_plan.wup_id = vis_tag.wup_id AND
       vis_plan.wrg_id = vis_tag.wrg_id AND vis_plan.gj = vis_tag.gj
   GROUP BY vis_plan.mandant_id,
    vis_plan.nb_id,
    vis_plan.wup_id,
    vis_plan.gj,
    vis_plan.wrg_id,
    vis_plan.abt_id
   UNION ALL
   SELECT vis_plan.mandant_id,
    vis_plan.nb_id,
    vis_plan.wup_id,
    vis_plan.gj,
    vis_plan.wrg_id,
    vis_plan.abt_id,
    vis_plan.abs_netto_plan AS abs_plan,
    vis_plan.ums_netto_plan AS ums_plan,
     vis_plan.ums_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) AS anteil,
    JZG40.wert_eingabe AS eingabe,
    JZG40.kommentar_eingabe AS kommentar,
      vis_plan.ums_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe AS
    ums_ziel,
       vis_plan.ums_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe *
     COALESCE(JZG40.wert_eingabe, vis_plan.abs_netto_plan / IF(vis_plan.ums_netto_plan = 0, NULL, vis_plan.ums_netto_plan
        )) AS abs_ziel
   FROM (SELECT PLAN.mandant_id,
      PLAN.nb_id,
      PLAN.wup_id,
      ZEIT.gj,
      PLAN.wrg_id,
      ABT.abt_id,
      CAST(CASE
        WHEN ABT.abt_id = 4
        THEN 9999999
        ELSE ABT.abt_id * 1000000
        END AS BIGNUMERIC) AS level_id,
      SUM(PLAN.umsatz_netto_plan) AS ums_netto_plan,
      SUM(PLAN.abschriften_netto_operativ_plan) AS abs_netto_plan
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLAN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLAN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
     WHERE ABT.abt_id IN (4, 7, 8)
     GROUP BY PLAN.mandant_id,
      PLAN.nb_id,
      PLAN.wup_id,
      ZEIT.gj,
      PLAN.wrg_id,
      ABT.abt_id,
      level_id) AS vis_plan
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG40 ON vis_plan.mandant_id = JZG40.mandant_id
         AND vis_plan.wup_id = JZG40.wup_id AND vis_plan.wrg_id = JZG40.wrg_id AND vis_plan.gj = JZG40.gj AND JZG40.metrik_id
        = 40 AND vis_plan.level_id = JZG40.level_id
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis_plan.mandant_id = JZG10.mandant_id
          AND vis_plan.wup_id = JZG10.wup_id AND vis_plan.wrg_id = JZG10.wrg_id AND vis_plan.gj = JZG10.gj AND JZG10.metrik_id
         = 10 AND JZG10.typ_id = 0 AND JZG10.level_id = 0
    INNER JOIN (SELECT VIS.mandant_id,
      VIS.nb_id,
      VIS.wup_id,
      ZEIT11.gj,
      VIS.wrg_id,
      SUM(VIS.ums_netto_plan) AS ums_netto_plan
     FROM kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup_1 AS VIS
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT11 ON VIS.kjmo = ZEIT11.kjmo AND ZEIT11.akt_gj = 0
     GROUP BY VIS.mandant_id,
      VIS.nb_id,
      VIS.wup_id,
      VIS.wrg_id,
      ZEIT11.gj) AS vis_tag ON vis_plan.mandant_id = vis_tag.mandant_id AND vis_plan.wup_id = vis_tag.wup_id AND
       vis_plan.wrg_id = vis_tag.wrg_id AND vis_plan.gj = vis_tag.gj) AS vis_agg ON vis.mandant_id = vis_agg.mandant_id
     AND vis.wup_id = vis_agg.wup_id AND vis.wrg_id = vis_agg.wrg_id AND vis.gj = vis_agg.gj AND vis.abt_id
   /* JZG 402-xxx0000 - Abschriften_1 HWG v2 */ = vis_agg.abt_id
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 40 AS metrik_id,
 2 AS typ_id,
 CAST(vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
 vis_agg.abs_plan AS plan_gj1,
 vis_agg.ums_plan AS plan_gj2,
  vis_agg.abs_plan / IF(vis_agg.ums_plan = 0, NULL, vis_agg.ums_plan) AS plan_gj,
 vis_agg.eingabe,
 vis_agg.anteil,
 vis_agg.abs_ziel AS ziel1,
 vis_agg.ums_ziel AS ziel2,
 COALESCE(vis_agg.abs_ziel / IF(vis_agg.ums_ziel = 0, NULL, vis_agg.ums_ziel), 0) AS ziel,
 COALESCE(vis_agg.kommentar, '') AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   ABT.abt_id,
   HWG.hwg_id,
   SUM(VIS.ums_netto) AS ums_netto
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_1 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_1 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
  WHERE ABT.abt_id IN (5, 6)
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   HWG.hwg_id,
   ABT.abt_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT vis_plan.mandant_id,
    vis_plan.nb_id,
    vis_plan.wup_id,
    vis_plan.gj,
    vis_plan.wrg_id,
    vis_plan.abt_id,
    vis_plan.hwg_id,
    SUM(vis_plan.abschriften_netto_operativ_plan) AS abs_plan,
    SUM(vis_plan.umsatz_netto_plan) AS ums_plan,
    SUM(vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan)) AS anteil,
    CAST(NULL AS BIGNUMERIC) AS eingabe,
    CAST(NULL AS STRING) AS kommentar,
    SUM(vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe)
    AS ums_ziel,
    SUM(vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe *
      COALESCE(JZG40.wert_eingabe, vis_plan.abschriften_netto_operativ_plan / IF(vis_plan.umsatz_netto_plan = 0, NULL,
         vis_plan.umsatz_netto_plan))) AS abs_ziel
   FROM (SELECT PLAN.mandant_id,
      PLAN.nb_id,
      PLAN.wup_id,
      ZEIT.gj,
      PLAN.wrg_id,
      ABT.abt_id,
      HWG.hwg_id,
      OWG.owg_id,
      CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id) AS BIGNUMERIC) AS level_id,
      SUM(PLAN.umsatz_netto_plan) AS umsatz_netto_plan,
      SUM(PLAN.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLAN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLAN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
     WHERE ABT.abt_id = 5
     GROUP BY PLAN.mandant_id,
      PLAN.nb_id,
      PLAN.wup_id,
      ZEIT.gj,
      PLAN.wrg_id,
      ABT.abt_id,
      HWG.hwg_id,
      OWG.owg_id,
      level_id) AS vis_plan
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG40 ON vis_plan.mandant_id = JZG40.mandant_id
         AND vis_plan.wup_id = JZG40.wup_id AND vis_plan.wrg_id = JZG40.wrg_id AND vis_plan.gj = JZG40.gj AND JZG40.metrik_id
        = 40 AND vis_plan.level_id = JZG40.level_id
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis_plan.mandant_id = JZG10.mandant_id
          AND vis_plan.wup_id = JZG10.wup_id AND vis_plan.wrg_id = JZG10.wrg_id AND vis_plan.gj = JZG10.gj AND JZG10.metrik_id
         = 10 AND JZG10.typ_id = 0 AND JZG10.level_id = 0
    INNER JOIN (SELECT VIS.mandant_id,
      VIS.nb_id,
      VIS.wup_id,
      ZEIT12.gj,
      VIS.wrg_id,
      SUM(VIS.ums_netto_plan) AS ums_netto_plan
     FROM kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup_1 AS VIS
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT12 ON VIS.kjmo = ZEIT12.kjmo AND ZEIT12.akt_gj = 0
     GROUP BY VIS.mandant_id,
      VIS.nb_id,
      VIS.wup_id,
      VIS.wrg_id,
      ZEIT12.gj) AS vis_tag ON vis_plan.mandant_id = vis_tag.mandant_id AND vis_plan.wup_id = vis_tag.wup_id AND
       vis_plan.wrg_id = vis_tag.wrg_id AND vis_plan.gj = vis_tag.gj
   GROUP BY vis_plan.mandant_id,
    vis_plan.nb_id,
    vis_plan.wup_id,
    vis_plan.gj,
    vis_plan.wrg_id,
    vis_plan.abt_id,
    vis_plan.hwg_id
   UNION ALL
   SELECT vis_plan.mandant_id,
    vis_plan.nb_id,
    vis_plan.wup_id,
    vis_plan.gj,
    vis_plan.wrg_id,
    vis_plan.abt_id,
    vis_plan.hwg_id,
    vis_plan.abschriften_netto_operativ_plan AS abs_plan,
    vis_plan.umsatz_netto_plan AS ums_plan,
     vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) AS anteil,
    JZG40.wert_eingabe AS eingabe,
    JZG40.kommentar_eingabe AS kommentar,
      vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe AS
    ums_ziel,
       vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe *
     COALESCE(JZG40.wert_eingabe, vis_plan.abschriften_netto_operativ_plan / IF(vis_plan.umsatz_netto_plan = 0, NULL,
        vis_plan.umsatz_netto_plan)) AS abs_ziel
   FROM (SELECT PLAN.mandant_id,
      PLAN.nb_id,
      PLAN.wup_id,
      ZEIT.gj,
      PLAN.wrg_id,
      ABT.abt_id,
      HWG.hwg_id,
      CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
      SUM(PLAN.umsatz_netto_plan) AS umsatz_netto_plan,
      SUM(PLAN.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLAN.kjmo = ZEIT.kjmo
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLAN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
     WHERE ZEIT.akt_gj = 0
      AND PLAN.nb_id = 0
      AND ABT.abt_id IN (6)
     GROUP BY PLAN.mandant_id,
      PLAN.nb_id,
      PLAN.wup_id,
      ZEIT.gj,
      PLAN.wrg_id,
      ABT.abt_id,
      HWG.hwg_id,
      level_id) AS vis_plan
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG40 ON vis_plan.mandant_id = JZG40.mandant_id
         AND vis_plan.wup_id = JZG40.wup_id AND vis_plan.wrg_id = JZG40.wrg_id AND vis_plan.gj = JZG40.gj AND JZG40.metrik_id
        = 40 AND vis_plan.level_id = JZG40.level_id
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis_plan.mandant_id = JZG10.mandant_id
          AND vis_plan.wup_id = JZG10.wup_id AND vis_plan.wrg_id = JZG10.wrg_id AND vis_plan.gj = JZG10.gj AND JZG10.metrik_id
         = 10 AND JZG10.typ_id = 0 AND JZG10.level_id = 0
    INNER JOIN (SELECT VIS.mandant_id,
      VIS.nb_id,
      VIS.wup_id,
      ZEIT13.gj,
      VIS.wrg_id,
      SUM(VIS.ums_netto_plan) AS ums_netto_plan
     FROM kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup_1 AS VIS
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT13 ON VIS.kjmo = ZEIT13.kjmo AND ZEIT13.akt_gj = 0
     GROUP BY VIS.mandant_id,
      VIS.nb_id,
      VIS.wup_id,
      VIS.wrg_id,
      ZEIT13.gj) AS vis_tag ON vis_plan.mandant_id = vis_tag.mandant_id AND vis_plan.wup_id = vis_tag.wup_id AND
       vis_plan.wrg_id = vis_tag.wrg_id AND vis_plan.gj = vis_tag.gj) AS vis_agg ON vis.mandant_id = vis_agg.mandant_id
     AND vis.wup_id = vis_agg.wup_id AND vis.wrg_id = vis_agg.wrg_id AND vis.gj = vis_agg.gj AND vis.hwg_id
   /* JZG 403-5xxxxxx - Abschriften_1 OWG v2 */ = vis_agg.hwg_id
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 40 AS metrik_id,
 3 AS typ_id,
 CAST(vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 + ABS(vis.owg_id) AS BIGNUMERIC) AS level_id,
 vis_agg.abs_plan AS plan_gj1,
 vis_agg.ums_plan AS plan_gj2,
  vis_agg.abs_plan / IF(vis_agg.ums_plan = 0, NULL, vis_agg.ums_plan) AS plan_gj,
 vis_agg.eingabe,
 vis_agg.anteil,
 vis_agg.abs_ziel AS ziel1,
 vis_agg.ums_ziel AS ziel2,
 COALESCE(vis_agg.abs_ziel / IF(vis_agg.ums_ziel = 0, NULL, vis_agg.ums_ziel), 0) AS ziel,
 COALESCE(vis_agg.kommentar, '') AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   ABT.abt_id,
   HWG.hwg_id,
   OWG.owg_id,
   SUM(VIS.ums_netto) AS ums_netto
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_1 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_1 AS WG ON VIS.wg_id = WG.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON WG.owg_id = OWG.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
  WHERE ABT.abt_id = 5
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   OWG.owg_id,
   HWG.hwg_id,
   ABT.abt_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT vis_plan.mandant_id,
   vis_plan.nb_id,
   vis_plan.wup_id,
   vis_plan.gj,
   vis_plan.wrg_id,
   vis_plan.abt_id,
   vis_plan.hwg_id,
   vis_plan.owg_id,
   vis_plan.abschriften_netto_operativ_plan AS abs_plan,
   vis_plan.umsatz_netto_plan AS ums_plan,
    vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) AS anteil,
   JZG40.wert_eingabe AS eingabe,
   JZG40.kommentar_eingabe AS kommentar,
     vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe AS
   ums_ziel,
      vis_plan.umsatz_netto_plan / IF(vis_tag.ums_netto_plan = 0, NULL, vis_tag.ums_netto_plan) * JZG10.wert_eingabe *
    COALESCE(JZG40.wert_eingabe, vis_plan.abschriften_netto_operativ_plan / IF(vis_plan.umsatz_netto_plan = 0, NULL,
       vis_plan.umsatz_netto_plan)) AS abs_ziel
  FROM (SELECT PLAN.mandant_id,
     PLAN.nb_id,
     PLAN.wup_id,
     ZEIT14.gj,
     PLAN.wrg_id,
     ABT3.abt_id,
     HWG3.hwg_id,
     OWG3.owg_id,
     CAST(ABT3.abt_id * 1000000 + ABS(HWG3.hwg_id) * 10000 + ABS(OWG3.owg_id) AS BIGNUMERIC) AS level_id,
     SUM(PLAN.umsatz_netto_plan) AS umsatz_netto_plan,
     SUM(PLAN.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
    FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLAN
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG3 ON PLAN.owg_id = OWG3.owg_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG3 ON OWG3.hwg_id = HWG3.hwg_id
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT3 ON HWG3.abt_id = ABT3.abt_id
     INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT14 ON PLAN.kjmo = ZEIT14.kjmo AND ZEIT14.akt_gj = 0
    WHERE ABT3.abt_id = 5
    GROUP BY PLAN.mandant_id,
     PLAN.nb_id,
     PLAN.wup_id,
     ZEIT14.gj,
     PLAN.wrg_id,
     ABT3.abt_id,
     HWG3.hwg_id,
     OWG3.owg_id,
     level_id) AS vis_plan
   LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG40 ON vis_plan.mandant_id = JZG40.mandant_id AND
         vis_plan.wup_id = JZG40.wup_id AND vis_plan.wrg_id = JZG40.wrg_id AND vis_plan.gj = JZG40.gj AND JZG40.metrik_id
       = 40 AND vis_plan.level_id = JZG40.level_id
   LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON vis_plan.mandant_id = JZG10.mandant_id AND
          vis_plan.wup_id = JZG10.wup_id AND vis_plan.wrg_id = JZG10.wrg_id AND vis_plan.gj = JZG10.gj AND JZG10.metrik_id
        = 10 AND JZG10.typ_id = 0 AND JZG10.level_id = 0
   INNER JOIN (SELECT VIS3.mandant_id,
     VIS3.nb_id,
     VIS3.wup_id,
     ZEIT15.gj,
     VIS3.wrg_id,
     SUM(VIS3.ums_netto_plan) AS ums_netto_plan
    FROM kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup_1 AS VIS3
     INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT15 ON VIS3.kjmo = ZEIT15.kjmo AND ZEIT15.akt_gj = 0
    GROUP BY VIS3.mandant_id,
     VIS3.nb_id,
     VIS3.wup_id,
     VIS3.wrg_id,
     ZEIT15.gj) AS vis_tag ON vis_plan.mandant_id = vis_tag.mandant_id AND vis_plan.wup_id = vis_tag.wup_id AND vis_plan
      .wrg_id = vis_tag.wrg_id AND vis_plan.gj = vis_tag.gj) AS vis_agg ON vis.mandant_id = vis_agg.mandant_id AND vis.wup_id
       = vis_agg.wup_id AND vis.wrg_id = vis_agg.wrg_id AND vis.gj = vis_agg.gj AND vis.owg_id
   /* JZG 50x - Inventur_1 all levels v2 */ = vis_agg.owg_id
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 50 AS metrik_id,
 vis_pln.typ_id,
 vis_pln.level_id,
 CAST(NULL AS BIGNUMERIC) AS plan_gj1,
 CAST(NULL AS BIGNUMERIC) AS plan_gj2,
 CAST(NULL AS BIGNUMERIC) AS plan_gj,
 vis_pln.inv_eingabe AS eingabe,
  vis_pln.ums_owg_plan / IF(vis.ums_fil_plan = 0, NULL, vis.ums_fil_plan) AS anteil,
  vis_pln.inv_wert * vis.ums_faktor AS ziel1,
  vis_pln.ums_owg_plan * vis.ums_faktor AS ziel2,
 COALESCE(vis_pln.inv_wert * vis.ums_faktor / IF(vis_pln.ums_owg_plan * vis.ums_faktor = 0, NULL, vis_pln.ums_owg_plan *
     vis.ums_faktor), 0) AS ziel,
 COALESCE(vis_pln.inv_kommentar, '') AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto_plan) AS ums_fil_plan,
   SUM(JZG10.wert_eingabe) AS ums_eingabe,
    IFNULL(SUM(JZG10.wert_eingabe), 0) / IF(SUM(VIS.ums_netto_plan) = 0, NULL, SUM(VIS.ums_netto_plan)) AS ums_faktor
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
   LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG10 ON VIS.mandant_id = JZG10.mandant_id AND VIS
          .wup_id = JZG10.wup_id AND VIS.wrg_id = JZG10.wrg_id AND ZEIT.gj = JZG10.gj AND JZG10.metrik_id = 10 AND JZG10
      .typ_id = 0 AND JZG10.level_id = 0
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT PLN.mandant_id,
    PLN.nb_id,
    PLN.wup_id,
    ZEIT.gj,
    PLN.wrg_id,
    0 AS abt_id,
    0 AS hwg_id,
    0 AS owg_id,
    0 AS typ_id,
    0 AS level_id,
    SUM(PLN.umsatz_netto_plan) AS ums_owg_plan,
    MAX(JZG50.wert_eingabe) AS inv_eingabe,
    MAX(JZG50.kommentar_eingabe) AS inv_kommentar,
     SUM(PLN.umsatz_netto_plan) * MAX(JZG50.wert_eingabe) AS inv_wert
   FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
    INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG50 ON PLN.mandant_id = JZG50.mandant_id AND PLN
           .wup_id = JZG50.wup_id AND PLN.wrg_id = JZG50.wrg_id AND ZEIT.gj = JZG50.gj AND JZG50.metrik_id = 50 AND
       JZG50.typ_id = 0 AND JZG50.level_id = 0
   GROUP BY PLN.mandant_id,
    PLN.nb_id,
    PLN.wup_id,
    PLN.wrg_id,
    ZEIT.gj
   UNION ALL
   SELECT PLN.mandant_id,
    PLN.nb_id,
    PLN.wup_id,
    ZEIT.gj,
    PLN.wrg_id,
    ABT.abt_id,
    0 AS hwg_id,
    0 AS owg_id,
    1 AS typ_id,
    CAST(ABT.abt_id * 1000000 AS BIGNUMERIC) AS level_id,
    SUM(PLN.umsatz_netto_plan) AS ums_owg_plan,
    MAX(JZG50.wert_eingabe) AS inv_eingabe,
    MAX(JZG50.kommentar_eingabe) AS inv_kommentar,
     SUM(PLN.umsatz_netto_plan) * MAX(JZG50.wert_eingabe) AS inv_wert
   FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
    INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG50 ON PLN.mandant_id = JZG50.mandant_id AND PLN
           .wup_id = JZG50.wup_id AND PLN.wrg_id = JZG50.wrg_id AND ZEIT.gj = JZG50.gj AND JZG50.metrik_id = 50 AND
       JZG50.typ_id = 1 AND JZG50.level_id = ABT.abt_id * 1000000
   WHERE ABT.abt_id IN (6) /* Food Frische */
   GROUP BY PLN.mandant_id,
    PLN.nb_id,
    PLN.wup_id,
    PLN.wrg_id,
    ABT.abt_id,
    ZEIT.gj
   UNION ALL
   SELECT mandant_id,
    nb_id,
    wup_id,
    gj,
    wrg_id,
    abt_id,
    0 AS hwg_id,
    0 AS owg_id,
    1 AS typ_id,
    CAST(abt_id * 1000000 AS BIGNUMERIC) AS level_id,
    SUM(ums_owg_plan) AS ums_owg_plan,
    CAST(NULL AS BIGNUMERIC) AS inv_eingabe,
    CAST(NULL AS STRING) AS inv_kommentar,
    SUM(inv_wert) AS inv_wert
   FROM (SELECT PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      ZEIT.gj,
      PLN.wrg_id,
      ABT.abt_id,
      SUM(PLN.umsatz_netto_plan) AS ums_owg_plan,
       SUM(PLN.umsatz_netto_plan) * MAX(JZG50.wert_eingabe) AS inv_wert
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
      LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG50 ON PLN.mandant_id = JZG50.mandant_id AND
             PLN.wup_id = JZG50.wup_id AND PLN.wrg_id = JZG50.wrg_id AND ZEIT.gj = JZG50.gj AND JZG50.metrik_id = 50 AND
         JZG50.typ_id = 3 AND JZG50.level_id = ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id)
     WHERE ABT.abt_id = 5 /* Ultra Frische */
     GROUP BY PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      OWG.owg_id,
      HWG.hwg_id,
      ABT.abt_id,
      ZEIT.gj) AS plnsub
   GROUP BY mandant_id,
    nb_id,
    wup_id,
    gj,
    wrg_id,
    abt_id /* JZG Inventur_1 - Eingabe HWG Food Frische */
   UNION ALL
   SELECT PLN.mandant_id,
    PLN.nb_id,
    PLN.wup_id,
    ZEIT.gj,
    PLN.wrg_id,
    ABT.abt_id,
    HWG.hwg_id,
    0 AS owg_id,
    2 AS typ_id,
    CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
    SUM(PLN.umsatz_netto_plan) AS ums_owg_plan,
    MAX(JZG50.wert_eingabe) AS inv_eingabe,
    MAX(JZG50.kommentar_eingabe) AS inv_kommentar,
     SUM(PLN.umsatz_netto_plan) * MAX(JZG50.wert_eingabe) AS inv_wert
   FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
    INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG50 ON PLN.mandant_id = JZG50.mandant_id AND PLN
           .wup_id = JZG50.wup_id AND PLN.wrg_id = JZG50.wrg_id AND ZEIT.gj = JZG50.gj AND JZG50.metrik_id = 50 AND
       JZG50.typ_id = 2 AND JZG50.level_id = ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000
   WHERE HWG.hwg_id IN (65, 81, 82) /* Ultra Frische + Wurst SB alt/neu */
   GROUP BY PLN.mandant_id,
    PLN.nb_id,
    PLN.wup_id,
    PLN.wrg_id,
    HWG.hwg_id /* JZG Inventur_1 - Berechnung HWG Ultra Frische */,
    ABT.abt_id,
    ZEIT.gj
   UNION ALL
   SELECT mandant_id,
    nb_id,
    wup_id,
    gj,
    wrg_id,
    abt_id,
    hwg_id,
    0 AS owg_id,
    2 AS typ_id,
    CAST(abt_id * 1000000 + ABS(hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
    SUM(ums_owg_plan) AS ums_owg_plan,
    CAST(NULL AS BIGNUMERIC) AS inv_eingabe,
    CAST(NULL AS STRING) AS inv_kommentar,
    SUM(inv_wert) AS inv_wert
   FROM (SELECT PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      ZEIT.gj,
      PLN.wrg_id,
      ABT.abt_id,
      HWG.hwg_id,
      SUM(PLN.umsatz_netto_plan) AS ums_owg_plan,
       SUM(PLN.umsatz_netto_plan) * MAX(JZG50.wert_eingabe) AS inv_wert
     FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
      INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
      INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
      LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG50 ON PLN.mandant_id = JZG50.mandant_id AND
             PLN.wup_id = JZG50.wup_id AND PLN.wrg_id = JZG50.wrg_id AND ZEIT.gj = JZG50.gj AND JZG50.metrik_id = 50 AND
         JZG50.typ_id = 3 AND JZG50.level_id = ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id)
     WHERE ABT.abt_id = 5 /* Ultra Frische */
     GROUP BY PLN.mandant_id,
      PLN.nb_id,
      PLN.wup_id,
      PLN.wrg_id,
      OWG.owg_id,
      HWG.hwg_id,
      ABT.abt_id,
      ZEIT.gj) AS plnsub
   GROUP BY mandant_id,
    nb_id,
    wup_id,
    gj,
    wrg_id,
    abt_id,
    hwg_id /* JZG Inventur_1 - Eingabe OWG Ultra Frische */
   UNION ALL
   SELECT PLN.mandant_id,
    PLN.nb_id,
    PLN.wup_id,
    ZEIT.gj,
    PLN.wrg_id,
    ABT.abt_id,
    HWG.hwg_id,
    OWG.owg_id,
    3 AS typ_id,
    CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id) AS BIGNUMERIC) AS level_id,
    SUM(PLN.umsatz_netto_plan) AS ums_owg_plan,
    MAX(JZG50.wert_eingabe) AS inv_eingabe,
    MAX(JZG50.kommentar_eingabe) AS inv_kommentar,
     SUM(PLN.umsatz_netto_plan) * MAX(JZG50.wert_eingabe) AS inv_wert
   FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 AS PLN
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_1 AS OWG ON PLN.owg_id = OWG.owg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_1 AS HWG ON OWG.hwg_id = HWG.hwg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id
    INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON PLN.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
    LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG50 ON PLN.mandant_id = JZG50.mandant_id AND PLN
           .wup_id = JZG50.wup_id AND PLN.wrg_id = JZG50.wrg_id AND ZEIT.gj = JZG50.gj AND JZG50.metrik_id = 50 AND
       JZG50.typ_id = 3 AND JZG50.level_id = ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id)
   WHERE ABT.abt_id = 5 /* Ultra Frische */
   GROUP BY PLN.mandant_id,
    PLN.nb_id,
    PLN.wup_id,
    PLN.wrg_id,
    OWG.owg_id,
    HWG.hwg_id,
    ABT.abt_id,
    ZEIT.gj) AS vis_pln ON vis.mandant_id = vis_pln.mandant_id AND vis.wup_id = vis_pln.wup_id AND vis.wrg_id = vis_pln
    .wrg_id AND vis.gj /* JZG 700 - Personalkosten_1 FILIALE */ = vis_pln.gj
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 70 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 vis.pers_kosten_plan AS plan_gj1,
 vis.ums_netto_plan AS plan_gj2,
  IF(vis.pers_kosten_plan = 0, NULL, vis.pers_kosten_plan) / IF(vis.ums_netto_plan = 0, NULL, vis.ums_netto_plan) AS
 plan_gj,
 JZG70.wert_eingabe AS eingabe,
 CAST(NULL AS NUMERIC) AS anteil,
 JZG70.wert_eingabe AS ziel1,
 1 AS ziel2,
 COALESCE(JZG70.wert_eingabe, 0) AS ziel,
 COALESCE(JZG70.kommentar_eingabe, '') AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   ZEIT.gj,
   VIS.wrg_id,
   SUM(VIS.pers_kosten_plan) AS pers_kosten_plan,
   SUM(VIS.ums_netto_plan) AS ums_netto_plan
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo
  WHERE ZEIT.akt_gj = 0
   AND VIS.nb_id = 0
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_1 AS JZG70 ON vis.mandant_id = JZG70.mandant_id AND vis.wup_id
         = JZG70.wup_id AND vis.wrg_id = JZG70.wrg_id AND vis.gj = JZG70.gj AND JZG70.metrik_id = 70 AND JZG70.typ_id =
    0 AND JZG70.level_id = 0 /* JZG xx0-0 Dummies ohne Plan / Pflege */
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 jzg.metrik_id,
 0 AS typ_id,
 0 AS level_id,
 CAST(NULL AS BIGNUMERIC) AS wert_vj1,
 CAST(NULL AS BIGNUMERIC) AS wert_vj2,
 CAST(NULL AS BIGNUMERIC) AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS NUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS BIGNUMERIC) AS abw,
 '' AS kommentar
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = 0
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 INNER JOIN (SELECT 30 AS metrik_id
   UNION ALL
   SELECT 33 AS metrik_id
   UNION ALL
   SELECT 36 AS metrik_id
   UNION ALL
   SELECT 39 AS metrik_id
   UNION ALL
   SELECT 60 AS metrik_id
   UNION ALL
   SELECT 62 AS metrik_id
   UNION ALL
   SELECT 64 AS metrik_id
   UNION ALL
   SELECT 66 AS metrik_id
   UNION ALL
   SELECT 68 AS metrik_id
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
   SELECT 82 AS metrik_id
   UNION ALL
   SELECT 84 AS metrik_id
   UNION ALL
   SELECT 86 AS metrik_id
   UNION ALL
   SELECT 88 AS metrik_id
   UNION ALL
   SELECT 90 AS metrik_id
   UNION ALL
   SELECT 92 AS metrik_id
   UNION ALL
   SELECT 94 AS metrik_id
   UNION ALL
   SELECT 96 AS metrik_id
   UNION ALL
   SELECT 98 AS metrik_id) AS jzg ON TRUE;
