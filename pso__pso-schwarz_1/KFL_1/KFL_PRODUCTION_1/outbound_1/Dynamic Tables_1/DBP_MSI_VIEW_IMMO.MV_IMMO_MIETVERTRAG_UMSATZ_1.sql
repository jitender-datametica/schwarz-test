CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_umsatz_1 (
  branche_id BIGNUMERIC(38, 0),
  mandant_id BIGNUMERIC(38, 0),
  mietvertrag_nr STRING,
  mv_intreno STRING,
  partner_id STRING,
  konzessionaer_id STRING,
  vertragsart_id BIGNUMERIC(38, 0),
  kjmo BIGNUMERIC(38, 0),
  max_melderegel STRING,
  interval_months BIGNUMERIC(38, 0),
  melderegel STRING,
  rhythmus_art STRING,
  umsatz_brutto NUMERIC(18, 2),
  umsatz_netto BIGNUMERIC(21, 2),
  umsatzkennung STRING,
  version STRING,
  wrg_id STRING,
  wrg_typ_id BIGNUMERIC(38, 0),
  kj BIGNUMERIC(38, 0),
  akt_kj BIGNUMERIC(38, 0),
  akt_mo BIGNUMERIC(38, 0),
  akt INT64
) AS
WITH max_version_cte /* 1. Pre-calculate MAX(VERSION) to de-correlate the first subquery */ AS (
  SELECT
    mv_intreno,
    kjmo,
    melderegel,
    MAX(version) AS max_ver
  FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_1
  GROUP BY
    mv_intreno,
    kjmo,
    melderegel
), max_intreno_cte /* 2. Pre-calculate MAX(MV_INTRENO) to de-correlate the second subquery */ AS (
  SELECT
    mandant_id,
    mietvertrag_nr,
    kjmo,
    wrg_id,
    melderegel,
    version,
    MAX(mv_intreno) AS max_intr
  FROM kfl_production_dbp_msi_view_immo.mv_immo_altvertraege_map_1
  GROUP BY
    mandant_id,
    mietvertrag_nr,
    kjmo,
    wrg_id,
    melderegel,
    version
)
/* Part 1: National Currency */
SELECT DISTINCT
  v1.branche_id AS branche_id,
  v1.mandant_id AS mandant_id,
  v1.mietvertrag_nr AS mietvertrag_nr,
  v9.mv_intreno_akt AS mv_intreno,
  v1.partner_id AS partner_id,
  v9.konzessionaer_id_akt AS konzessionaer_id,
  v1.vertragsart_id AS vertragsart_id,
  v2.kjmo AS kjmo,
  v77.melderegel_max AS max_melderegel,
  CASE
    WHEN v77.melderegel_max = v2.melderegel
    THEN CAST(ROUND(CAST(SUBSTR(CAST(v2.dat_meldungsintervall_bis AS STRING), 6, 2) AS BIGNUMERIC), 0) - ROUND(CAST(SUBSTR(CAST(v2.dat_meldungsintervall_von AS STRING), 6, 2) AS BIGNUMERIC), 0) + 1 AS BIGNUMERIC)
    ELSE CAST(0 AS BIGNUMERIC)
  END AS interval_months,
  v2.melderegel AS melderegel,
  v2.rhythmus_art AS rhythmus_art,
  v2.umsatz_brutto AS umsatz_brutto,
  v2.umsatz_netto AS umsatz_netto,
  v2.umsatzkennung AS umsatzkennung,
  v2.version AS version,
  v2.wrg_id AS wrg_id,
  v6.wrg_typ_id AS wrg_typ_id,
  v8.kj AS kj,
  v8.akt_kj AS akt_kj,
  v8.akt_mo AS akt_mo,
  0 AS akt
FROM kfl_production_dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf_1 AS v1
INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_1 AS v2
  ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_typ_zu_1 AS v6
  ON v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_kj_monat_1 AS v8
  ON v2.kjmo = v8.kjmo
INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf_1 AS v9
  ON v1.mietvertrag_nr = v9.mietvertrag_nr AND v1.mandant_id = v9.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_melderegel_count_1 AS v77
  ON v1.mandant_id = v77.mandant_id
  AND v2.mv_intreno = v77.mv_intreno
  AND v2.kjmo = v77.kjmo
