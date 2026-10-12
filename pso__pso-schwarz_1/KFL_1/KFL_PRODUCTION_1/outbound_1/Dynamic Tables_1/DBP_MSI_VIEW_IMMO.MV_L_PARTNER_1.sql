CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_partner_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  partner_id AS partner_id,
  partner_id AS konzessionaer_id,
  anrede AS anrede,
  vorname AS vorname,
  nachname AS nachname,
  gebiet_id AS gebiet_id,
  verbund_kz AS verbund_kz
FROM kfl_production_dbp_view.v_immo_l_partner_1
UNION DISTINCT
SELECT DISTINCT
  '' AS partner_id,
  '-1' AS konzessionaer_id,
  '' AS anrede,
  '' AS vorname,
  '' AS nachname,
  CAST(NULL AS BIGNUMERIC) AS gebiet_id,
  '' AS verbund_kz
FROM kfl_production_dbp_view.v_mandant_1;
