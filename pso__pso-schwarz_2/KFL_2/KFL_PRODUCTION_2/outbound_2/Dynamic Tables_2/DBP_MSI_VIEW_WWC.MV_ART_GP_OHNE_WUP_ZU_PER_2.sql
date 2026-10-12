CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_art_gp_ohne_wup_zu_per_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v100.mandant_id AS mandant_id,
  v100.art_id AS art_id,
  v100.gp_id AS gp_id,
  v100.dat AS dat,
  MAX(COALESCE(v200.ek_nettonetto, v100.ek_nettonetto)) AS ek_nettonetto,
  MAX(COALESCE(v200.ek_netto, v100.ek_netto)) AS ek_netto,
  MAX(COALESCE(v200.ek_brutto, v100.ek_brutto)) AS ek_brutto,
  MAX(COALESCE(v200.ek_mep, v100.ek_mep)) AS ek_mep,
  MAX(COALESCE(v200.einstandspreis, v100.einstandspreis)) AS einstandspreis,
  MAX(COALESCE(v200.bonusbasis, v100.bonusbasis)) AS bonusbasis,
  MAX(COALESCE(v200.bezugsnebenkosten, v100.bezugsnebenkosten)) AS bezugsnebenkosten,
  MAX(COALESCE(v200.ek_mep_vor_fwu, v100.ek_mep_vor_fwu)) AS ek_mep_vor_fwu,
  MAX(COALESCE(v200.ek_netto_bnk, v100.ek_netto_bnk)) AS ek_netto_bnk,
  MAX(COALESCE(v200.ek_netto_bnk_sachk, v100.ek_netto_bnk_sachk)) AS ek_netto_bnk_sachk,
  MAX(COALESCE(v200.logistikkostenzuschlag, v100.logistikkostenzuschlag)) AS logistikkostenzuschlag
FROM (
  SELECT
    v01.mandant_id,
    v01.art_id,
    v01.gp_id,
    v01.wup_id,
    v01.nb_id,
    v02.dat,
    v01.ek_nettonetto,
    v01.ek_netto,
    v01.ek_brutto,
    v01.ek_mep,
    v01.einstandspreis,
    v01.bonusbasis,
    v01.bezugsnebenkosten,
    v01.ek_mep_vor_fwu,
    v01.ek_netto_bnk,
    v01.ek_netto_bnk_sachk,
    v01.logistikkostenzuschlag
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_2 AS v01
  LEFT JOIN (
    SELECT
      dat,
      kjmo,
      kjwo,
      kj,
      akt_kj
    FROM kfl_production_dbp_view.v_tag_2 AS v01
    WHERE
      akt_kj BETWEEN -3 AND 2
    UNION ALL
    SELECT
      CAST('9999-12-31' AS DATE) AS dat,
      999912 AS kjmo,
      999952 AS kjwo,
      9999 AS kj,
      9999 AS akt_kj
  ) AS v02
    ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
) AS v100
LEFT JOIN (
  SELECT
    v01.mandant_id,
    v01.art_id,
    v01.gp_id,
    v02.dat,
    v01.ek_nettonetto,
    v01.ek_netto,
    v01.ek_brutto,
    v01.ek_mep,
    v01.einstandspreis,
    v01.bonusbasis,
    v01.bezugsnebenkosten,
    v01.ek_mep_vor_fwu,
    v01.ek_netto_bnk,
    v01.ek_netto_bnk_sachk,
    v01.logistikkostenzuschlag
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_2 AS v01
  LEFT JOIN (
    SELECT
      dat,
      kjmo,
      kjwo,
      kj,
      akt_kj
    FROM kfl_production_dbp_view.v_tag_2 AS v01
    WHERE
      akt_kj BETWEEN -3 AND 2
    UNION ALL
    SELECT
      CAST('9999-12-31' AS DATE) AS dat,
      999912 AS kjmo,
      999952 AS kjwo,
      9999 AS kj,
      9999 AS akt_kj
  ) AS v02
    ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
  WHERE
    v01.nb_id = -111
  QUALIFY
    (
      ROW_NUMBER() OVER (
        PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.art_id AS STRING), CAST(v01.gp_id AS STRING), v02.dat
        ORDER BY v01.wup_id IS NULL, v01.wup_id
      )
    ) = 1
) AS v200
  ON v100.mandant_id = v200.mandant_id
  AND v100.art_id = v200.art_id
  AND v100.gp_id = v200.gp_id
  AND v100.dat = v200.dat
GROUP BY
  v100.mandant_id,
  v100.art_id,
  v100.gp_id,
  v100.dat;