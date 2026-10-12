CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_bedienkonzept_1 (mandant_id, nb_id, wup_id, dummy_1,
glv_land_id, vs_id, gl_vertrieb_id, gf_gbl_vertrieb_id, frische_manager_id, vkl_id, hausleiter_id, regionale_psb_id,
wbl_food_id, wbl_frische_id, wbl_nonfood_id, wbl_kasse_id, edat, dat_eroeffnung, bed_fleisch_fg, bed_fleisch_dat,
bed_wurst_fg, bed_wurst_dat, bed_gefl_fg, bed_gefl_dat, bed_kaese_fg, bed_kaese_dat, bed_fisch_id, bed_fisch_dat,
bed_feink_fg, bed_feink_dat, bed_bulk_fg, bed_bulk_dat, bed_bedins_fg, bed_bedins_dat, bed_imbiss_fg, bed_imbiss_dat,
system_backshop, bed_backshop_dat, anz_leergut_automat, konzept_leergut, tankstelle_vorh_fg, tankstelle_eigen_fg,
parkhaus_kz, eigentum_fg, int_eigentum_fg, ma_vermietung_id, dat_letzte_reorga, anz_aufzuege_ausserhalb,
anz_rollsteige_ausserhalb, anz_aufzuege_intern, anz_rollsteige_intern, untervermietung_kz, untervermietung_text,
untervermietung_freitext, untervermietung_bez, anz_diff_tage) AS SELECT w.mandant_id,
 w.nb_id,
 w.wup_id,
   (1000 + w.mandant_id * 100 + w.vs_id * 10) * - 1 AS dummy_1,
 MAX(WD.glv_land_id) OVER (PARTITION BY CAST(w.mandant_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS glv_land_id,
 w.vs_id,
 VS.gl_vertrieb_id,
 COALESCE(WD.gf_gbl_vertrieb_id, (1000 + w.mandant_id * 100 + w.vs_id * 10) * - 1) AS gf_gbl_vertrieb_id,
 COALESCE(WD.frische_manager_id, - 1) AS frische_manager_id,
 COALESCE(WD.vkl_id, (1000 + w.mandant_id * 100 + w.vs_id * 10) * - 1) AS vkl_id,
 COALESCE(WD.hausleiter_id, (1000 + w.mandant_id * 100 + w.vs_id * 10) * - 1) AS hausleiter_id,
 WD.regionale_psb_id,
 WD.wbl_food_id,
 WD.wbl_frische_id,
 WD.wbl_nonfood_id,
 WD.wbl_kasse_id,
 COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung) AS edat,
 COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung) AS dat_eroeffnung,
 WD.bed_fleisch_fg,
  CASE
  WHEN WD.bed_fleisch_fg = 1
  THEN COALESCE(WD.bed_fleisch_dat, COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung))
  ELSE NULL
  END AS bed_fleisch_dat,
 WD.bed_wurst_fg,
  CASE
  WHEN WD.bed_wurst_fg = 1
  THEN COALESCE(WD.bed_wurst_dat, COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung))
  ELSE NULL
  END AS bed_wurst_dat,
 WD.bed_gefl_fg,
  CASE
  WHEN WD.bed_gefl_fg = 1
  THEN COALESCE(WD.bed_gefl_dat, COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung))
  ELSE NULL
  END AS bed_gefl_dat,
 WD.bed_kaese_fg,
  CASE
  WHEN WD.bed_kaese_fg = 1
  THEN COALESCE(WD.bed_kaese_dat, COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung))
  ELSE NULL
  END AS bed_kaese_dat,
 WD.bed_fisch_id,
  CASE
  WHEN WD.bed_fleisch_fg > 1
  THEN COALESCE(WD.bed_fisch_dat, COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung))
  ELSE NULL
  END AS bed_fisch_dat,
 WD.bed_feink_fg,
  CASE
  WHEN WD.bed_feink_fg = 1
  THEN COALESCE(WD.bed_feink_dat, COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung))
  ELSE NULL
  END AS bed_feink_dat,
 WD.bed_bulk_fg,
  CASE
  WHEN WD.bed_bulk_fg = 1
  THEN COALESCE(WD.bed_bulk_dat, COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung))
  ELSE NULL
  END AS bed_bulk_dat,
 WD.bed_bedins_fg,
  CASE
  WHEN WD.bed_bedins_fg = 1
  THEN COALESCE(WD.bed_bedins_dat, COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung))
  ELSE NULL
  END AS bed_bedins_dat,
 WD.bed_imbiss_fg,
  CASE
  WHEN WD.bed_imbiss_fg = 1
  THEN COALESCE(WD.bed_imbiss_dat, COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung))
  ELSE NULL
  END AS bed_imbiss_dat,
 WD.backshop_system AS system_backshop,
  CASE
  WHEN WD.backshop_system IS NOT NULL
  THEN COALESCE(WD.bed_backshop_dat, COALESCE(w.dat_eroeffnung_alt, w.dat_eroeffnung))
  ELSE NULL
  END AS bed_backshop_dat,
 WD.anz_leergutautomaten AS anz_leergut_automat,
 WD.leergut_system AS konzept_leergut,
 '0' AS tankstelle_vorh_fg,
 WD.tankstelle_eigen_fg,
 WD.parkhaus_kz,
 '0' AS eigentum_fg,
 '0' AS int_eigentum_fg,
 '0' AS ma_vermietung_id,
 WD.dat_letzte_reorga,
  WD.anz_aufzuege - WD.anz_aufzuege_intern AS anz_aufzuege_ausserhalb,
  WD.anz_rollsteige - WD.anz_rollsteige_intern AS anz_rollsteige_ausserhalb,
 WD.anz_aufzuege_intern,
 WD.anz_rollsteige_intern,
 '0' AS untervermietung_kz,
 '0' AS untervermietung_text,
 '0' AS untervermietung_freitext,
 '0' AS untervermietung_bez,
 1 AS anz_diff_tage
FROM (SELECT mandant_id,
   nb_id,
   vs_id,
   wup_id,
   dat_eroeffnung,
   dat_eroeffnung_alt
  FROM kfl_production_dbp_view.v_wup_1 AS WW
  WHERE nb_id IN (- 2, - 1, 0)
   AND dat_von > DATE('1900-01-01')
   AND dat_eroeffnung > DATE('1900-01-01')
   AND umzugsfiliale_fg = 0) AS w
 LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm_1 AS WD ON w.wup_id = WD.wup_id AND w.mandant_id = WD.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_vs_1 AS VS_1 ON w.vs_id = VS.vs_id AND w.mandant_id = VS.mandant_id;