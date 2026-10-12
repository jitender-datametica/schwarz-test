/* FAKT : Export des KL_VIS Tagesumsatz KW (BB-Bericht) 
	Version Tag : Tageswerte (komplettes GJ + Vorwoche/Folgewoche)
	2026-02-03 ssch0611 Initial AP0298917 */
/* CTE */ CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_export_tagesumsatz_kw_tag AS WITH WUP AS (SELECT WUP
   .mandant_id,
   WUP.land_id,
   MAN.mandant_sort_id AS land_sort,
   WUP.nb_id,
   WUP.vs_id,
   WUP.wup_id,
   WUP.dat_eroeffnung AS neo_dat,
   WUP.dat_bis AS stl_dat,
   IF(DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN WUP.dat_eroeffnung AND WUP.dat_bis, 1, 0) AS offen_fg,
   IF(WUP.mandant_id = 1 AND WUP.wup_id IN (1263, 3166, 5876, 6623, 8308, 8563, 8940) OR WUP.mandant_id = 7 AND WUP.wup_id
        IN (1410, 6210, 6310, 6410), 0, 1) AS aus_fg,
   IF(WUP.nb_id = 0, IF(DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN WUP.dat_eroeffnung AND WUP.dat_bis, 1, 0) * IF(WUP
         .mandant_id = 1 AND WUP.wup_id IN (1263, 3166, 5876, 6623, 8308, 8563, 8940) OR WUP.mandant_id = 7 AND WUP.wup_id
          IN (1410, 6210, 6310, 6410), 0, 1), 0) AS zaehl_fg
  FROM kfl_production_dbp_msi_view_vis.mv_wup AS WUP
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_mandant AS MAN ON WUP.mandant_id = MAN.mandant_id
  WHERE WUP.dat_eroeffnung < DATE '2090-12-31'
   AND WUP.dat_bis > DATE_SUB(CURRENT_DATE, INTERVAL 731 DAY)
   AND (WUP.nb_id = 0 OR WUP.wup_id IN (0, 2, 22, 28, 43, 46, 124, 8980, 8987, 8991, 100000, 100002, 100022, 100028,
       100043, 100046, 100124))), ZEIT AS (SELECT dat,
   akt_tag,
   kjwo,
   akt_wo,
   akt_wo_komplett,
   wo_dat_von,
   wo_dat_bis,
   akt_gj
  FROM kfl_production_dbp_msi_view_vis.mv_tag AS ZEIT
  WHERE akt_gj = 0
   OR akt_wo BETWEEN -1 AND 1), CHECK_BB AS (SELECT t7.dat,
   CBB.mandant_id,
   CBB.bb_fg,
   CBB.check_fg
  FROM ZEIT AS t7
   INNER JOIN kfl_production_dbp_msi_data.check_blackberry AS CBB ON t7.dat = CBB.dat), VIS AS (SELECT VIS.mandant_id,
   t1.land_id,
   t1.land_sort,
   VIS.wrg_id,
   VIS.dat,
   DATE_SUB(VIS.dat, INTERVAL 364 DAY) AS dat_wvj,
   COALESCE(t9.bb_fg, 1) AS bb_plan,
   COALESCE(t9.bb_fg, 0) AS bb_ist,
   SUM(VIS.ums_netto) AS umsatz_netto_ist,
   SUM(VIS.ums_netto_plan) AS umsatz_netto_plan,
   SUM(VIS.ums_netto_wvj) AS umsatz_netto_wvj,
   SUM(VIS.anz_kunde) AS anzahl_kunden_ist,
   SUM(VIS.anz_kunde_wvj) AS anzahl_kunden_wvj,
   SUM(VIS.ums_netto * IF(t4.wo_dat_von > DATE_ADD(t1.neo_dat, INTERVAL 364 DAY) AND t4.wo_dat_bis < t1.stl_dat, 1.00, 0
      )) AS umsatz_netto_bereinigt_ist,
   SUM(VIS.ums_netto_wvj * IF(t4.wo_dat_von > DATE_ADD(t1.neo_dat, INTERVAL 364 DAY) AND t4.wo_dat_bis < t1.stl_dat,
      1.00, 0)) AS umsatz_netto_bereinigt_wvj,
   SUM(VIS.anz_kunde * IF(t4.wo_dat_von > DATE_ADD(t1.neo_dat, INTERVAL 364 DAY) AND t4.wo_dat_bis < t1.stl_dat, 1.00, 0
      )) AS anzahl_kunden_bereinigt_ist,
   SUM(VIS.anz_kunde_wvj * IF(t4.wo_dat_von > DATE_ADD(t1.neo_dat, INTERVAL 364 DAY) AND t4.wo_dat_bis < t1.stl_dat,
      1.00, 0)) AS anzahl_kunden_bereinigt_wvj
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_fakt_wup AS VIS
   INNER JOIN WUP AS t1 ON VIS.mandant_id = t1.mandant_id AND VIS.wup_id = t1.wup_id
   INNER JOIN ZEIT AS t4 ON VIS.dat = t4.dat
   LEFT JOIN CHECK_BB AS t9 ON VIS.mandant_id = t9.mandant_id AND VIS.dat = t9.dat
  GROUP BY VIS.mandant_id,
   t1.land_id,
   t1.land_sort,
   VIS.wrg_id,
   VIS.dat,
   dat_wvj,
   bb_plan,
   bb_ist), VIS_WG AS (SELECT VIS0.mandant_id,
   VIS0.wrg_id,
   VIS0.dat,
   SUM(VIS0.menge) AS absatz_ohne_pfand_ist,
   SUM(VIS0.menge_wvj) AS absatz_ohne_pfand_wvj,
   SUM(VIS0.menge * IF(t19.wo_dat_von > DATE_ADD(t16.neo_dat, INTERVAL 364 DAY) AND t19.wo_dat_bis < t16.stl_dat, 1.00,
      0)) AS absatz_ohne_pfand_bereinigt_ist,
   SUM(VIS0.menge_wvj * IF(t19.wo_dat_von > DATE_ADD(t16.neo_dat, INTERVAL 364 DAY) AND t19.wo_dat_bis < t16.stl_dat,
      1.00, 0)) AS absatz_ohne_pfand_bereinigt_wvj
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_fakt_wg AS VIS0
   INNER JOIN WUP AS t16 ON VIS0.mandant_id = t16.mandant_id AND VIS0.wup_id = t16.wup_id
   INNER JOIN ZEIT AS t19 ON VIS0.dat = t19.dat
  WHERE VIS0.wg_id NOT IN (980, 981, 982, 983, 984, 985, 986, 987, 988, 989)
  GROUP BY VIS0.mandant_id,
   VIS0.wrg_id,
   VIS0.dat) (/* Standard Filter Filialen , definierte ZF, ohne Ausschluss */ /* geöffnete Filialen */
  /* Ausschluss Getränkemärkte + Zeltverkauf */ /* Zählung geöffnete Filialen (ohne Auschluss, ohne ZF) */
  /* ohne Dummies, inkl Schließungen im VGJ */ /* Filialen  + definierte ZF */
  /* Zeitfilter Aktuelles GJ (bis gestern) */ /* Blackberry Prüfung */ /* Umsatz IST, Plan, WVJ (Tageswerte) */
  /* Absatz Umsatz IST, Plan, WVJ (Tageswerte) */ /* MAIN */ SELECT t13.mandant_id /* KFL mandant_id */,
   t29.bb_fg /* 1 = Daten sind freigegeben */,
   t13.land_id /* Land (ISO) */,
   t13.land_sort /* Sortierung der K Länder */,
   t13.wrg_id /* EUR (Berichtskurs) + Landeswährung */,
   t13.dat /* Datum (aktuell) */,
   t13.dat_wvj /* Datum im Vorjahr (Wochentagsvergleich, IST-364 Tage) */,
   t13.umsatz_netto_ist,
   t13.umsatz_netto_bereinigt_ist,
   t13.umsatz_netto_plan,
   t13.anzahl_kunden_ist,
   t13.anzahl_kunden_bereinigt_ist,
   t24.absatz_ohne_pfand_ist,
   t24.absatz_ohne_pfand_bereinigt_ist,
   t13.umsatz_netto_wvj,
   t13.umsatz_netto_bereinigt_wvj,
   t13.anzahl_kunden_wvj,
   t13.anzahl_kunden_bereinigt_wvj,
   t24.absatz_ohne_pfand_wvj,
   t24.absatz_ohne_pfand_bereinigt_wvj
  FROM VIS AS t13
   INNER JOIN VIS_WG AS t24 ON t13.mandant_id = t24.mandant_id AND t13.wrg_id = t24.wrg_id AND t13.dat = t24.dat
   INNER JOIN CHECK_BB AS t29 ON t13.mandant_id = t29.mandant_id AND t13.dat = t29.dat);