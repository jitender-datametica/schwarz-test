CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_fur_prognose_artbew_wg_sum_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  wup_id AS wup_id,
  nb_id AS nb_id,
  mandant_id AS mandant_id,
  wg_id AS wg_id,
  dat AS dat,
  CAST(menge_prognose AS NUMERIC) AS menge_prognose,
  CAST(menge_prognose_bef AS NUMERIC) AS menge_prognose_bef,
  CAST(menge_prognose_max AS NUMERIC) AS menge_prognose_max,
  CAST(menge_af + menge_sa AS BIGNUMERIC) AS vk_menge,
  CAST(menge_af AS BIGNUMERIC) AS vk_menge_af,
  CAST(menge_sa AS BIGNUMERIC) AS vk_menge_sa,
  CAST(diff_menge_af_prognose AS NUMERIC) AS diff_menge_af_prognose
FROM kfl_production_dbp_view.v_fur_prognose_wg_sum_1 AS v01
WHERE
  mandant_id = 1;
