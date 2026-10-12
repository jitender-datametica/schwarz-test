/* Plan Ware */ /* JZG 502-xxx0000 - Inventur_2 HWG */ /* JZG HWG - Abschriften_2 Ware */ /* JZG OWG - Plan */
/* Plan Ware */ /* IN WRG_2 */ /* JZG Filiale - REKL_2 */ /* IN PROZ */ /* JZG 330-0 - Scans/min Filiale */
/* Umsatz Inventur_2 */ /* Kunden Filiale */ /* NOK */ /* JZG Abteilung - Plan VJ */
/* JZG Abteilung - Abschriften_2 Ware */ /* Umsatz KER */ /* JZG Filiale - MAIN */ /* IN PROZ */ /* kein Plan */
/* Umsatz Ware */ /* IN PROZ.PKT */ /* JZG OWG - Abschriften_2 Ware */ /* JZG Abteilung - Umsatz Ware */ /* Plan Ware */
/* IN WRG_2/h */ /* IN PROZ.PKT */ /* IN PROZ */ /* Stunden_2 Filiale */ /* JZG HWG - Plan VJ */ /* JZG Filiale - MAIN */
/* JZG Filiale - SHR_URLAUB */ /* JZG 503-5xxxxxx - Inventur_2 OWG */ /* JZG Filiale - SHR_WUP_FUNKTION */
/* JZG Filiale - Umsatz Ware */ /* JZG230-0 - Nettoleistung Filiale */ /* JZG Filiale - REKL_2 */
/* JZG Abteilung - Plan Ware */ /* Umsatz Ware */ /* JZG 400-0 - Abschriften_2 Filiale */
/* JZG Filiale - Abschriften_2 Ware */ /* Plan Ware */ /* IN PROZ */ /* kein Plan */ /* JZG Filiale - REKL_2 */
/* kein Plan */ /* Umsatz Ware */ /* Umsatz Ware */ /* JZG OWG - Umsatz Ware */ /* IN WRG_2/h */
/* JZG 390-0 - SCO Nutzung Kunde */ /* IN PROZ */ /* Umsatz Ware */ /* Umsatz Inventur_2 */
/* JZG160-00 - Ø Bon Filiale */ /* JZG OWG - Plan Ware */ /* JZG Filiale */ /* Plan Ware */ /* kein Plan */
/* JZG 100-0 - Umsatz Filiale */ /* JZG Filiale - MAIN */ /* IN WRG_2 */ /* JZG Filiale - MAIN */ /* IN WRG_2 */
/* Umsatz Ware */ /* JZG Dummies */ /* JZG 300-0 - Kassierleistung Filiale */ /* kein Plan */ /* Umsatz Inventur_2 */
/* JZG Inventur_2 - Filiale */ /* JZG 360-0 - SCO Nutzung Umsatz */ /* Kunden Filiale */
/* JZG 501-x000000 - Inventur_2 Abteilung */ /* IN PROZ */ /* Plan Ware */ /* JZG xxx_2 - Personal/MA/TOP */
/* Umsatz KER */ /* Plan Ware */ /* Plan Filiale */ /* Umsatz KER */ /* IN PROZ */ /* JZG Filiale - MAIN */
/* JZG 780 - Resturlaub KJ Ende */ /* JZG Filiale */ /* JZG Filiale - MDL */ /* kein Plan */ /* IN PROZ */ /* IN PROZ */
/* JZG Inventur_2 - Filiale */ /* JZG200-0 - Nettoleistung Filiale */ /* kein Plan */ /* JZG Filiale - Plan Ware */
/* IN PROZ.PKT */ /* JZG Inventur_2 - Filiale */ /* kein Plan */ /* Umsatz KER */ /* Stunden_2 Filiale */
/* JZG HWG - Plan Ware */ /* JZG Filiale - MAIN */ /* IN WRG_2 */ /* JZG OWG - Umsatz */ /* IN PROZ.PKT */
/* FAKT DENORM JZG - Jahreszielgespräch VJ / Plan VJ / Abw.
   2023-02-21 ssch0611 : MAIN mit Personal/MA. AP0144461
   2023-02-24 ssch0611 : Finetuning & Bugfix. 
   2023-10-18 TEMP VERSION kassentyp */
/* kein Plan */ /* IN h */ /* JZG 600-0 - Kundenfeedback MDL Filiale */ /* JZG HWG - Umsatz Ware */ /* kein Plan */
/* Stunden_2 Filiale */ /* kein Plan */ /* JZG Filiale - MAIN */ /* JZG HWG - Umsatz Ware */ /* JZG Inventur_2 - Filiale */
/* JZG Filiale - MAIN */ /* IN PROZ */ /* kein Plan */ /* Umsatz Ware */ /* JZG 101-x000000 - Umsatz Abteilung */
/* IN PROZ */ /* JZG Abteilung - Umsatz Ware */ /* JZG Filiale - MAIN */ /* NOK */
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jzg_data_rest_2 (mandant_id, nb_id, wup_id, wrg_id, gj,
metrik_id, typ_id, level_id, wert_vj1, wert_vj2, wert_vj, plan_vj1, plan_vj2, plan_vj, delta, abw) AS SELECT VIS.mandant_id
 ,
 VIS.nb_id,
 VIS.wup_id,
 VIS.wrg_id,
  ZEIT.gj + 1 AS gj,
 10 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 SUM(VIS.ums_netto) AS wert_vj1,
 1.00 AS wert_vj2,
 SUM(VIS.ums_netto) AS wert_vj,
 SUM(VIS.ums_netto_plan) AS plan_vj1,
 1.00 AS plan_vj2,
 SUM(VIS.ums_netto_plan) AS plan_vj,
  SUM(VIS.ums_netto) - SUM(VIS.ums_netto_plan) AS delta,
   (SUM(VIS.ums_netto) - SUM(VIS.ums_netto_plan)) / IF(SUM(VIS.ums_netto_plan) = 0, NULL, SUM(VIS.ums_netto_plan)) AS
 abw
FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
 INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
