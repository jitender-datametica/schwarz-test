CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_kostenart_spr_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  LTRIM(COLLATE(kostenart_id, ''), '0') AS kostenart_id,
  krk_id AS krk_id,
  kostenart_bez AS kostenart_bez
FROM kfl_production_dbp_view.v_kostenart_spr_zu_2
WHERE
  mandant_id = 1 AND krk_id = 'XX01' AND spr_id = 22;
