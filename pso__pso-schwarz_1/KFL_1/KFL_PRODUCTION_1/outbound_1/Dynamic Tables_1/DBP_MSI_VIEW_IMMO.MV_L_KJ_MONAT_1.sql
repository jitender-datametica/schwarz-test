CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_kj_monat_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v_monat.kjmo AS kjmo,
  v_monat.kjmo_vj AS kjmo_vj,
  v_monat.gjmo AS gjmo,
  v_monat.kjqu AS kjqu,
  v_monat.kj AS kj,
  v_monat.gj AS gj,
  v_monat.akt_gj AS akt_gj,
  v_monat.akt_mo AS akt_mo,
  v_monat.akt_mo_komplett AS akt_mo_komplett,
  v_monat.akt_kjqu AS akt_kjqu,
  v_monat.akt_kjqu_komplett AS akt_kjqu_komplett,
  v_monat.akt_kj AS akt_kj,
  v_monat.akt_kj_komplett AS akt_kj_komplett,
  v_monat.mo_kj AS mo_kj,
  v_monat.min_dat AS min_dat,
  v_monat.max_dat AS max_dat,
  ROUND(
    CAST(FORMAT_DATE(
      '%Y%m',
      IF(
        PARSE_DATE('%Y%m', SAFE_CAST(v_monat.kjmo AS STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(v_monat.kjmo AS STRING))),
        LAST_DAY(
          DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(v_monat.kjmo AS STRING)), INTERVAL '-1' MONTH)
        ),
        DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(v_monat.kjmo AS STRING)), INTERVAL '-1' MONTH)
      )
    ) AS BIGNUMERIC),
    0
  ) AS kjmo_vm,
  v1.akt_buchungs_schluss AS akt_buchungs_schluss,
  CASE WHEN v2.mo_id = 3 AND v2.spr_id = 22 THEN 'März' ELSE v2.mo_bez END AS kjmo_bez,
  SUBSTR(v2.mo_bez, 0, 3) || ' ' || SUBSTR(SUBSTR(CAST(v_monat.kj AS STRING), 1, 39), 3, 2) AS kjmo_bez_kurz,
  CASE
    WHEN v2.mo_id = 3 AND v2.spr_id = 22
    THEN 'Mrz'
    ELSE SUBSTR(v2.mo_bez, 0, 3)
  END AS kjmo_kurz_bez,
  v1.buchungs_schluss_akt AS kjmo_buchungsschluss
FROM kfl_production_dbp_view.v_monat_1
LEFT JOIN kfl_production_dbp_view.v_l_buchungsstatus_ker_1 AS v1
  ON v_monat.kjmo = v1.kj_ker_mo_id
LEFT JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS v2
  ON v_monat.mo_kj = v2.mo_id
WHERE
  v2.spr_id = 22;
