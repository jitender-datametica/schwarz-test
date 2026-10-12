CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_artbew_wg_sum_nonpseudo
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  c.art_id AS art_id,
  SUM(CAST(c.menge AS BIGNUMERIC)) AS vk_menge,
  c.dat AS dat,
  a.mandant_id AS mandant_id,
  c.nb_id AS nb_id,
  a.wg_art_fg AS wg_art_fg,
  c.wup_id AS wup_id
FROM kfl_production_dbp_view.v_art AS a
INNER JOIN kfl_production_dbp_view.v_artbew AS c
  ON a.art_id = c.art_id
WHERE
  a.wg_art_fg = 0 AND a.mandant_id = 1
GROUP BY
  c.art_id,
  c.dat,
  a.mandant_id,
  c.nb_id,
  a.wg_art_fg,
  c.wup_id;