GROUP BY VIS.mandant_id,
 VIS.nb_id,
 VIS.wup_id,
 VIS.wrg_id,
 ZEIT.gj
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 10 AS metrik_id,
 1 AS typ_id,
 CAST(CASE
   WHEN vis.abt_id = 4
   THEN 9999999
   ELSE vis.abt_id * 1000000
   END AS BIGNUMERIC) AS level_id,
 vis.ums_netto AS wert_vj1,
 1.00 AS wert_vj2,
 vis.ums_netto AS wert_vj,
 plan.ums_netto_plan AS plan_vj1,
 1.00 AS plan_vj2,
 plan.ums_netto_plan AS plan_vj,
  vis.ums_netto - plan.ums_netto_plan AS delta,
   (vis.ums_netto - plan.ums_netto_plan) / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan) AS abw
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
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   ABT.abt_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT0.gj,
   ABT0.abt_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_netto_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_netto_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG0 ON PLAN.owg_id = OWG0.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG0 ON OWG0.hwg_id = HWG0.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT0 ON HWG0.abt_id = ABT0.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT0 ON PLAN.kjmo = ZEIT0.kjmo AND ZEIT0.akt_gj = - 1
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ABT0.abt_id,
   ZEIT0.gj) AS plan ON vis.mandant_id = plan.mandant_id AND vis.wup_id = plan.wup_id AND vis.wrg_id = plan.wrg_id AND
    vis.gj = plan.gj AND vis.abt_id /* JZG 102-xxx0000 - UMSATZ HWG */ = plan.abt_id
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 10 AS metrik_id,
 2 AS typ_id,
 CAST(vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
 vis.ums_netto AS wert_vj1,
 1.00 AS wert_vj2,
 vis.ums_netto AS wert_vj,
 plan.ums_netto_plan AS plan_vj1,
 1.00 AS plan_vj2,
 plan.ums_netto_plan AS plan_vj,
  vis.ums_netto - plan.ums_netto_plan AS delta,
   (vis.ums_netto - plan.ums_netto_plan) / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan) AS abw
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
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT1.gj,
   ABT1.abt_id,
   HWG1.hwg_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_netto_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_netto_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT1 ON PLAN.kjmo = ZEIT1.kjmo
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG1 ON PLAN.owg_id = OWG1.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG1 ON OWG1.hwg_id = HWG1.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT1 ON HWG1.abt_id = ABT1.abt_id
  WHERE ZEIT1.akt_gj = - 1
   AND PLAN.nb_id = 0
   AND ABT1.abt_id IN (5, 6)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT1.gj,
   HWG1.hwg_id,
   ABT1.abt_id) AS plan ON vis.mandant_id = plan.mandant_id AND vis.wup_id = plan.wup_id AND vis.wrg_id = plan.wrg_id
   AND vis.gj = plan.gj AND vis.hwg_id /* JZG 103-5xxxxxx - Umsatz OWG */ = plan.hwg_id
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 10 AS metrik_id,
 3 AS typ_id,
 CAST(vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 + ABS(vis.owg_id) AS BIGNUMERIC) AS level_id,
 vis.ums_netto AS wert_vj1,
 1.00 AS wert_vj2,
 vis.ums_netto AS wert_vj,
 plan.ums_netto_plan AS plan_vj1,
 1.00 AS plan_vj2,
 plan.ums_netto_plan AS plan_vj,
  vis.ums_netto - plan.ums_netto_plan AS delta,
   (vis.ums_netto - plan.ums_netto_plan) / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan) AS abw
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
  WHERE ABT.abt_id = 5
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   OWG.owg_id,
   HWG.hwg_id,
   ABT.abt_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT2.gj,
   ABT2.abt_id,
   HWG2.hwg_id,
   OWG2.owg_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_netto_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT2 ON PLAN.kjmo = ZEIT2.kjmo
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG2 ON PLAN.owg_id = OWG2.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG2 ON OWG2.hwg_id = HWG2.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT2 ON HWG2.abt_id = ABT2.abt_id
  WHERE ZEIT2.akt_gj = - 1
   AND PLAN.nb_id = 0
   AND ABT2.abt_id IN (5)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT2.gj,
   OWG2.owg_id,
   HWG2.hwg_id,
   ABT2.abt_id) AS plan ON vis.mandant_id = plan.mandant_id AND vis.wup_id = plan.wup_id AND vis.wrg_id = plan.wrg_id
   AND vis.gj = plan.gj AND vis.owg_id /* JZG130-0 - Kunden Filiale */ = plan.owg_id
UNION ALL
SELECT VIS.mandant_id,
 VIS.nb_id,
 VIS.wup_id,
 VIS.wrg_id,
  ZEIT.gj + 1 AS gj,
 13 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 SUM(VIS.anz_kunde) AS wert_vj1,
 1.00 AS wert_vj2,
 SUM(VIS.anz_kunde) AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS NUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
 INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
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
 16 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 SUM(VIS.ums_netto) AS wert_vj1,
 SUM(VIS.anz_kunde) AS wert_vj2,
  SUM(VIS.ums_netto) / IF(SUM(VIS.anz_kunde) = 0, NULL, SUM(VIS.anz_kunde)) AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS NUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
 INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
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
 20 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 SUM(VIS.ums_netto) AS wert_vj1,
 SUM(VIS.pers_std) AS wert_vj2,
  SUM(VIS.ums_netto) / IF(SUM(VIS.anz_kunde) = 0, NULL, SUM(VIS.anz_kunde)) AS wert_vj,
 SUM(VIS.ums_netto_plan) AS plan_vj1,
 SUM(VIS.pers_std_plan) AS plan_vj2,
  SUM(VIS.ums_netto_plan) / IF(SUM(VIS.pers_std_plan) = 0, NULL, SUM(VIS.pers_std_plan)) AS plan_vj,
   SUM(VIS.ums_netto) / IF(SUM(VIS.anz_kunde) = 0, NULL, SUM(VIS.anz_kunde)) - SUM(VIS.ums_netto_plan) / IF(SUM(VIS.pers_std_plan
      ) = 0, NULL, SUM(VIS.pers_std_plan)) AS delta,
   (SUM(VIS.ums_netto) / IF(SUM(VIS.anz_kunde) = 0, NULL, SUM(VIS.anz_kunde)) - SUM(VIS.ums_netto_plan) / IF(SUM(VIS.pers_std_plan
        ) = 0, NULL, SUM(VIS.pers_std_plan))) / IF(SUM(VIS.ums_netto_plan) / IF(SUM(VIS.pers_std_plan) = 0, NULL, SUM(VIS
       .pers_std_plan)) = 0, NULL, SUM(VIS.ums_netto_plan) / IF(SUM(VIS.pers_std_plan) = 0, NULL, SUM(VIS.pers_std_plan
      ))) AS abw
FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
 INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
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
 23 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 SUM(VIS.pers_std) AS wert_vj1,
 1.00 AS wert_vj2,
 SUM(VIS.pers_std) AS wert_vj,
 SUM(VIS.pers_std_plan) AS plan_vj1,
 1.00 AS plan_vj2,
 SUM(VIS.pers_std_plan) AS plan_vj,
  SUM(VIS.pers_std) - SUM(VIS.pers_std_plan) AS delta,
   (SUM(VIS.pers_std) - SUM(VIS.pers_std_plan)) / IF(SUM(VIS.pers_std_plan) = 0, NULL, SUM(VIS.pers_std_plan)) AS abw
FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
 INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
GROUP BY VIS.mandant_id,
 VIS.nb_id,
 VIS.wup_id,
 VIS.wrg_id,
 ZEIT.gj
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 40 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 visabs.abs_netto AS wert_vj1,
 vis.ums_netto AS wert_vj2,
  visabs.abs_netto / IF(vis.ums_netto = 0, NULL, vis.ums_netto) AS wert_vj,
 plan.abs_netto_plan AS plan_vj1,
 plan.ums_netto_plan AS plan_vj2,
  plan.abs_netto_plan / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan) AS plan_vj,
   (visabs.abs_netto / IF(vis.ums_netto = 0, NULL, vis.ums_netto) - plan.abs_netto_plan / IF(plan.ums_netto_plan = 0,
      NULL, plan.ums_netto_plan)) * 100 AS delta,
    (visabs.abs_netto / IF(vis.ums_netto = 0, NULL, vis.ums_netto) - plan.abs_netto_plan / IF(plan.ums_netto_plan = 0,
       NULL, plan.ums_netto_plan)) * - 1 / IF(plan.abs_netto_plan / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan
      ) = 0, NULL, plan.abs_netto_plan / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan)) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.ums_netto) AS ums_netto
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 INNER JOIN (SELECT VIS0.mandant_id,
   VIS0.nb_id,
   VIS0.wup_id,
   ZEIT3.gj,
   VIS0.wrg_id,
   SUM(CASE
      WHEN VIS0.mandant_id IN (6) AND VIS0.abschriftart_id = 2 OR VIS0.mandant_id IN (3) AND VIS0.abschriftart_id = 11
         OR VIS0.mandant_id IN (2, 4, 5, 7, 8) AND VIS0.abschriftart_id = 7 OR VIS0.mandant_id IN (2, 5) AND VIS0.abschriftart_id
           = 10 OR VIS0.abschriftart_id = 20 AND VIS0.mandant_id NOT IN (1)
      THEN 1
      ELSE - 1
      END * VIS0.abschrift_netto) AS abs_netto
  FROM kfl_production_dbp_msi_data.vis_tag_abschriften_wg_2 AS VIS0
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu_2 AS AAZ ON VIS0.abschriftart_id = AAZ.abschriftart_id
      AND VIS0.mandant_id = AAZ.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu_2 AS ATZ ON AAZ.abschriftart_int_id = ATZ.abschriftart_int_id
    
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT3 ON VIS0.kjmo = ZEIT3.kjmo AND ZEIT3.akt_gj = - 1
  WHERE ATZ.abschriftart_thema_int_id IN (1, 4)
  GROUP BY VIS0.mandant_id,
   VIS0.nb_id,
   VIS0.wup_id,
   ZEIT3.gj,
   VIS0.wrg_id) AS visabs ON vis.mandant_id = visabs.mandant_id AND vis.wup_id = visabs.wup_id AND vis.wrg_id = visabs.wrg_id
     AND vis.gj = visabs.gj
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT4.gj,
   SUM(PLAN.umsatz_netto_plan) AS ums_netto_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_netto_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT4 ON PLAN.kjmo = ZEIT4.kjmo AND ZEIT4.akt_gj = - 1
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT4.gj) AS plan ON vis.mandant_id = plan.mandant_id AND vis.wup_id = plan.wup_id AND vis.wrg_id = plan.wrg_id AND
   vis.gj /* JZG 401-x000000 - Abschriften_2 Abteilung */ = plan.gj
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 40 AS metrik_id,
 1 AS typ_id,
 CAST(CASE
   WHEN vis.abt_id = 4
   THEN 9999999
   ELSE vis.abt_id * 1000000
   END AS BIGNUMERIC) AS level_id,
 visabs.abs_netto AS wert_vj1,
 vis.ums_netto AS wert_vj2,
  visabs.abs_netto / IF(vis.ums_netto = 0, NULL, vis.ums_netto) AS wert_vj,
 plan.abs_netto_plan AS plan_vj1,
 plan.ums_netto_plan AS plan_vj2,
  plan.abs_netto_plan / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan) AS plan_vj,
   (visabs.abs_netto / IF(vis.ums_netto = 0, NULL, vis.ums_netto) - plan.abs_netto_plan / IF(plan.ums_netto_plan = 0,
      NULL, plan.ums_netto_plan)) * 100 AS delta,
    (visabs.abs_netto / IF(vis.ums_netto = 0, NULL, vis.ums_netto) - plan.abs_netto_plan / IF(plan.ums_netto_plan = 0,
       NULL, plan.ums_netto_plan)) * - 1 / IF(plan.abs_netto_plan / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan
      ) = 0, NULL, plan.abs_netto_plan / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan)) AS abw
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
  WHERE ABT.abt_id > 0
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   ABT.abt_id,
   ZEIT.gj) AS vis
 INNER JOIN (SELECT VIS1.mandant_id,
   VIS1.nb_id,
   VIS1.wup_id,
   ZEIT5.gj,
   VIS1.wrg_id,
   ABT3.abt_id,
   SUM(CASE
      WHEN VIS1.mandant_id IN (6) AND VIS1.abschriftart_id = 2 OR VIS1.mandant_id IN (3) AND VIS1.abschriftart_id = 11
         OR VIS1.mandant_id IN (2, 4, 5, 7, 8) AND VIS1.abschriftart_id = 7 OR VIS1.mandant_id IN (2, 5) AND VIS1.abschriftart_id
           = 10 OR VIS1.abschriftart_id = 20 AND VIS1.mandant_id NOT IN (1)
      THEN 1
      ELSE - 1
      END * VIS1.abschrift_netto) AS abs_netto
  FROM kfl_production_dbp_msi_data.vis_tag_abschriften_wg_2 AS VIS1
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG0 ON VIS1.wg_id = WG0.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG3 ON WG0.owg_id = OWG3.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG3 ON OWG3.hwg_id = HWG3.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT3 ON HWG3.abt_id = ABT3.abt_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu_2 AS AAZ ON VIS1.abschriftart_id = AAZ.abschriftart_id
      AND VIS1.mandant_id = AAZ.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu_2 AS ATZ ON AAZ.abschriftart_int_id = ATZ.abschriftart_int_id
    
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT5 ON VIS1.kjmo = ZEIT5.kjmo AND ZEIT5.akt_gj = - 1
  WHERE ATZ.abschriftart_thema_int_id IN (1, 4)
   AND ABT3.abt_id > 0
  GROUP BY VIS1.mandant_id,
   VIS1.nb_id,
   VIS1.wup_id,
   ZEIT5.gj,
   VIS1.wrg_id,
   ABT3.abt_id) AS visabs ON vis.mandant_id = visabs.mandant_id AND vis.wup_id = visabs.wup_id AND vis.wrg_id = visabs.wrg_id
      AND vis.gj = visabs.gj AND vis.abt_id = visabs.abt_id
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT6.gj,
   ABT4.abt_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_netto_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_netto_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG4 ON PLAN.owg_id = OWG4.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG4 ON OWG4.hwg_id = HWG4.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT4 ON HWG4.abt_id = ABT4.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT6 ON PLAN.kjmo = ZEIT6.kjmo AND ZEIT6.akt_gj = - 1
  WHERE ABT4.abt_id > 0
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ABT4.abt_id,
   ZEIT6.gj) AS plan ON vis.mandant_id = plan.mandant_id AND vis.wup_id = plan.wup_id AND vis.wrg_id = plan.wrg_id AND
    vis.gj = plan.gj AND vis.abt_id /* JZG 402-xxx0000 - Abschriften_2 HWG */ = plan.abt_id
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 40 AS metrik_id,
 2 AS typ_id,
 CAST(vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
 visabs.abs_netto AS wert_vj1,
 vis.ums_netto AS wert_vj2,
  visabs.abs_netto / IF(vis.ums_netto = 0, NULL, vis.ums_netto) AS wert_vj,
 plan.abs_netto_plan AS plan_vj1,
 plan.ums_netto_plan AS plan_vj2,
  plan.abs_netto_plan / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan) AS plan_vj,
   (visabs.abs_netto / IF(vis.ums_netto = 0, NULL, vis.ums_netto) - plan.abs_netto_plan / IF(plan.ums_netto_plan = 0,
      NULL, plan.ums_netto_plan)) * 100 AS delta,
    (visabs.abs_netto / IF(vis.ums_netto = 0, NULL, vis.ums_netto) - plan.abs_netto_plan / IF(plan.ums_netto_plan = 0,
       NULL, plan.ums_netto_plan)) * - 1 / IF(plan.abs_netto_plan / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan
      ) = 0, NULL, plan.abs_netto_plan / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan)) AS abw
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
   ZEIT.gj) AS vis
 INNER JOIN (SELECT VIS2.mandant_id,
   VIS2.nb_id,
   VIS2.wup_id,
   ZEIT7.gj,
   VIS2.wrg_id,
   ABT5.abt_id,
   HWG5.hwg_id,
   SUM(CASE
      WHEN VIS2.mandant_id IN (6) AND VIS2.abschriftart_id = 2 OR VIS2.mandant_id IN (3) AND VIS2.abschriftart_id = 11
         OR VIS2.mandant_id IN (2, 4, 5, 7, 8) AND VIS2.abschriftart_id = 7 OR VIS2.mandant_id IN (2, 5) AND VIS2.abschriftart_id
           = 10 OR VIS2.abschriftart_id = 20 AND VIS2.mandant_id NOT IN (1)
      THEN 1
      ELSE - 1
      END * VIS2.abschrift_netto) AS abs_netto
  FROM kfl_production_dbp_msi_data.vis_tag_abschriften_wg_2 AS VIS2
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG1 ON VIS2.wg_id = WG1.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG5 ON WG1.owg_id = OWG5.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG5 ON OWG5.hwg_id = HWG5.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT5 ON HWG5.abt_id = ABT5.abt_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu_2 AS AAZ ON VIS2.abschriftart_id = AAZ.abschriftart_id
      AND VIS2.mandant_id = AAZ.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu_2 AS ATZ ON AAZ.abschriftart_int_id = ATZ.abschriftart_int_id
    
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT7 ON VIS2.kjmo = ZEIT7.kjmo AND ZEIT7.akt_gj = - 1
  WHERE ATZ.abschriftart_thema_int_id IN (1, 4)
   AND ABT5.abt_id IN (5, 6)
  GROUP BY VIS2.mandant_id,
   VIS2.nb_id,
   VIS2.wup_id,
   ZEIT7.gj,
   VIS2.wrg_id,
   ABT5.abt_id,
   HWG5.hwg_id) AS visabs ON vis.mandant_id = visabs.mandant_id AND vis.wup_id = visabs.wup_id AND vis.wrg_id = visabs.wrg_id
      AND vis.gj = visabs.gj AND vis.hwg_id = visabs.hwg_id
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT8.gj,
   ABT6.abt_id,
   HWG6.hwg_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_netto_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_netto_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG6 ON PLAN.owg_id = OWG6.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG6 ON OWG6.hwg_id = HWG6.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT6 ON HWG6.abt_id = ABT6.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT8 ON PLAN.kjmo = ZEIT8.kjmo AND ZEIT8.akt_gj = - 1
  WHERE ABT6.abt_id IN (5, 6)
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   HWG6.hwg_id,
   ABT6.abt_id,
   ZEIT8.gj) AS plan ON vis.mandant_id = plan.mandant_id AND vis.wup_id = plan.wup_id AND vis.wrg_id = plan.wrg_id AND
    vis.gj = plan.gj AND vis.hwg_id /* JZG 403-5xxxxxx - Abschriften_2 OWG */ = plan.hwg_id
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 40 AS metrik_id,
 3 AS typ_id,
 CAST(vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 + ABS(vis.owg_id) AS BIGNUMERIC) AS level_id,
 visabs.abs_netto AS wert_vj1,
 vis.ums_netto AS wert_vj2,
  visabs.abs_netto / IF(vis.ums_netto = 0, NULL, vis.ums_netto) AS wert_vj,
 plan.abs_netto_plan AS plan_vj1,
 plan.ums_netto_plan AS plan_vj2,
  plan.abs_netto_plan / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan) AS plan_vj,
   (visabs.abs_netto / IF(vis.ums_netto = 0, NULL, vis.ums_netto) - plan.abs_netto_plan / IF(plan.ums_netto_plan = 0,
      NULL, plan.ums_netto_plan)) * 100 AS delta,
    (visabs.abs_netto / IF(vis.ums_netto = 0, NULL, vis.ums_netto) - plan.abs_netto_plan / IF(plan.ums_netto_plan = 0,
       NULL, plan.ums_netto_plan)) * - 1 / IF(plan.abs_netto_plan / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan
      ) = 0, NULL, plan.abs_netto_plan / IF(plan.ums_netto_plan = 0, NULL, plan.ums_netto_plan)) AS abw
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
  WHERE ABT.abt_id = 5
  GROUP BY VIS.mandant_id,
   VIS.wup_id,
   VIS.nb_id,
   VIS.wrg_id,
   OWG.owg_id,
   HWG.hwg_id,
   ABT.abt_id,
   ZEIT.gj) AS vis
 INNER JOIN (SELECT VIS3.mandant_id,
   VIS3.nb_id,
   VIS3.wup_id,
   ZEIT9.gj,
   VIS3.wrg_id,
   ABT7.abt_id,
   HWG7.hwg_id,
   OWG7.owg_id,
   SUM(CASE
      WHEN VIS3.mandant_id IN (6) AND VIS3.abschriftart_id = 2 OR VIS3.mandant_id IN (3) AND VIS3.abschriftart_id = 11
         OR VIS3.mandant_id IN (2, 4, 5, 7, 8) AND VIS3.abschriftart_id = 7 OR VIS3.mandant_id IN (2, 5) AND VIS3.abschriftart_id
           = 10 OR VIS3.abschriftart_id = 20 AND VIS3.mandant_id NOT IN (1)
      THEN 1
      ELSE - 1
      END * VIS3.abschrift_netto) AS abs_netto
  FROM kfl_production_dbp_msi_data.vis_tag_abschriften_wg_2 AS VIS3
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS WG2 ON VIS3.wg_id = WG2.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG7 ON WG2.owg_id = OWG7.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG7 ON OWG7.hwg_id = HWG7.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT7 ON HWG7.abt_id = ABT7.abt_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu_2 AS AAZ ON VIS3.abschriftart_id = AAZ.abschriftart_id
      AND VIS3.mandant_id = AAZ.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu_2 AS ATZ ON AAZ.abschriftart_int_id = ATZ.abschriftart_int_id
    
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT9 ON VIS3.kjmo = ZEIT9.kjmo AND ZEIT9.akt_gj = - 1
  WHERE ATZ.abschriftart_thema_int_id IN (1, 4)
   AND ABT7.abt_id = 5
  GROUP BY VIS3.mandant_id,
   VIS3.nb_id,
   VIS3.wup_id,
   ZEIT9.gj,
   VIS3.wrg_id,
   ABT7.abt_id,
   HWG7.hwg_id,
   OWG7.owg_id) AS visabs ON vis.mandant_id = visabs.mandant_id AND vis.wup_id = visabs.wup_id AND vis.wrg_id = visabs.wrg_id
      AND vis.gj = visabs.gj AND vis.owg_id = visabs.owg_id
 LEFT JOIN (SELECT PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   ZEIT10.gj,
   ABT8.abt_id,
   HWG8.hwg_id,
   OWG8.owg_id,
   SUM(PLAN.umsatz_netto_plan) AS ums_netto_plan,
   SUM(PLAN.abschriften_netto_operativ_plan) AS abs_netto_plan
  FROM kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 AS PLAN
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG8 ON PLAN.owg_id = OWG8.owg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG8 ON OWG8.hwg_id = HWG8.hwg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT8 ON HWG8.abt_id = ABT8.abt_id
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT10 ON PLAN.kjmo = ZEIT10.kjmo AND ZEIT10.akt_gj = - 1
  WHERE ABT8.abt_id = 5
  GROUP BY PLAN.mandant_id,
   PLAN.nb_id,
   PLAN.wup_id,
   PLAN.wrg_id,
   OWG8.owg_id,
   HWG8.hwg_id,
   ABT8.abt_id,
   ZEIT10.gj) AS plan ON vis.mandant_id = plan.mandant_id AND vis.wup_id = plan.wup_id AND vis.wrg_id = plan.wrg_id AND
    vis.gj = plan.gj AND vis.owg_id /* JZG 500-0 - Inventur_2 Filiale */ = plan.owg_id
