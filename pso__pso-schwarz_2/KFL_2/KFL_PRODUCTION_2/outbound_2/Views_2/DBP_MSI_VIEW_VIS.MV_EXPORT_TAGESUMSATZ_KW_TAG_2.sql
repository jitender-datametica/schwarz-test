CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_export_tagesumsatz_kw_tag_2 AS WITH WUP_2 AS (SELECT WUP.mandant_id
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
   IF(WUP.nb_id = 0, IF(DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN WUP.dat_eroeffnung AND WUP.dat_bis, 1, 0) * IF(WUP_2
         .mandant_id = 1 AND WUP.wup_id IN (1263, 3166, 5876, 6623, 8308, 8563, 8940) OR WUP.mandant_id = 7 AND WUP.wup_id
          IN (1410, 6210, 6310, 6410), 0, 1), 0) AS zaehl_fg
  FROM kfl_production_dbp_msi_view_vis.mv_wup_2 AS WUP_2
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_mandant_2 AS MAN ON WUP.mandant_id = MAN.mandant_id
  WHERE WUP.dat_eroeffnung < DATE '2090-12-31'
   AND WUP.dat_bis > DATE_SUB(CURRENT_DATE, INTERVAL 731 DAY)
   AND (WUP.nb_id = 0 OR WUP.wup_id IN (0, 2, 22, 28, 43, 46, 124, 8980, 8987, 8991, 100000, 100002, 100022, 100028,
       100043, 100046, 100124))), ZEIT_2 AS (SELECT dat,
   akt_tag,
   kjwo,
   akt_wo,
   akt_wo_komplett,
   wo_dat_von,
   wo_dat_bis,
   akt_gj
  FROM kfl_production_dbp_msi_view_vis.mv_tag_2 AS ZEIT_2
  WHERE akt_gj = 0
   OR akt_wo BETWEEN -1 AND 1), CHECK_BB AS (SELECT t7.dat,
   CBB.mandant_id,
   CBB.bb_fg,
   CBB.check_fg
  FROM ZEIT_2 AS t7
   INNER JOIN kfl_production_dbp_msi_data.check_blackberry_2 AS CBB ON t7.dat = CBB.dat), VIS AS (SELECT VIS.mandant_id,
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
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_fakt_wup_2 AS VIS
   INNER JOIN WUP_2 AS t1_2 ON VIS.mandant_id = t1.mandant_id AND VIS.wup_id = t1.wup_id
   INNER JOIN ZEIT_2 AS t4 ON VIS.dat = t4.dat
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
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_fakt_wg_2 AS VIS0
   INNER JOIN WUP_2 AS t16 ON VIS0.mandant_id = t16.mandant_id AND VIS0.wup_id = t16.wup_id
   INNER JOIN ZEIT_2 AS t19 ON VIS0.dat = t19.dat
  WHERE VIS0.wg_id NOT IN (980, 981, 982, 983, 984, 985, 986, 987, 988, 989)
  GROUP BY VIS0.mandant_id,
   VIS0.wrg_id,
   VIS0.dat) (SELECT t13.mandant_id,
   t29.bb_fg,
   t13.land_id,
   t13.land_sort,
   t13.wrg_id,
   t13.dat,
   t13.dat_wvj,
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