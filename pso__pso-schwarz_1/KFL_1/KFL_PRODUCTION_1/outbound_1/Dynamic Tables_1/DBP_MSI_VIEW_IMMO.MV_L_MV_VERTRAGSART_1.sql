CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_mv_vertragsart_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v0.vertragsart_id AS vertragsart_id,
  v1.vertragsart_bez AS vertragsart_bez
FROM kfl_production_dbp_view.v_immo_l_vertragsart_1 AS v0
INNER JOIN kfl_production_dbp_view.v_immo_vertragsart_spr_zu_1 AS v1
  ON v0.mandant_id = v1.mandant_id
  AND v0.vertragsart_id = v1.vertragsart_id
  AND v1.spr_id = 22
WHERE
  v0.mandant_id = 1
UNION ALL
SELECT
  0 AS vertragsart_id,
  '' AS vertragsart_bez
FROM kfl_production_dbp_view.v_mandant_1
WHERE
  mandant_id = 1;
