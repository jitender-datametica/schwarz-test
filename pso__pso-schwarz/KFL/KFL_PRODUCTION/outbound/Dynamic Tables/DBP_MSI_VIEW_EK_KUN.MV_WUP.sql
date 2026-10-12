CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ek_kun.mv_wup
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id,
  v01.nb_id,
  v01.land_id,
  v01.wup_id,
  v01.wup_aenderung_grund_id, /* AP0204035/SPEC0256280 Erweiterung um neue Spalten / sschuecke 19.09.2024 */
  COALESCE(v04.aktuell_wup_id, v01.aktuell_wup_id) AS aktuell_wup_id1,
  COALESCE(
    MAX(v01.wup_id_alt) OVER (
      PARTITION BY CAST(v01.mandant_id AS STRING), CAST(COALESCE(v04.aktuell_wup_id, v01.aktuell_wup_id) AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ),
    v01.orig_wup_id
  ) AS orig_wup_id,
  CASE
    WHEN v01.wup_id = 0
    THEN 'REGISTERED AT HOME/NOT AVAILABLE'
    ELSE v01.wup_standort
  END AS wup_standort1,
  FIRST_VALUE(
    CASE
      WHEN v01.wup_id = 0
      THEN 'REGISTERED AT HOME/NOT AVAILABLE'
      ELSE v01.wup_standort
    END
  ) OVER (
    PARTITION BY CAST(v01.mandant_id AS STRING), CAST(COALESCE(v04.aktuell_wup_id, v01.aktuell_wup_id) AS STRING)
    ORDER BY v01.dat_von IS NULL, v01.dat_von
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS akt_wup_standort,
  CASE WHEN v01.vs_id >= 0 THEN v01.vs_id ELSE 0 END AS vs_id,
  CASE
    WHEN v01.gf_id > 0
    THEN v01.gf_id
    ELSE (
      1000 + v01.mandant_id * 100 + v01.vs_id * 10
    ) * -1
  END AS gf_id,
  CASE
    WHEN v01.vkl_id > 0
    THEN v01.vkl_id
    ELSE (
      1000 + v01.mandant_id * 100 + v01.vs_id * 10
    ) * -1
  END AS vkl_id,
  CASE
    WHEN v01.wm_id > 0
    THEN v01.wm_id
    ELSE (
      1000 + v01.mandant_id * 100 + v01.vs_id * 10
    ) * -1
  END AS wm_id,
  CASE
    WHEN v01.hl_id > 0
    THEN v01.hl_id
    ELSE (
      1000 + v01.mandant_id * 100 + v01.vs_id * 10
    ) * -1
  END AS hl_id,
  v01.vw_id,
  v01.vf_id,
  COALESCE(v03.region_id, v01.region_id, -v01.mandant_id) AS region_id,
  COALESCE(v03.wup_str, v01.wup_str, '') AS wup_str,
  COALESCE(v03.wup_plz, v01.wup_plz) AS wup_plz,
  COALESCE(v03.wup_stadt_1, v01.wup_stadt, '') AS wup_stadt,
  v01.breitengrad,
  v01.laengengrad, /* LATITUDE (BREITENGRAD) */
  FIRST_VALUE(v01.breitengrad) OVER (
    PARTITION BY CAST(v01.mandant_id AS STRING), CAST(COALESCE(v04.aktuell_wup_id, v01.aktuell_wup_id) AS STRING)
    ORDER BY v01.dat_von IS NULL, v01.dat_von
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS akt_breitengrad,
  FIRST_VALUE(v01.laengengrad) OVER (
    PARTITION BY CAST(v01.mandant_id AS STRING), CAST(COALESCE(v04.aktuell_wup_id, v01.aktuell_wup_id) AS STRING)
    ORDER BY v01.dat_von IS NULL, v01.dat_von
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS akt_laengengrad,
  (
    1000 + v01.mandant_id * 100 + v01.vs_id * 10
  ) * -1 AS dummy
FROM kfl_production_dbp_view.v_wup AS v01
LEFT JOIN kfl_production_dbp_view.v_vaus_wup AS v03
  ON v01.wup_id = v03.wup_id AND v01.mandant_id = v03.mandant_id
LEFT JOIN kfl_production_dbp_view.v_wup AS v04
  ON v01.mandant_id = v04.mandant_id
  AND v01.wup_id = v04.wup_id_alt
  AND v01.nb_id = v04.nb_id
UNION ALL
SELECT
  -1 AS mandant_id,
  -1 AS nb_id,
  '--' AS land_id,
  0 AS wup_id,
  0 AS wup_aenderung_grund_id,
  0 AS aktuell_wup_id,
  0 AS orig_wup_id,
  'UNKNOWN' AS wup_standort,
  'UNKNOWN' AS akt_wup_standort,
  0 AS vs_id,
  0 AS gf_id,
  0 AS vkl_id,
  0 AS wm_id,
  0 AS hl_id,
  0 AS vw_id,
  0 AS vf_id,
  0 AS region_id,
  '' AS wup_str,
  '' AS wup_plz,
  '' AS wup_stadt,
  0 AS breitengrad,
  0 AS laengengrad,
  0 AS akt_breitengrad,
  0 AS akt_laengengrad,
  0 AS dummy
FROM kfl_production_dbp_view.v_mandant
WHERE
  mandant_id = 1
/* AP0204035/SPEC0272918 Erweiterung um Dummyfiliale 0 pro Land zum CROSS JOIN mit mv_crm_l_kunde / sschuecke 17.10.2024 */
UNION ALL
SELECT
  1 AS mandant_id,
  0 AS nb_id,
  'DE' AS land_id,
  0 AS wup_id,
  0 AS wup_aenderung_grund_id,
  0 AS aktuell_wup_id,
  0 AS orig_wup_id,
  'REGISTERED AT HOME/NOT AVAILABLE' AS wup_standort,
  'REGISTERED AT HOME/NOT AVAILABLE' AS akt_wup_standort,
  0 AS vs_id,
  0 AS gf_id,
  0 AS vkl_id,
  0 AS wm_id,
  0 AS hl_id,
  0 AS vw_id,
  0 AS vf_id,
  0 AS region_id,
  '' AS wup_str,
  '' AS wup_plz,
  '' AS wup_stadt,
  0 AS breitengrad,
  0 AS laengengrad,
  0 AS akt_breitengrad,
  0 AS akt_laengengrad,
  0 AS dummy
FROM kfl_production_dbp_view.v_mandant
WHERE
  mandant_id = 1
UNION ALL
SELECT
  2 AS mandant_id,
  0 AS nb_id,
  'CZ' AS land_id,
  0 AS wup_id,
  0 AS wup_aenderung_grund_id,
  0 AS aktuell_wup_id,
  0 AS orig_wup_id,
  'REGISTERED AT HOME/NOT AVAILABLE' AS wup_standort,
  'REGISTERED AT HOME/NOT AVAILABLE' AS akt_wup_standort,
  0 AS vs_id,
  0 AS gf_id,
  0 AS vkl_id,
  0 AS wm_id,
  0 AS hl_id,
  0 AS vw_id,
  0 AS vf_id,
  0 AS region_id,
  '' AS wup_str,
  '' AS wup_plz,
  '' AS wup_stadt,
  0 AS breitengrad,
  0 AS laengengrad,
  0 AS akt_breitengrad,
  0 AS akt_laengengrad,
  0 AS dummy
FROM kfl_production_dbp_view.v_mandant
WHERE
  mandant_id = 2
UNION ALL
SELECT
  3 AS mandant_id,
  0 AS nb_id,
  'PL' AS land_id,
  0 AS wup_id,
  0 AS wup_aenderung_grund_id,
  0 AS aktuell_wup_id,
  0 AS orig_wup_id,
  'REGISTERED AT HOME/NOT AVAILABLE' AS wup_standort,
  'REGISTERED AT HOME/NOT AVAILABLE' AS akt_wup_standort,
  0 AS vs_id,
  0 AS gf_id,
  0 AS vkl_id,
  0 AS wm_id,
  0 AS hl_id,
  0 AS vw_id,
  0 AS vf_id,
  0 AS region_id,
  '' AS wup_str,
  '' AS wup_plz,
  '' AS wup_stadt,
  0 AS breitengrad,
  0 AS laengengrad,
  0 AS akt_breitengrad,
  0 AS akt_laengengrad,
  0 AS dummy
FROM kfl_production_dbp_view.v_mandant
WHERE
  mandant_id = 3
UNION ALL
SELECT
  4 AS mandant_id,
  0 AS nb_id,
  'MD' AS land_id,
  0 AS wup_id,
  0 AS wup_aenderung_grund_id,
  0 AS aktuell_wup_id,
  0 AS orig_wup_id,
  'REGISTERED AT HOME/NOT AVAILABLE' AS wup_standort,
  'REGISTERED AT HOME/NOT AVAILABLE' AS akt_wup_standort,
  0 AS vs_id,
  0 AS gf_id,
  0 AS vkl_id,
  0 AS wm_id,
  0 AS hl_id,
  0 AS vw_id,
  0 AS vf_id,
  0 AS region_id,
  '' AS wup_str,
  '' AS wup_plz,
  '' AS wup_stadt,
  0 AS breitengrad,
  0 AS laengengrad,
  0 AS akt_breitengrad,
  0 AS akt_laengengrad,
  0 AS dummy
FROM kfl_production_dbp_view.v_mandant
WHERE
  mandant_id = 4
UNION ALL
SELECT
  5 AS mandant_id,
  0 AS nb_id,
  'SK' AS land_id,
  0 AS wup_id,
  0 AS wup_aenderung_grund_id,
  0 AS aktuell_wup_id,
  0 AS orig_wup_id,
  'REGISTERED AT HOME/NOT AVAILABLE' AS wup_standort,
  'REGISTERED AT HOME/NOT AVAILABLE' AS akt_wup_standort,
  0 AS vs_id,
  0 AS gf_id,
  0 AS vkl_id,
  0 AS wm_id,
  0 AS hl_id,
  0 AS vw_id,
  0 AS vf_id,
  0 AS region_id,
  '' AS wup_str,
  '' AS wup_plz,
  '' AS wup_stadt,
  0 AS breitengrad,
  0 AS laengengrad,
  0 AS akt_breitengrad,
  0 AS akt_laengengrad,
  0 AS dummy
FROM kfl_production_dbp_view.v_mandant
WHERE
  mandant_id = 5
UNION ALL
SELECT
  6 AS mandant_id,
  0 AS nb_id,
  'HR' AS land_id,
  0 AS wup_id,
  0 AS wup_aenderung_grund_id,
  0 AS aktuell_wup_id,
  0 AS orig_wup_id,
  'REGISTERED AT HOME/NOT AVAILABLE' AS wup_standort,
  'REGISTERED AT HOME/NOT AVAILABLE' AS akt_wup_standort,
  0 AS vs_id,
  0 AS gf_id,
  0 AS vkl_id,
  0 AS wm_id,
  0 AS hl_id,
  0 AS vw_id,
  0 AS vf_id,
  0 AS region_id,
  '' AS wup_str,
  '' AS wup_plz,
  '' AS wup_stadt,
  0 AS breitengrad,
  0 AS laengengrad,
  0 AS akt_breitengrad,
  0 AS akt_laengengrad,
  0 AS dummy
FROM kfl_production_dbp_view.v_mandant
WHERE
  mandant_id = 6
UNION ALL
SELECT
  7 AS mandant_id,
  0 AS nb_id,
  'RO' AS land_id,
  0 AS wup_id,
  0 AS wup_aenderung_grund_id,
  0 AS aktuell_wup_id,
  0 AS orig_wup_id,
  'REGISTERED AT HOME/NOT AVAILABLE' AS wup_standort,
  'REGISTERED AT HOME/NOT AVAILABLE' AS akt_wup_standort,
  0 AS vs_id,
  0 AS gf_id,
  0 AS vkl_id,
  0 AS wm_id,
  0 AS hl_id,
  0 AS vw_id,
  0 AS vf_id,
  0 AS region_id,
  '' AS wup_str,
  '' AS wup_plz,
  '' AS wup_stadt,
  0 AS breitengrad,
  0 AS laengengrad,
  0 AS akt_breitengrad,
  0 AS akt_laengengrad,
  0 AS dummy
FROM kfl_production_dbp_view.v_mandant
WHERE
  mandant_id = 7
UNION ALL
SELECT
  8 AS mandant_id,
  0 AS nb_id,
  'BG' AS land_id,
  0 AS wup_id,
  0 AS wup_aenderung_grund_id,
  0 AS aktuell_wup_id,
  0 AS orig_wup_id,
  'REGISTERED AT HOME/NOT AVAILABLE' AS wup_standort,
  'REGISTERED AT HOME/NOT AVAILABLE' AS akt_wup_standort,
  0 AS vs_id,
  0 AS gf_id,
  0 AS vkl_id,
  0 AS wm_id,
  0 AS hl_id,
  0 AS vw_id,
  0 AS vf_id,
  0 AS region_id,
  '' AS wup_str,
  '' AS wup_plz,
  '' AS wup_stadt,
  0 AS breitengrad,
  0 AS laengengrad,
  0 AS akt_breitengrad,
  0 AS akt_laengengrad,
  0 AS dummy
FROM kfl_production_dbp_view.v_mandant
WHERE
  mandant_id = 8;