UNION ALL
SELECT VIS_INV.mandant_id,
 VIS_INV.nb_id,
 VIS_INV.wup_id,
 VIS_INV.wrg_id,
  VIS_INV.gj + 1 AS gj,
 50 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 SUM(VIS_INV.inventur_wert_netto) AS wert_vj1,
 SUM(VIS_INV.inventur_ums_netto) AS wert_vj2,
  SUM(VIS_INV.inventur_wert_netto) / IF(SUM(VIS_INV.inventur_ums_netto) = 0, NULL, SUM(VIS_INV.inventur_ums_netto)) AS
 wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur_2 AS VIS_INV
 INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT_2 ON VIS_INV.dat_plan_zaehlung = ZEIT.dat AND ZEIT.akt_gj = - 1
WHERE VIS_INV.inventurart_int_id IN (8)
GROUP BY VIS_INV.mandant_id,
 VIS_INV.nb_id,
 VIS_INV.wup_id,
 VIS_INV.gj,
 VIS_INV.wrg_id
UNION ALL
SELECT VIS_INV.mandant_id,
 VIS_INV.nb_id,
 VIS_INV.wup_id,
 VIS_INV.wrg_id,
  VIS_INV.gj + 1 AS gj,
 50 AS metrik_id,
 1 AS typ_id,
 CAST(CASE
   WHEN ABT.abt_id = 4
   THEN 9999999
   ELSE ABT.abt_id * 1000000
   END AS BIGNUMERIC) AS level_id,
 SUM(VIS_INV.inventur_wert_netto) AS wert_vj1,
 SUM(VIS_INV.inventur_ums_netto) AS wert_vj2,
  SUM(VIS_INV.inventur_wert_netto) / IF(SUM(VIS_INV.inventur_ums_netto) = 0, NULL, SUM(VIS_INV.inventur_ums_netto)) AS
 wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur_2 AS VIS_INV
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG ON VIS_INV.owg_id = OWG.owg_id
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG ON OWG.hwg_id = HWG.hwg_id
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT_2 ON HWG.abt_id = ABT.abt_id
 INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT_2 ON VIS_INV.dat_plan_zaehlung = ZEIT.dat AND ZEIT.akt_gj = - 1
