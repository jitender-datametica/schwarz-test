CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_wup_autodispo_flw_tag_unfiltered AS SELECT mandant_id,
 kunde_id AS wup_id,
 wup_id AS wup_id_fleischwerk,
 nb_id_kunde AS nb_id,
 nb_id_lieferant AS nb_id_vz,
 art_id,
 dat,
 COALESCE(we_bearbeitungszeit, - 1) AS we_bearbeitungszeit,
 COALESCE(planlieferzeit, - 1) AS planlieferzeit,
 kdis,
 verkaufslistung_fg,
 sa_af_fg AS sa_af_fg_id,
  CASE
  WHEN sa_af_fg = 0
  THEN 'AF'
  WHEN sa_af_fg = 1
  THEN 'SA'
  ELSE '--'
  END AS sa_af_fg,
 udf_prognose_menge_gesteuert,
 udf_prognose_menge_ungesteuert,
  CASE
  WHEN sa_af_fg = 0
  THEN udf_prognose_menge_gesteuert
  ELSE 0
  END AS udf_prognose_menge_gesteuert_af,
  CASE
  WHEN sa_af_fg = 1
  THEN udf_prognose_menge_gesteuert
  ELSE 0
  END AS udf_prognose_menge_gesteuert_sa,
  CASE
  WHEN sa_af_fg = 0
  THEN udf_prognose_menge_ungesteuert
  ELSE 0
  END AS udf_prognose_menge_ungesteuert_af,
  CASE
  WHEN sa_af_fg = 1
  THEN udf_prognose_menge_ungesteuert
  ELSE 0
  END AS udf_prognose_menge_ungesteuert_sa,
 fur_prognose_menge_ungesteuert,
 fur_prognose_menge_gesteuert,
 fur_prognose_menge_max,
 menge_abverkauf,
  CASE
  WHEN sa_af_fg = 0
  THEN menge_abverkauf
  ELSE 0
  END AS menge_abverkauf_af,
  CASE
  WHEN sa_af_fg = 1
  THEN menge_abverkauf
  ELSE 0
  END AS menge_abverkauf_sa,
 ABS(menge_abverkauf - fur_prognose_menge_ungesteuert) AS abs_diff_fur_ungesteuert,
  CASE
  WHEN sa_af_fg = 0
  THEN ABS(menge_abverkauf - fur_prognose_menge_ungesteuert)
  ELSE NULL
  END AS abs_diff_fur_ungesteuert_af,
  CASE
  WHEN sa_af_fg = 1
  THEN ABS(menge_abverkauf - fur_prognose_menge_ungesteuert)
  ELSE NULL
  END AS abs_diff_fur_ungesteuert_sa,
 ABS(menge_abverkauf - fur_prognose_menge_gesteuert) AS abs_diff_fur_gesteuert,
  CASE
  WHEN sa_af_fg = 0
  THEN ABS(menge_abverkauf - fur_prognose_menge_gesteuert)
  ELSE NULL
  END AS abs_diff_fur_gesteuert_af,
  CASE
  WHEN sa_af_fg = 1
  THEN ABS(menge_abverkauf - fur_prognose_menge_gesteuert)
  ELSE NULL
  END AS abs_diff_fur_gesteuert_sa,
 ret_bestand,
 fur_bestand,
 menge_we_offen,
 menge_bv,
 menge_ofc,
 COALESCE(nullbestand_fg, - 1) AS nullbestand_fg,
 menge_totalabschriften,
 menge_preisabschriften,
 kollifaktor,
 egalisierungsfaktor,
 menge_einh_id,
 servicelevel,
 optik,
 menge_we,
 nullbestand_exc_fg
FROM kfl_production_dbp_view.v_art_wup_autodispo_flw_tag AS V1;