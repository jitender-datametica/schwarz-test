CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_wup_bedienkonzept
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  w.mandant_id AS mandant_id,
  w.nb_id AS nb_id,
  w.wup_id AS wup_id,
  w.vs_id AS vs_id,
  COALESCE(wd.hausleiter_id, (
    1000 + w.mandant_id * 100 + w.vs_id * 10
  ) * -1) AS hausleiter_id,
  COALESCE(wd.vkl_id, (
    1000 + w.mandant_id * 100 + w.vs_id * 10
  ) * -1) AS vkl_id,
  COALESCE(wd.frische_manager_id, -1) AS frische_manager_id,
  COALESCE(wd.gf_gbl_vertrieb_id, 0) AS gf_gbl_vertrieb_id,
  MAX(wd.gl_vertrieb_id) OVER (
    PARTITION BY CAST(w.mandant_id AS STRING), CAST(w.vs_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS gl_vertrieb_id,
  MAX(wd.glv_land_id) OVER (
    PARTITION BY CAST(w.mandant_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS glv_land_id,
  wd.regionale_psb_id AS regionale_psb_id,
  wd.wbl_food_id AS wbl_food_id,
  wd.wbl_frische_id AS wbl_frische_id,
  wd.wbl_nonfood_id AS wbl_nonfood_id,
  wd.wbl_kasse_id AS wbl_kasse_id,
  COALESCE(wd.bed_fleisch_fg, -1) AS bed_fleisch_fg,
  CASE
    WHEN ABS(DATE_DIFF(wd.bed_fleisch_dat, w.dat_eroeffnung, DAY)) < 1
    THEN PARSE_DATE('%F', '1900-01-01')
    ELSE wd.bed_fleisch_dat
  END AS bed_fleisch_dat,
  COALESCE(wd.bed_wurst_fg, -1) AS bed_wurst_fg,
  CASE
    WHEN ABS(DATE_DIFF(wd.bed_wurst_dat, w.dat_eroeffnung, DAY)) < 1
    THEN PARSE_DATE('%F', '1900-01-01')
    ELSE wd.bed_wurst_dat
  END AS bed_wurst_dat,
  COALESCE(wd.bed_gefl_fg, -1) AS bed_gefl_fg,
  CASE
    WHEN ABS(DATE_DIFF(wd.bed_gefl_dat, w.dat_eroeffnung, DAY)) < 1
    THEN PARSE_DATE('%F', '1900-01-01')
    ELSE wd.bed_gefl_dat
  END AS bed_gefl_dat,
  COALESCE(wd.bed_kaese_fg, -1) AS bed_kaese_fg,
  CASE
    WHEN ABS(DATE_DIFF(wd.bed_kaese_dat, w.dat_eroeffnung, DAY)) < 1
    THEN PARSE_DATE('%F', '1900-01-01')
    ELSE wd.bed_kaese_dat
  END AS bed_kaese_dat,
  COALESCE(wd.bed_fisch_id, 1) AS bed_fisch_id,
  CASE
    WHEN ABS(DATE_DIFF(wd.bed_fisch_dat, w.dat_eroeffnung, DAY)) < 1
    THEN PARSE_DATE('%F', '1900-01-01')
    ELSE wd.bed_fisch_dat
  END AS bed_fisch_dat,
  COALESCE(wd.bed_feink_fg, -1) AS bed_feink_fg,
  CASE
    WHEN ABS(DATE_DIFF(wd.bed_feink_dat, w.dat_eroeffnung, DAY)) < 1
    THEN PARSE_DATE('%F', '1900-01-01')
    ELSE wd.bed_feink_dat
  END AS bed_feink_dat,
  COALESCE(wd.bed_bulk_fg, -1) AS bed_bulk_fg,
  CASE
    WHEN ABS(DATE_DIFF(wd.bed_bulk_dat, w.dat_eroeffnung, DAY)) < 1
    THEN PARSE_DATE('%F', '1900-01-01')
    ELSE wd.bed_bulk_dat
  END AS bed_bulk_dat,
  wd.bed_bedins_fg AS bed_bedins_fg,
  CASE
    WHEN ABS(DATE_DIFF(wd.bed_bedins_dat, w.dat_eroeffnung, DAY)) < 1
    THEN PARSE_DATE('%F', '1900-01-01')
    ELSE wd.bed_bedins_dat
  END AS bed_bedins_dat,
  wd.bed_imbiss_fg AS bed_imbiss_fg,
  CASE
    WHEN ABS(DATE_DIFF(wd.bed_imbiss_dat, w.dat_eroeffnung, DAY)) < 1
    THEN PARSE_DATE('%F', '1900-01-01')
    ELSE wd.bed_imbiss_dat
  END AS bed_imbiss_dat,
  COALESCE(wd.backshop_system, '') AS system_backshop,
  CASE
    WHEN ABS(DATE_DIFF(wd.bed_backshop_dat, w.dat_eroeffnung, DAY)) < 1
    THEN PARSE_DATE('%F', '1900-01-01')
    ELSE wd.bed_backshop_dat
  END AS bed_backshop_dat,
  wd.anz_leergutautomaten AS anz_leergut_automat,
  COALESCE(wd.leergut_system, '') AS konzept_leergut,
  wd.tankstelle_vorh_fg AS tankstelle_vorh_fg,
  wd.tankstelle_eigen_fg AS tankstelle_eigen_fg,
  wd.parkhaus_kz AS parkhaus_kz,
  CASE WHEN wd.mandant_id = 1 THEN wd.eigentum_fg ELSE CAST(-1 AS BIGNUMERIC) END AS eigentum_fg,
  wd.ma_vermietung_id AS ma_vermietung_id,
  wd.dat_letzte_reorga AS dat_letzte_reorga,
  wd.anz_aufzuege - wd.anz_aufzuege_intern AS anz_aufzuege_ausserhalb,
  wd.anz_rollsteige - wd.anz_rollsteige_intern AS anz_rollsteige_ausserhalb,
  wd.anz_aufzuege_intern AS anz_aufzuege_intern,
  wd.anz_rollsteige_intern AS anz_rollsteige_intern,
  (
    1000 + w.mandant_id * 100 + w.vs_id * 10
  ) * -1 AS dummy,
  1 AS anz_diff_tage
FROM kfl_production_dbp_view.v_wup AS w
LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm AS wd
  ON w.wup_id = wd.wup_id AND w.mandant_id = wd.mandant_id;
