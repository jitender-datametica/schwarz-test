CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_objekt_debitor_zu_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  dp.mandant_id AS mandant_id,
  dp.debitor_id AS debitor_id,
  COALESCE(sub01.immo_objekt_id, 'IW----------0') AS immo_objekt_id
FROM kfl_production_dbp_view.v_ivs_debitor_per_1 AS dp
LEFT JOIN (
  SELECT DISTINCT
    mandant_id,
    debitor_id,
    immo_objekt_id
  FROM kfl_production_dbp_view.v_ivs_mietertrag_detail_1 AS med
  WHERE
    mandant_id <> 1
  UNION ALL
  SELECT DISTINCT
    mandant_id,
    debitor_id,
    immo_objekt_id
  FROM kfl_production_dbp_view.v_ivs_debitor_immo_objekt_zu_1 AS dioz
  WHERE
    mandant_id = 1
) AS sub01
  ON dp.mandant_id = sub01.mandant_id AND dp.debitor_id = sub01.debitor_id
WHERE
  dp.ivs_fg = 1;
