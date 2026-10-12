CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_f_it_projekt_verteilung_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  it_plan_ebene_id AS it_plan_ebene_id,
  it_projekt_id AS it_projekt_id,
  gj AS gj,
  berichts_position_it_id AS berichts_position_it_id,
  verteilung_quote AS verteilung_quote,
  verteilung_betrag AS verteilung_betrag
FROM kfl_production_dbp_view.v_it_projekt_verteilung_laender_2 AS v01
WHERE
  NOT berichts_position_it_id IN (1, 3, 5, 7, 8, 9, 10, 13, 17, 18, 19, 20, 14, 21)
UNION ALL
SELECT
  1 AS it_plan_ebene_id,
  v01.it_projekt_id,
  v01.gj,
  v01.berichts_position_it_id,
  100 AS verteilung_quote,
  v01.plan_betrag AS verteilung_betrag
FROM kfl_production_dbp_view.v_it_projekt_plan_det_2 AS v01
INNER JOIN (
  SELECT
    it_projekt_id,
    gj,
    MAX(plan_revision_id) AS max_revision
  FROM kfl_production_dbp_view.v_it_projekt_plan_det_2
  GROUP BY
    it_projekt_id,
    gj
) AS v02
  ON v01.it_projekt_id = v02.it_projekt_id
  AND v01.plan_revision_id = v02.max_revision
  AND v01.gj = v02.gj
WHERE
  v01.berichts_position_it_id IN (1, 3, 5, 7, 8, 9, 10, 13, 17, 18, 19, 20, 21);