/* JOIN CTE 1: Replaces "V2.version = (SELECT MAX(version)...)" */
INNER JOIN max_version_cte AS mv_ver
  ON v2.mv_intreno = mv_ver.mv_intreno
  AND v2.kjmo = mv_ver.kjmo
  AND v2.melderegel = mv_ver.melderegel
  AND v2.version = mv_ver.max_ver
/* JOIN CTE 2: Replaces "V1.mv_intreno = (SELECT MAX(mv_intreno)...)" */
INNER JOIN max_intreno_cte AS mv_intr
  ON v1.mandant_id = mv_intr.mandant_id
  AND v1.mietvertrag_nr = mv_intr.mietvertrag_nr
  AND v2.kjmo = mv_intr.kjmo
  AND v2.wrg_id = mv_intr.wrg_id
  AND v2.melderegel = mv_intr.melderegel
  AND v2.version = mv_intr.version
  AND v1.mv_intreno = mv_intr.max_intr
WHERE
  v2.nullumsatz <> 'X' AND v2.umsatz_netto > 0 AND v2.rhythmus_art = '0001'
UNION ALL
/* Part 2: EUR Converted */
SELECT DISTINCT
  v1.branche_id,
  v1.mandant_id,
  v1.mietvertrag_nr,
  v9.mv_intreno_akt AS mv_intreno,
  v1.partner_id,
  v9.konzessionaer_id_akt AS konzessionaer_id,
  v1.vertragsart_id,
  v2.kjmo,
  v77.melderegel_max AS max_melderegel,
  CASE
    WHEN v77.melderegel_max = v2.melderegel
    THEN CAST(ROUND(CAST(SUBSTR(CAST(v2.dat_meldungsintervall_bis AS STRING), 6, 2) AS BIGNUMERIC), 0) - ROUND(CAST(SUBSTR(CAST(v2.dat_meldungsintervall_von AS STRING), 6, 2) AS BIGNUMERIC), 0) + 1 AS BIGNUMERIC)
    ELSE CAST(0 AS BIGNUMERIC)
  END AS interval_months,
  v2.melderegel,
  v2.rhythmus_art,
  v2.umsatz_brutto,
  CAST(v2.umsatz_netto / NULLIF(v7.kurs_zu_euro, 0) AS BIGNUMERIC) AS umsatz_netto,
  v2.umsatzkennung,
  v2.version,
  'EUR' AS wrg_id,
  CAST(0 AS BIGNUMERIC) AS wrg_typ_id,
  v8.kj,
  v8.akt_kj,
  v8.akt_mo,
  0 AS akt
FROM kfl_production_dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf_1 AS v1
INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_1 AS v2
  ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_typ_zu_1 AS v6
  ON v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_wrg_1 AS v7
  ON v2.wrg_id = v7.wrg_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_kj_monat_1 AS v8
  ON v2.kjmo = v8.kjmo
INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf_1 AS v9
  ON v1.mietvertrag_nr = v9.mietvertrag_nr AND v1.mandant_id = v9.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_melderegel_count_1 AS v77
  ON v1.mandant_id = v77.mandant_id
  AND v2.mv_intreno = v77.mv_intreno
  AND v2.kjmo = v77.kjmo
/* JOIN CTE 1 (Same logic as above) */
INNER JOIN max_version_cte AS mv_ver
  ON v2.mv_intreno = mv_ver.mv_intreno
  AND v2.kjmo = mv_ver.kjmo
  AND v2.melderegel = mv_ver.melderegel
  AND v2.version = mv_ver.max_ver
/* JOIN CTE 2 (Same logic as above) */
INNER JOIN max_intreno_cte AS mv_intr
  ON v1.mandant_id = mv_intr.mandant_id
  AND v1.mietvertrag_nr = mv_intr.mietvertrag_nr
  AND v2.kjmo = mv_intr.kjmo
  AND v2.wrg_id = mv_intr.wrg_id
  AND v2.melderegel = mv_intr.melderegel
  AND v2.version = mv_intr.version
  AND v1.mv_intreno = mv_intr.max_intr
WHERE
  v2.nullumsatz <> 'X' AND v2.umsatz_netto > 0 AND v2.rhythmus_art = '0001';