WHERE VIS_INV.inventurart_int_id IN (8)
 AND ABT.abt_id IN (5, 6)
GROUP BY VIS_INV.mandant_id,
 VIS_INV.nb_id,
 VIS_INV.wup_id,
 VIS_INV.gj,
 VIS_INV.wrg_id,
 ABT.abt_id
UNION ALL
SELECT VIS_INV.mandant_id,
 VIS_INV.nb_id,
 VIS_INV.wup_id,
 VIS_INV.wrg_id,
  VIS_INV.gj + 1 AS gj,
 50 AS metrik_id,
 2 AS typ_id,
 CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 AS BIGNUMERIC) AS level_id,
 SUM(VIS_INV.inventur_wert_netto) AS wert_vj1,
 SUM(VIS_INV.inventur_ums_netto) AS wert_vj2,
  SUM(VIS_INV.inventur_wert_netto) / IF(SUM(VIS_INV.inventur_ums_netto) = 0, NULL, SUM(VIS_INV.inventur_ums_netto)) AS
 wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur_2 AS VIS_INV
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG ON VIS_INV.owg_id = OWG.owg_id
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG ON OWG.hwg_id = HWG.hwg_id
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT_2 ON HWG.abt_id = ABT.abt_id
 INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT_2 ON VIS_INV.dat_plan_zaehlung = ZEIT.dat AND ZEIT.akt_gj = - 1
