CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_kmo.mv_monat_2 (
  kjmo BIGNUMERIC(38, 0),
  gjmo BIGNUMERIC(38, 0),
  gjmo_vj BIGNUMERIC(38, 0),
  kjmo_vj BIGNUMERIC(38, 0),
  mo_kj BIGNUMERIC(38, 0),
  akt_mo BIGNUMERIC(38, 0),
  akt_mo_komplett BIGNUMERIC(38, 0),
  kjqu BIGNUMERIC(38, 0),
  gjqu BIGNUMERIC(38, 0),
  akt_kjqu BIGNUMERIC(38, 0),
  akt_kjqu_komplett BIGNUMERIC(38, 0),
  kj BIGNUMERIC(38, 0),
  gj BIGNUMERIC(38, 0),
  akt_kj BIGNUMERIC(38, 0),
  akt_kj_komplett BIGNUMERIC(38, 0),
  akt_gj BIGNUMERIC(38, 0),
  kjmo_vm BIGNUMERIC(38, 0),
  akt_mo_kalendarisch BIGNUMERIC(38, 0)
) AS
SELECT
  kjmo AS kjmo,
  gjmo AS gjmo,
  gjmo_vj AS gjmo_vj,
  kjmo_vj AS kjmo_vj,
  mo_kj AS mo_kj,
  akt_mo AS akt_mo,
  akt_mo_komplett AS akt_mo_komplett,
  kjqu AS kjqu,
  gjqu AS gjqu,
  akt_kjqu AS akt_kjqu,
  akt_kjqu_komplett AS akt_kjqu_komplett,
  kj AS kj,
  gj AS gj,
  akt_kj AS akt_kj,
  akt_kj_komplett AS akt_kj_komplett,
  akt_gj AS akt_gj,
  ROUND(
    CAST(FORMAT_DATE(
      '%Y%m',
      IF(
        PARSE_DATE('%Y%m', SAFE_CAST(kjmo AS STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(kjmo AS STRING))),
        LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(kjmo AS STRING)), INTERVAL '1' MONTH)),
        DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(kjmo AS STRING)), INTERVAL '1' MONTH)
      )
    ) AS BIGNUMERIC),
    0
  ) AS kjmo_vm,
  (
    kj - EXTRACT(YEAR FROM CURRENT_DATE)
  ) * 12 + MOD(CAST(kjmo AS BIGNUMERIC), 100) - EXTRACT(MONTH FROM CURRENT_DATE) AS akt_mo_kalendarisch
FROM kfl_production_dbp_view.v_monat_2;
