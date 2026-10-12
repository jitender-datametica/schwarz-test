CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_mietuebersicht_filter_2 (
  mandant_id BIGNUMERIC(38, 0),
  mv_intreno STRING(20),
  branche_id BIGNUMERIC(38, 0),
  konzessionaer_id STRING(10),
  mo_status_id BIGNUMERIC(38, 0)
) AS
SELECT DISTINCT
  mandant_id AS mandant_id,
  mv_intreno AS mv_intreno,
  branche_id AS branche_id,
  konzessionaer_id AS konzessionaer_id,
  mo_status_id AS mo_status_id
FROM kfl_production_dbp_msi_view_immo.mv_f_mietuebersicht_akt_2
WHERE
  mo_status_id = 4;