WHERE VIS_INV.inventurart_int_id IN (8)
 AND HWG.hwg_id IN (60, 61, 62, 63, 64, 65, 81)
GROUP BY VIS_INV.mandant_id,
 VIS_INV.nb_id,
 VIS_INV.wup_id,
 VIS_INV.gj,
 VIS_INV.wrg_id,
 HWG.hwg_id,
 ABT.abt_id
UNION ALL
SELECT VIS_INV.mandant_id,
 VIS_INV.nb_id,
 VIS_INV.wup_id,
 VIS_INV.wrg_id,
  VIS_INV.gj + 1 AS gj,
 50 AS metrik_id,
 3 AS typ_id,
 CAST(ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id) AS BIGNUMERIC) AS level_id,
 SUM(VIS_INV.inventur_wert_netto) AS wert_vj1,
 SUM(VIS_INV.inventur_ums_netto) AS wert_vj2,
  SUM(VIS_INV.inventur_wert_netto) / IF(SUM(VIS_INV.inventur_ums_netto) = 0, NULL, SUM(VIS_INV.inventur_ums_netto)) AS
 wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur_2 AS VIS_INV
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS OWG ON VIS_INV.owg_id = OWG.owg_id
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS HWG ON OWG.hwg_id = HWG.hwg_id
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_2 AS ABT_2 ON HWG.abt_id = ABT.abt_id
 INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT_2 ON VIS_INV.dat_plan_zaehlung = ZEIT.dat AND ZEIT.akt_gj = - 1
WHERE VIS_INV.inventurart_int_id IN (8)
 AND ABT.abt_id = 5
GROUP BY VIS_INV.mandant_id,
 VIS_INV.nb_id,
 VIS_INV.wup_id,
 VIS_INV.gj,
 VIS_INV.wrg_id,
 OWG.owg_id,
 HWG.hwg_id,
 ABT.abt_id
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 60 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 mdl.mdl_festell AS wert_vj1,
 mdl.mdl_anzahl AS wert_vj2,
  IFNULL(mdl.mdl_festell, 0) / IF(mdl.mdl_anzahl = 0, NULL, mdl.mdl_anzahl) AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.anz_kunde) AS anz_kunde
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT A11.mandant_id,
   A11.nb_id,
   A11.wup_id,
   ZEIT11.gj,
    CASE
    WHEN MAX(CASE
       WHEN A16.nok_fg = 1
       THEN 1
       ELSE 0
       END) = 1
    THEN COUNT(CASE
      WHEN A16.nok_fg = 1
      THEN A11.feedback_id
      ELSE NULL
      END)
    ELSE NULL
    END AS mdl_festell,
    CASE
    WHEN MAX(CASE
       WHEN A16.nok_fg <> 2
       THEN 1
       ELSE 0
       END) = 1
    THEN COUNT(CASE
      WHEN A16.nok_fg <> 2
      THEN A11.feedback_id
      ELSE NULL
      END)
    ELSE NULL
    END AS mdl_anzahl
  FROM kfl_production_dbp_msi_view_vis.mv_mdl_feedback_2 AS A11
   INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT11 ON A11.dat_einkauf = ZEIT11.dat AND ZEIT11.akt_gj = - 1
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_mdl_frage_befragung_bereich_kategorie_zu_2 AS A14 ON A11.frage_id = A14.frage_id
    
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_mdl_frage_antwort_zu_2 AS A16 ON A11.antwort_id = A16.antwort_id AND A11
     .frage_id = A16.frage_id
  WHERE A14.befragung_id IN (10)
   AND A14.kategorie_gruppe_id = 1000
   AND A14.bereich_id IN (10)
   AND A16.nok_fg <> 2
   AND (A11.mandant_id <> 1 OR A11.mandant_id = 1 AND A11.de_wup_load_fg = 1)
  GROUP BY A11.mandant_id,
   A11.nb_id,
   A11.wup_id,
   ZEIT11.gj) AS mdl ON vis.mandant_id = mdl.mandant_id AND vis.wup_id = mdl.wup_id AND vis.gj
   /* JZG 620-0 - Kurzcheck AMX Filiale */ = mdl.gj
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 62 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 amx2.kc_feststell AS wert_vj1,
 amx1.kc_anzahl AS wert_vj2,
  IFNULL(amx2.kc_feststell, 0) / IF(amx1.kc_anzahl = 0, NULL, amx1.kc_anzahl) AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.anz_kunde) AS anz_kunde
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT A15.mandant_id,
   A15.wup_id,
   ZEIT12.gj,
   COUNT(A11.amx_frage_id) AS kc_anzahl
  FROM kfl_production_dbp_msi_view_vis.mv_amx_frage_2 AS A11
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_2 AS ZEIT12 ON A11.dat_ende = ZEIT12.dat AND ZEIT12.akt_gj = - 1
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
  GROUP BY ZEIT12.gj,
   A15.mandant_id,
   A15.wup_id) AS amx1 ON vis.mandant_id = amx1.mandant_id AND vis.wup_id = amx1.wup_id AND vis.gj = amx1.gj
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
   A150.wup_id) AS amx2 ON vis.mandant_id = amx2.mandant_id AND vis.wup_id = amx2.wup_id AND vis.gj
   /* JZG 640-0 - Kundengarantie Warten Kasse */ = amx2.gj
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 64 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 rekl.warten_kasse AS wert_vj1,
 1.00 AS wert_vj2,
 rekl.warten_kasse AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.anz_kunde) AS anz_kunde
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT REKL.mandant_id,
   REKL.nb_id,
   REKL.wup_id,
   REKL.wrg_id,
   ZEIT14.gj,
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
   INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT14 ON REKL.dat = ZEIT14.dat AND ZEIT14.akt_gj = - 1
  WHERE REKL.reklamationsgrund_id IN (91, 92, 93)
  GROUP BY REKL.mandant_id,
   REKL.nb_id,
   REKL.wup_id,
   REKL.wrg_id,
   ZEIT14.gj) AS rekl_2 ON vis.mandant_id = rekl.mandant_id AND vis.wup_id = rekl.wup_id AND vis.wrg_id = rekl.wrg_id AND
   vis.gj /* JZG 660-0 - Kundengarantie Warten Theke */ = rekl.gj
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 66 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 rekl.warten_theke AS wert_vj1,
 1.00 AS wert_vj2,
 rekl.warten_theke AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.anz_kunde) AS anz_kunde
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT REKL.mandant_id,
   REKL.nb_id,
   REKL.wup_id,
   REKL.wrg_id,
   ZEIT15.gj,
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
   INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT15 ON REKL.dat = ZEIT15.dat AND ZEIT15.akt_gj = - 1
  WHERE REKL.reklamationsgrund_id IN (91, 92, 93)
  GROUP BY REKL.mandant_id,
   REKL.nb_id,
   REKL.wup_id,
   REKL.wrg_id,
   ZEIT15.gj) AS rekl_2 ON vis.mandant_id = rekl.mandant_id AND vis.wup_id = rekl.wup_id AND vis.wrg_id = rekl.wrg_id AND
   vis.gj /* JZG 680-0 - Kundengarantie Mangel MHD */ = rekl.gj
