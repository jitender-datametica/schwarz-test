CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_ims_projekt
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.in_projekt_id AS in_projekt_id,
  CASE
    WHEN v01.ims_projekt_typ_id = 'P' AND t0.statistisch_fg = 1
    THEN t0.psp_id_char
    ELSE v01.in_projekt_id_char
  END AS in_projekt_id_char,
  v01.projekt_ext_id AS projekt_ext_id,
  v01.in_projekt_bez AS in_projekt_bez,
  v01.ims_projekt_typ_id AS projekt_typ_id,
  v01.standort_id AS standort_id,
  COALESCE(v01.in_budget_typ_id, '-1') AS in_budget_typ_id,
  COALESCE(v01.dat_massnahme_ende, CAST('2010-01-01' AS DATE)) AS dat_massnahme_ende
FROM kfl_production_dbp_view.v_in_projekt AS v01
LEFT JOIN (
  SELECT
    in_projekt_id,
    mandant_id,
    MAX(statistisch_fg) AS statistisch_fg,
    MAX(psp_id_char) AS psp_id_char
  FROM kfl_production_dbp_view.v_in_psp_element
  GROUP BY
    mandant_id,
    in_projekt_id
) AS t0
  ON v01.in_projekt_id = t0.in_projekt_id AND v01.mandant_id = t0.mandant_id
WHERE
  v01.krk_id <> 'DE02' OR v01.mandant_id <> 1;
