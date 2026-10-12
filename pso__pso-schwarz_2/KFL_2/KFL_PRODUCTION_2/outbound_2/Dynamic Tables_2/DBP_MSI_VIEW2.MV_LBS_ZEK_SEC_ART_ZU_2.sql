CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_lbs_zek_sec_art_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  art2gp.art_id AS art_id,
  art2gp.mandant_id AS mandant_id,
  gp2zek.zek_id AS zek_id
FROM kfl_production_dbp_view.v_art_gp_zu_per_2 AS art2gp
INNER JOIN kfl_production_dbp_view.v_gp_2 AS gp2zek
  ON art2gp.gp_id = gp2zek.gp_id
  AND art2gp.dat_bis = CAST('9999-12-31' AS DATE)
  AND gp2zek.dat_bis = CAST('9999-12-31' AS DATE)
  AND art2gp.mandant_id = 1
  AND gp2zek.mandant_id = 1;