UNION ALL
SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
  vis.gj + 1 AS gj,
 68 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 rekl.mangel_mhd AS wert_vj1,
 1.00 AS wert_vj2,
 rekl.mangel_mhd AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj,
   SUM(VIS.anz_kunde) AS anz_kunde
  FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   ZEIT.gj) AS vis
 LEFT JOIN (SELECT REKL.mandant_id,
   REKL.nb_id,
   REKL.wup_id,
   REKL.wrg_id,
   ZEIT16.gj,
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
   INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT16 ON REKL.dat = ZEIT16.dat AND ZEIT16.akt_gj = - 1
  WHERE REKL.reklamationsgrund_id IN (91, 92, 93)
  GROUP BY REKL.mandant_id,
   REKL.nb_id,
   REKL.wup_id,
   REKL.wrg_id,
   ZEIT16.gj) AS rekl_2 ON vis.mandant_id = rekl.mandant_id AND vis.wup_id = rekl.wup_id AND vis.wrg_id = rekl.wrg_id AND
   vis.gj /* JZG 700-0 - Personalkosten_2 Filiale */ = rekl.gj
UNION ALL
SELECT VIS.mandant_id,
 VIS.nb_id,
 VIS.wup_id,
 VIS.wrg_id,
  ZEIT.gj + 1 AS gj,
 70 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
 SUM(VIS.pers_kosten) AS wert_vj1,
 SUM(VIS.ums_netto) AS wert_vj2,
  SUM(VIS.pers_kosten) / IF(SUM(VIS.ums_netto) = 0, NULL, SUM(VIS.ums_netto)) AS wert_vj,
 SUM(VIS.pers_kosten_plan) AS plan_vj1,
 SUM(VIS.ums_netto_plan) AS plan_vj2,
  IF(SUM(VIS.pers_kosten_plan) = 0, NULL, SUM(VIS.pers_kosten_plan)) / IF(SUM(VIS.ums_netto_plan) = 0, NULL, SUM(VIS.ums_netto_plan
    )) AS plan_vj,
   SUM(VIS.pers_kosten) / IF(SUM(VIS.ums_netto) = 0, NULL, SUM(VIS.ums_netto)) - IF(IF(SUM(VIS.pers_kosten_plan) = 0,
      NULL, SUM(VIS.pers_kosten_plan)) / IF(SUM(VIS.ums_netto_plan) = 0, NULL, SUM(VIS.ums_netto_plan)) = 0, NULL, IF(SUM(VIS
       .pers_kosten_plan) = 0, NULL, SUM(VIS.pers_kosten_plan)) / IF(SUM(VIS.ums_netto_plan) = 0, NULL, SUM(VIS.ums_netto_plan
      ))) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 AS VIS
 INNER JOIN kfl_production_dbp_data.monat_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1
GROUP BY VIS.mandant_id,
 VIS.nb_id,
 VIS.wup_id,
 VIS.wrg_id,
 ZEIT.gj
UNION ALL
SELECT VISU.mandant_id,
 VISU.nb_id,
 VISU.wup_id,
 VISU.wrg_id,
  ZEIT.gj + 1 AS gj,
 78 AS metrik_id,
 0 AS typ_id,
 0 AS level_id,
   SUM(VISU.tage_urlaub_anspruch_akt_kj) + SUM(VISU.tage_urlaub_rest_vj_kj) - (SUM(VISU.tage_urlaub_abgeltung_kj_kum) +
    SUM(VISU.tage_urlaub_genommen_kj_kum)) AS metrik_vgj1,
 SUM(VISU.tage_urlaub_anspruch_akt_kj) AS metrik_vgj2,
   (SUM(VISU.tage_urlaub_anspruch_akt_kj) + SUM(VISU.tage_urlaub_rest_vj_kj) - (SUM(VISU.tage_urlaub_abgeltung_kj_kum) +
      SUM(VISU.tage_urlaub_genommen_kj_kum))) / IF(SUM(VISU.tage_urlaub_anspruch_akt_kj) = 0, NULL, SUM(VISU.tage_urlaub_anspruch_akt_kj
    )) AS metrik_vgj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_shr_wup_urlaub_2 AS VISU
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_monat_2 AS ZEIT_2 ON VISU.kjmo = ZEIT.kjmo
WHERE ZEIT.mo_kj = 12
 AND ZEIT.akt_gj = - 1
 AND VISU.nb_id = 0 /* GJ Mapping / Stand KJ Ende */
