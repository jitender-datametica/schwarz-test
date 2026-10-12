CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_fur_prognose_artbew_wo_sum_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  wup_id AS wup_id,
  nb_id AS nb_id,
  mandant_id AS mandant_id,
  art_id AS art_id,
  kjwo_kl AS kjwo_kl,
  CAST(menge_prognose AS NUMERIC) AS menge_prognose,
  CAST(menge_prognose_bef AS NUMERIC) AS menge_prognose_bef,
  CAST(menge_prognose_max AS NUMERIC) AS menge_prognose_max,
  CAST(menge_af + menge_sa AS BIGNUMERIC) AS vk_menge,
  CAST(menge_af AS BIGNUMERIC) AS vk_menge_af,
  CAST(menge_sa AS BIGNUMERIC) AS vk_menge_sa,
  CAST(diff_menge_af_prognose AS NUMERIC) AS diff_menge_af_prognose,
  sum_progn_groesser AS sum_progn_groesser,
  sum_menge_af_groesser AS sum_menge_af_groesser,
  CAST(menge_af_mittel_3wo AS NUMERIC) AS menge_af_mittel_3wo,
  progn_groesser_wo_fg AS progn_groesser_wo_fg,
  menge_af_groesser_wo_fg AS menge_af_groesser_wo_fg,
  progn_grosser_wo0_fg AS progn_grosser_wo0_fg,
  progn_groesser_wo1_fg AS progn_groesser_wo1_fg,
  progn_groesser_wo2_fg AS progn_groesser_wo2_fg,
  menge_af_groesser_wo0_fg AS menge_af_groesser_wo0_fg,
  menge_af_groesser_wo1_fg AS menge_af_groesser_wo1_fg,
  menge_af_groesser_wo2_fg AS menge_af_groesser_wo2_fg
FROM kfl_production_dbp_view.v_fur_prognose_wo_sum_2 AS v01
WHERE
  mandant_id = 1;
