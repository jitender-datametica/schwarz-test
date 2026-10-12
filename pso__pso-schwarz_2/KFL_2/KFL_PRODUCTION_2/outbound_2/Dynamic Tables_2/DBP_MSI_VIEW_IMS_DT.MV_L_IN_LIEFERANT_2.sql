CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_in_lieferant_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  in_lief_id AS in_lief_id,
  mandant_id AS mandant_id,
  LTRIM(COLLATE(in_lief_nr, ''), '0') AS in_lief_nr,
  lief_name_1 || ' ' || lief_name_2 AS lief_name
FROM kfl_production_dbp_view.v_in_lieferant_2;
