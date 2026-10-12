CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_export_tagesumsatz_kw_zeitraum_1 AS WITH WUP_1 AS (SELECT WUP.mandant_id
   ,
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
   IF(WUP.nb_id = 0, IF(DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN WUP.dat_eroeffnung AND WUP.dat_bis, 1, 0) * IF(WUP_1
         .mandant_id = 1 AND WUP.wup_id IN (1263, 3166, 5876, 6623, 8308, 8563, 8940) OR WUP.mandant_id = 7 AND WUP.wup_id
          IN (1410, 6210, 6310, 6410), 0, 1), 0) AS zaehl_fg
  FROM kfl_production_dbp_msi_view_vis.mv_wup_1 AS WUP_1
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_mandant_1 AS MAN ON WUP.mandant_id = MAN.mandant_id
  WHERE WUP.dat_eroeffnung < DATE '2090-12-31'
   AND WUP.dat_bis > DATE_SUB(CURRENT_DATE, INTERVAL 731 DAY)
   AND (WUP.nb_id = 0 OR WUP.wup_id IN (0, 2, 22, 28, 43, 46, 124, 8980, 8987, 8991, 100000, 100002, 100022, 100028,
       100043, 100046, 100124))), ZEITRAUM AS (SELECT ZTAG.zeit_id,
   ZSPR.zeit_tag_sort,
   ZSPR.zeit_bez,
   TTT.dat,
   TTT.akt_tag,
   TTT.kjwo,
   TTT.akt_wo,
   TTT.wo_dat_von,
   TTT.wo_dat_bis,
   TTT.akt_gj
  FROM kfl_production_dbp_msi_view_vis.mv_zeit_tag_zu_1 AS ZTAG
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_1 AS TTT ON ZTAG.dat = TTT.dat
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_zeit_spr_zu_1 AS ZSPR ON ZTAG.zeit_id = ZSPR.zeit_id
  WHERE ZSPR.zeit_tag_sort <> 9999
   AND ZTAG.zeit_id NOT IN (-120, -200, -190, -180, -170, -160, -150, -140, -130, 100, 110, 120, 130)), VIS AS (SELECT
   VIS.mandant_id,
   t1.land_id,
   t1.land_sort,
   VIS.wrg_id,
   t4.zeit_id,
   t4.zeit_tag_sort AS zeit_sort,
   t4.zeit_bez,
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
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_fakt_wup_1 AS VIS
   INNER JOIN WUP_1 AS t1_1 ON VIS.mandant_id = t1.mandant_id AND VIS.wup_id = t1.wup_id
   INNER JOIN ZEITRAUM AS t4 ON VIS.dat = t4.dat
  GROUP BY VIS.mandant_id,
   t1.land_id,
   t1.land_sort,
   VIS.wrg_id,
   t4.zeit_id,
   zeit_sort,
   t4.zeit_bez), VIS_WG AS (SELECT VIS0.mandant_id,
   t11.land_id,
   VIS0.wrg_id,
   t14.zeit_id,
   SUM(VIS0.menge) AS absatz_ohne_pfand_ist,
   SUM(VIS0.menge_wvj) AS absatz_ohne_pfand_wvj,
   SUM(VIS0.menge * IF(t14.wo_dat_von > DATE_ADD(t11.neo_dat, INTERVAL 364 DAY) AND t14.wo_dat_bis < t11.stl_dat, 1.00,
      0)) AS absatz_ohne_pfand_bereinigt_ist,
   SUM(VIS0.menge_wvj * IF(t14.wo_dat_von > DATE_ADD(t11.neo_dat, INTERVAL 364 DAY) AND t14.wo_dat_bis < t11.stl_dat,
      1.00, 0)) AS absatz_ohne_pfand_bereinigt_wvj
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_fakt_wg_1 AS VIS0
   INNER JOIN WUP_1 AS t11 ON VIS0.mandant_id = t11.mandant_id AND VIS0.wup_id = t11.wup_id
   INNER JOIN ZEITRAUM AS t14 ON VIS0.dat = t14.dat
  WHERE VIS0.wg_id NOT IN (980, 981, 982, 983, 984, 985, 986, 987, 988, 989)
  GROUP BY VIS0.mandant_id,
   VIS0.wrg_id,
   t11.land_id,
   t14.zeit_id), CHECK_BB AS (SELECT CBB.dat,
   CBB.mandant_id,
   CBB.bb_fg,
   CBB.check_fg
  FROM kfl_production_dbp_msi_data.check_blackberry_1 AS CBB
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_1 AS TTT1 ON CBB.dat = TTT1.dat
  WHERE TTT1.akt_tag = 0) (SELECT t8.mandant_id,
   t22.bb_fg,
   t8.land_id,
   t8.land_sort,
   t8.wrg_id,
   t8.zeit_id,
   t8.zeit_sort,
   t8.zeit_bez,
   t8.umsatz_netto_ist,
   t8.umsatz_netto_bereinigt_ist,
   t8.umsatz_netto_plan,
   t8.anzahl_kunden_ist,
   t8.anzahl_kunden_bereinigt_ist,
   t19.absatz_ohne_pfand_ist,
   t19.absatz_ohne_pfand_bereinigt_ist,
   t8.umsatz_netto_wvj,
   t8.umsatz_netto_bereinigt_wvj,
   t8.anzahl_kunden_wvj,
   t8.anzahl_kunden_bereinigt_wvj,
   t19.absatz_ohne_pfand_wvj,
   t19.absatz_ohne_pfand_bereinigt_wvj
  FROM VIS AS t8
   INNER JOIN VIS_WG AS t19 ON t8.mandant_id = t19.mandant_id AND t8.wrg_id = t19.wrg_id AND t8.zeit_id = t19.zeit_id
   INNER JOIN CHECK_BB AS t22 ON t8.mandant_id = t22.mandant_id);