GROUP BY VISU.mandant_id,
 VISU.nb_id,
 VISU.wrg_id,
 VISU.wup_id,
 ZEIT.gj
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
  WHEN jzg.metrik_id = 72
  THEN vis.std_spaet
  WHEN jzg.metrik_id = 73
  THEN vis.std_wende
  WHEN jzg.metrik_id = 74
  THEN vis.std_ftag
  WHEN jzg.metrik_id = 75
  THEN vis.std_mehr
  WHEN jzg.metrik_id = 76
  THEN vis.austr_roll
  WHEN jzg.metrik_id = 77
  THEN vis.krank
  WHEN jzg.metrik_id = 80
  THEN vis.kopf_ma
  WHEN jzg.metrik_id = 82
  THEN vis.vzk_ma
  WHEN jzg.metrik_id IN (84, 86)
  THEN vis.std_ma
  WHEN jzg.metrik_id = 88
  THEN vis.tzk_ma
  ELSE NULL
  END AS wert_vj1,
  CASE
  WHEN jzg.metrik_id IN (72, 73, 74, 75)
  THEN CAST(vis.std_ma AS FLOAT64)
  WHEN jzg.metrik_id = 76
  THEN vis.kopf_roll
  WHEN jzg.metrik_id = 77
  THEN CAST(vis.soll AS FLOAT64)
  WHEN jzg.metrik_id IN (80, 82, 84)
  THEN 1.00
  WHEN jzg.metrik_id IN (86, 88)
  THEN CAST(vis.kopf_ma AS FLOAT64)
  ELSE NULL
  END AS wert_vj2,
   CASE
   WHEN jzg.metrik_id = 72
   THEN vis.std_spaet
   WHEN jzg.metrik_id = 73
   THEN vis.std_wende
   WHEN jzg.metrik_id = 74
   THEN vis.std_ftag
   WHEN jzg.metrik_id = 75
   THEN vis.std_mehr
   WHEN jzg.metrik_id = 76
   THEN vis.austr_roll
   WHEN jzg.metrik_id = 77
   THEN vis.krank
   WHEN jzg.metrik_id = 80
   THEN vis.kopf_ma
   WHEN jzg.metrik_id = 82
   THEN vis.vzk_ma
   WHEN jzg.metrik_id IN (84, 86)
   THEN vis.std_ma
   WHEN jzg.metrik_id = 88
   THEN vis.tzk_ma
   ELSE NULL
   END / IF(CASE
     WHEN jzg.metrik_id IN (72, 73, 74, 75)
     THEN CAST(vis.std_ma AS FLOAT64)
     WHEN jzg.metrik_id = 76
     THEN vis.kopf_roll
     WHEN jzg.metrik_id = 77
     THEN CAST(vis.soll AS FLOAT64)
     WHEN jzg.metrik_id IN (80, 82, 84)
     THEN 1.00
     WHEN jzg.metrik_id IN (86, 88)
     THEN CAST(vis.kopf_ma AS FLOAT64)
     ELSE NULL
     END = 0, NULL, CASE
    WHEN jzg.metrik_id IN (72, 73, 74, 75)
    THEN CAST(vis.std_ma AS FLOAT64)
    WHEN jzg.metrik_id = 76
    THEN vis.kopf_roll
    WHEN jzg.metrik_id = 77
    THEN CAST(vis.soll AS FLOAT64)
    WHEN jzg.metrik_id IN (80, 82, 84)
    THEN 1.00
    WHEN jzg.metrik_id IN (86, 88)
    THEN CAST(vis.kopf_ma AS FLOAT64)
    ELSE NULL
    END) AS wert_vj,
 CAST(NULL AS BIGNUMERIC) AS plan_vj1,
 CAST(NULL AS BIGNUMERIC) AS plan_vj2,
 CAST(NULL AS BIGNUMERIC) AS plan_vj,
 CAST(NULL AS BIGNUMERIC) AS delta,
 CAST(NULL AS NUMERIC) AS abw
FROM (SELECT VIS_SHR.mandant_id,
   VIS_SHR.nb_id,
   VIS_SHR.wup_id,
   VIS_SHR.wrg_id,
   ZEIT.gj,
   SUM(VIS_SHR.kopf_gesamt) AS kopf,
   SUM(VIS_SHR.vzk_gesamt) AS vzk,
   SUM(VIS_SHR.kopf_teilzeit) AS tzk,
   SUM(VIS_SHR.stunden_vertrag) AS std,
   SUM(VIS_SHR.kopf_austritte_rol) AS austr_roll,
   SUM(VIS_SHR.kopf_fluktuation_rol) AS kopf_roll,
   SUM(VIS_SHR.tage_krank) AS krank,
   SUM(VIS_SHR.tage_arbeit_soll) AS soll,
   SUM(CASE
     WHEN VIS_SHR.shr_ma_funktion_gruppe_id = 50
     THEN VIS_SHR.kopf_gesamt
     ELSE 0
     END) AS kopf_ma,
   SUM(CASE
     WHEN VIS_SHR.shr_ma_funktion_gruppe_id = 50
     THEN VIS_SHR.vzk_gesamt
     ELSE 0
     END) AS vzk_ma,
   SUM(CASE
     WHEN VIS_SHR.shr_ma_funktion_gruppe_id = 50
     THEN VIS_SHR.kopf_teilzeit
     ELSE 0
     END) AS tzk_ma,
   SUM(CASE
     WHEN VIS_SHR.shr_ma_funktion_gruppe_id = 50
     THEN VIS_SHR.stunden_vertrag
     ELSE 0
     END) AS std_ma,
   SUM(CASE
     WHEN VIS_SHR.shr_ma_funktion_gruppe_id = 50
     THEN VIS_SHR.stunden_zuschlag_feiertag
     ELSE 0
     END) AS std_ftag,
   SUM(CASE
     WHEN VIS_SHR.shr_ma_funktion_gruppe_id = 50
     THEN VIS_SHR.stunden_zuschlag_mehr
     ELSE 0
     END) AS std_mehr,
   SUM(CASE
     WHEN VIS_SHR.shr_ma_funktion_gruppe_id = 50
     THEN VIS_SHR.stunden_zuschlag_spaet_nacht
     ELSE 0
     END) AS std_spaet,
   SUM(CASE
     WHEN VIS_SHR.shr_ma_funktion_gruppe_id = 50
     THEN VIS_SHR.stunden_zuschlag_wochenende
     ELSE 0
     END) AS std_wende
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_shr_wup_funktion_2 AS VIS_SHR
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_monat_2 AS ZEIT_2 ON VIS_SHR.kjmo = ZEIT.kjmo AND ZEIT.akt_gj = - 1 AND
     ZEIT.mo_kj = 2 /* Stand Feb. */
  GROUP BY VIS_SHR.mandant_id,
   VIS_SHR.nb_id,
   VIS_SHR.wup_id,
   VIS_SHR.wrg_id,
   ZEIT.gj) AS vis
 INNER JOIN (SELECT 72 AS metrik_id
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
   SELECT 30 AS metrik_id
   UNION ALL
   SELECT 33 AS metrik_id
   UNION ALL
   SELECT 36 AS metrik_id
   UNION ALL
   SELECT 39 AS metrik_id) AS jzg ON TRUE;