CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_sternchen_logik_kreis_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.art_id AS art_id,
  v01.kreistyp_gruppe_id AS kreistyp_gruppe_id,
  v01.mandant_id AS mandant_id,
  v01.list_durchg_fg AS list_durchg_fg,
  v01.anzahl_markt_soll AS anzahl_markt,
  v02.sternchen_id AS sternchen_id
FROM kfl_production_dbp_view.v_sternchen_logik_kreis_2 AS v01
INNER JOIN kfl_production_dbp_view.v_l_sternchen_2 AS v02
  ON v01.list_durchg_fg = v02.list_durchg_fg
  AND v01.bezugsweg1_fg = v02.bezugsweg1_fg
  AND v01.bezugsweg4_fg = v02.bezugsweg4_fg
  AND v01.kdis0_fg = v02.kdis0_fg
  AND v01.kdis1_fg = v02.kdis1_fg
  AND v01.mandant_id = v02.mandant_id
WHERE
  v01.mandant_id = 1;
