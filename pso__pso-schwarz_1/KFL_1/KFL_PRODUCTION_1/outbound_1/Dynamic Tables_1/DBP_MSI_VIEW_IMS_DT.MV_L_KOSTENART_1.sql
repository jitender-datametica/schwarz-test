CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_kostenart_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  LTRIM(COLLATE(kostenart_id, ''), '0') AS kostenart_id,
  krk_id AS krk_id,
  kontenplan_id AS kontenplan_id,
  kostenart_altnv_id AS kostenart_altnv_id,
  kostenart_grp_id AS kostenart_grp_id
FROM kfl_production_dbp_view.v_kostenart_1
WHERE
  mandant_id = 1 AND krk_id = 'XX01';
