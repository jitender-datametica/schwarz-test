CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_sternchen_logik_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  lsl.art_id AS art_id,
  lsl.sm_id AS sm_id,
  lsl.mandant_id AS mandant_id,
  lsl.list_durchg_fg AS list_durchg_fg,
  lsl.anzahl_markt_soll AS anzahl_markt,
  ls.sternchen_id AS sternchen_id
FROM kfl_production_dbp_view.v_sternchen_logik_2 AS lsl
INNER JOIN kfl_production_dbp_view.v_l_sternchen_2 AS ls
  ON lsl.list_durchg_fg = ls.list_durchg_fg
  AND lsl.bezugsweg1_fg = ls.bezugsweg1_fg
  AND lsl.bezugsweg4_fg = ls.bezugsweg4_fg
  AND lsl.kdis0_fg = ls.kdis0_fg
  AND lsl.kdis1_fg = ls.kdis1_fg
  AND lsl.mandant_id = ls.mandant_id
WHERE
  lsl.mandant_id = 1;
