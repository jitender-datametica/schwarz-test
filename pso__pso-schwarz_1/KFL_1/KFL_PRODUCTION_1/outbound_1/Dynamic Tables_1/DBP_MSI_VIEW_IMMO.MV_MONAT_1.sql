CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_monat_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  m.kjmo AS kjmo,
  m.kj AS kj,
  m.mo_kj AS mo_kj,
  m.min_dat AS dat_mo_beginn,
  m.max_dat AS dat_mo_ende,
  m.gjmo AS gjmo,
  m.gj AS gj,
  m.mo_gj AS mo_gj,
  m.akt_gj AS akt_gj,
  m.akt_gj_komplett AS akt_gj_komplett,
  m.akt_mo AS akt_mo,
  m.akt_mo_komplett AS akt_mo_komplett,
  COALESCE(k.akt_buchungs_schluss, 99) AS akt_buchungs_schluss,
  TRIM(s.mo_bez) AS mo_bez,
  TRIM(s.mo_bez) || ' ' || TRIM(SUBSTR(CAST(m.kj AS STRING), 1, 39)) AS mo_bez_land,
  SUBSTR(TRIM(s.mo_bez), 1, 3) || ' ' || SUBSTR(SUBSTR(CAST(m.kj AS STRING), 1, 4), 3, 4) AS mo_bez_kurz,
  s.spr_id AS spr_id,
  CASE WHEN MOD(CAST(m.kjmo AS BIGNUMERIC), 100) <= 6 THEN 1 ELSE 2 END AS hj
FROM kfl_production_dbp_view.v_monat_1 AS m
LEFT JOIN kfl_production_dbp_view.v_l_buchungsstatus_ker_1 AS k
  ON m.kjmo = k.kj_ker_mo_id
INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS s
  ON m.mo_kj = s.mo_id AND s.spr_id = 22
WHERE
  m.akt_gj BETWEEN -5 AND 1;
