CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_wup_bedienkonzept AS SELECT W.mandant_id,
 W.nb_id,
 W.wup_id,
 W.vs_id,
 COALESCE(WD.hausleiter_id, (1000 + W.mandant_id * 100 + W.vs_id * 10) * - 1) AS hausleiter_id,
 COALESCE(WD.vkl_id, (1000 + W.mandant_id * 100 + W.vs_id * 10) * - 1) AS vkl_id,
 COALESCE(WD.frische_manager_id, - 1) AS frische_manager_id,
 COALESCE(WD.gf_gbl_vertrieb_id, 0) AS gf_gbl_vertrieb_id,
 MAX(WD.gl_vertrieb_id) OVER (PARTITION BY CAST(W.mandant_id AS STRING), CAST(W.vs_id AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS gl_vertrieb_id,
 MAX(WD.glv_land_id) OVER (PARTITION BY CAST(W.mandant_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS glv_land_id,
 WD.regionale_psb_id,
 WD.wbl_food_id,
 WD.wbl_frische_id,
 WD.wbl_nonfood_id,
 WD.wbl_kasse_id,
 COALESCE(WD.bed_fleisch_fg, - 1) AS bed_fleisch_fg,
  CASE
  WHEN ABS(DATE_DIFF(WD.bed_fleisch_dat, W.dat_eroeffnung, DAY)) < 1
  THEN PARSE_DATE('%F', '1900-01-01')
  ELSE WD.bed_fleisch_dat
  END AS bed_fleisch_dat,
 COALESCE(WD.bed_wurst_fg, - 1) AS bed_wurst_fg,
  CASE
  WHEN ABS(DATE_DIFF(WD.bed_wurst_dat, W.dat_eroeffnung, DAY)) < 1
  THEN PARSE_DATE('%F', '1900-01-01')
  ELSE WD.bed_wurst_dat
  END AS bed_wurst_dat,
 COALESCE(WD.bed_gefl_fg, - 1) AS bed_gefl_fg,
  CASE
  WHEN ABS(DATE_DIFF(WD.bed_gefl_dat, W.dat_eroeffnung, DAY)) < 1
  THEN PARSE_DATE('%F', '1900-01-01')
  ELSE WD.bed_gefl_dat
  END AS bed_gefl_dat,
 COALESCE(WD.bed_kaese_fg, - 1) AS bed_kaese_fg,
  CASE
  WHEN ABS(DATE_DIFF(WD.bed_kaese_dat, W.dat_eroeffnung, DAY)) < 1
  THEN PARSE_DATE('%F', '1900-01-01')
  ELSE WD.bed_kaese_dat
  END AS bed_kaese_dat,
 COALESCE(WD.bed_fisch_id, 1) AS bed_fisch_id,
  CASE
  WHEN ABS(DATE_DIFF(WD.bed_fisch_dat, W.dat_eroeffnung, DAY)) < 1
  THEN PARSE_DATE('%F', '1900-01-01')
  ELSE WD.bed_fisch_dat
  END AS bed_fisch_dat,
 COALESCE(WD.bed_feink_fg, - 1) AS bed_feink_fg,
  CASE
  WHEN ABS(DATE_DIFF(WD.bed_feink_dat, W.dat_eroeffnung, DAY)) < 1
  THEN PARSE_DATE('%F', '1900-01-01')
  ELSE WD.bed_feink_dat
  END AS bed_feink_dat,
 COALESCE(WD.bed_bulk_fg, - 1) AS bed_bulk_fg,
  CASE
  WHEN ABS(DATE_DIFF(WD.bed_bulk_dat, W.dat_eroeffnung, DAY)) < 1
  THEN PARSE_DATE('%F', '1900-01-01')
  ELSE WD.bed_bulk_dat
  END AS bed_bulk_dat,
 WD.bed_bedins_fg,
  CASE
  WHEN ABS(DATE_DIFF(WD.bed_bedins_dat, W.dat_eroeffnung, DAY)) < 1
  THEN PARSE_DATE('%F', '1900-01-01')
  ELSE WD.bed_bedins_dat
  END AS bed_bedins_dat,
 WD.bed_imbiss_fg,
  CASE
  WHEN ABS(DATE_DIFF(WD.bed_imbiss_dat, W.dat_eroeffnung, DAY)) < 1
  THEN PARSE_DATE('%F', '1900-01-01')
  ELSE WD.bed_imbiss_dat
  END AS bed_imbiss_dat,
 COALESCE(WD.backshop_system, '') AS system_backshop,
  CASE
  WHEN ABS(DATE_DIFF(WD.bed_backshop_dat, W.dat_eroeffnung, DAY)) < 1
  THEN PARSE_DATE('%F', '1900-01-01')
  ELSE WD.bed_backshop_dat
  END AS bed_backshop_dat,
 WD.anz_leergutautomaten AS anz_leergut_automat,
 COALESCE(WD.leergut_system, '') AS konzept_leergut,
 WD.tankstelle_vorh_fg,
 WD.tankstelle_eigen_fg,
 WD.parkhaus_kz,
  CASE
  WHEN WD.mandant_id = 1
  THEN WD.eigentum_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS eigentum_fg,
 WD.ma_vermietung_id,
 WD.dat_letzte_reorga,
  WD.anz_aufzuege - WD.anz_aufzuege_intern AS anz_aufzuege_ausserhalb,
  WD.anz_rollsteige - WD.anz_rollsteige_intern AS anz_rollsteige_ausserhalb,
 WD.anz_aufzuege_intern,
 WD.anz_rollsteige_intern,
   (1000 + W.mandant_id * 100 + W.vs_id * 10) * - 1 AS dummy,
 1 AS anz_diff_tage
FROM kfl_production_dbp_view.v_wup AS W
 LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm AS WD ON W.wup_id = WD.wup_id AND W.mandant_id = WD.mandant_id;