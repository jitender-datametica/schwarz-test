CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_umsatz_12 AS
SELECT DISTINCT
  v1.branche_id,
  v1.mandant_id,
  v1.mietvertrag_nr,
  v9.mv_intreno_akt AS mv_intreno,
  v1.partner_id,
  v9.konzessionaer_id_akt AS konzessionaer_id,
  v1.vertragsart_id,
  v2.kjmo,
  v20.count_kjmo,
  v77.melderegel_max AS max_melderegel,
  CASE
    WHEN v77.melderegel_max = v2.melderegel
    THEN ROUND(
      CAST(SUBSTR(SUBSTR(CAST(v2.dat_meldungsintervall_bis AS STRING), 1, 20), 6, 2) AS BIGNUMERIC),
      0
    ) - ROUND(
      CAST(SUBSTR(SUBSTR(CAST(v2.dat_meldungsintervall_von AS STRING), 1, 20), 6, 2) AS BIGNUMERIC),
      0
    ) + 1
    ELSE 0
  END AS interval_months,
  v2.melderegel,
  v2.rhythmus_art,
  v2.umsatz_brutto,
  v2.umsatz_netto,
  v2.umsatzkennung,
  v2.version,
  v2.wrg_id,
  v6.wrg_typ_id,
  v8.kj,
  v8.akt_kj,
  v8.akt_mo,
  1 AS akt
FROM kfl_production_dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v1
INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v2
  ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS v6
  ON v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_kj_monat AS v8
  ON v2.kjmo = v8.kjmo
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_melderegel_count AS v77
  ON v1.mandant_id = v77.mandant_id
  AND v2.mv_intreno = v77.mv_intreno
  AND v2.kjmo = v77.kjmo
INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf AS v9
  ON v1.mietvertrag_nr = v9.mietvertrag_nr AND v1.mandant_id = v9.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_umsatz_zu_hilf12 AS v20
  ON v1.mandant_id = v20.mandant_id
  AND v9.mv_intreno_akt = v20.mv_intreno
  AND v9.we_intreno_akt = v20.we_intreno
  AND v9.mo_intreno_akt = v20.mo_intreno
  AND v2.kjmo = v20.kjmo
  AND v2.wrg_id = v20.wrg_id
  AND v6.wrg_typ_id = v20.wrg_typ_id
WHERE
  v2.version = (
    SELECT
      MAX(version)
    FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v11
    WHERE
      v2.mv_intreno = mv_intreno AND v2.kjmo = kjmo AND v2.melderegel = melderegel
  )
  AND v2.mv_intreno = v9.mv_intreno_akt
  AND v9.mandant_id = v2.mandant_id
  AND v20.count_kjmo > 1
  AND v2.rhythmus_art = '0001'
UNION ALL
SELECT DISTINCT
  v1.branche_id,
  v1.mandant_id,
  v1.mietvertrag_nr,
  v9.mv_intreno_akt AS mv_intreno,
  v1.partner_id,
  v9.konzessionaer_id_akt AS konzessionaer_id,
  v1.vertragsart_id,
  v2.kjmo,
  v20.count_kjmo,
  v77.melderegel_max AS max_melderegel,
  CASE
    WHEN v77.melderegel_max = v2.melderegel
    THEN ROUND(
      CAST(SUBSTR(SUBSTR(CAST(v2.dat_meldungsintervall_bis AS STRING), 1, 20), 6, 2) AS BIGNUMERIC),
      0
    ) - ROUND(
      CAST(SUBSTR(SUBSTR(CAST(v2.dat_meldungsintervall_von AS STRING), 1, 20), 6, 2) AS BIGNUMERIC),
      0
    ) + 1
    ELSE 0
  END AS interval_months,
  v2.melderegel,
  v2.rhythmus_art,
  v2.umsatz_brutto,
  v2.umsatz_netto,
  v2.umsatzkennung,
  v2.version,
  v2.wrg_id,
  v6.wrg_typ_id,
  v8.kj,
  v8.akt_kj,
  v8.akt_mo,
  0 AS akt
FROM kfl_production_dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v1
INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v2
  ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS v6
  ON v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_kj_monat AS v8
  ON v2.kjmo = v8.kjmo
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_melderegel_count AS v77
  ON v1.mandant_id = v77.mandant_id
  AND v2.mv_intreno = v77.mv_intreno
  AND v2.kjmo = v77.kjmo
INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf AS v9
  ON v1.mietvertrag_nr = v9.mietvertrag_nr AND v1.mandant_id = v9.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_umsatz_zu_hilf12 AS v20
  ON v1.mandant_id = v20.mandant_id
  AND v9.mv_intreno_akt = v20.mv_intreno
  AND v9.we_intreno_akt = v20.we_intreno
  AND v9.mo_intreno_akt = v20.mo_intreno
  AND v2.kjmo = v20.kjmo
  AND v2.wrg_id = v20.wrg_id
  AND v6.wrg_typ_id = v20.wrg_typ_id
WHERE
  v2.version = (
    SELECT
      MAX(version)
    FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v11
    WHERE
      v2.mv_intreno = mv_intreno AND v2.kjmo = kjmo AND v2.melderegel = melderegel
  )
  AND v20.count_kjmo = 1
  AND v2.rhythmus_art = '0001'
UNION ALL
SELECT DISTINCT
  v1.branche_id,
  v1.mandant_id,
  v1.mietvertrag_nr,
  v9.mv_intreno_akt AS mv_intreno,
  v1.partner_id,
  v9.konzessionaer_id_akt AS konzessionaer_id,
  v1.vertragsart_id,
  v2.kjmo,
  v20.count_kjmo,
  v77.melderegel_max AS max_melderegel,
  CASE
    WHEN v77.melderegel_max = v2.melderegel
    THEN ROUND(
      CAST(SUBSTR(SUBSTR(CAST(v2.dat_meldungsintervall_bis AS STRING), 1, 20), 6, 2) AS BIGNUMERIC),
      0
    ) - ROUND(
      CAST(SUBSTR(SUBSTR(CAST(v2.dat_meldungsintervall_von AS STRING), 1, 20), 6, 2) AS BIGNUMERIC),
      0
    ) + 1
    ELSE 0
  END AS interval_months,
  v2.melderegel,
  v2.rhythmus_art,
  v2.umsatz_brutto,
  TRUNC(CAST(v2.umsatz_netto / v7.kurs_zu_euro AS BIGNUMERIC)) AS umsatz_netto,
  v2.umsatzkennung,
  v2.version,
  'EUR' AS wrg_id,
  0 AS wrg_typ_id,
  v8.kj,
  v8.akt_kj,
  v8.akt_mo,
  1 AS akt
FROM kfl_production_dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v1
INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v2
  ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS v6
  ON v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_wrg AS v7
  ON v2.wrg_id = v7.wrg_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_kj_monat AS v8
  ON v2.kjmo = v8.kjmo
INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf AS v9
  ON v1.mietvertrag_nr = v9.mietvertrag_nr AND v1.mandant_id = v9.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_melderegel_count AS v77
  ON v1.mandant_id = v77.mandant_id
  AND v2.mv_intreno = v77.mv_intreno
  AND v2.kjmo = v77.kjmo
INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_umsatz_zu_hilf12 AS v20
  ON v1.mandant_id = v20.mandant_id
  AND v9.mv_intreno_akt = v20.mv_intreno
  AND v9.we_intreno_akt = v20.we_intreno
  AND v9.mo_intreno_akt = v20.mo_intreno
  AND v2.kjmo = v20.kjmo
  AND v2.wrg_id = v20.wrg_id
  AND v6.wrg_typ_id = v20.wrg_typ_id
WHERE
  v2.version = (
    SELECT
      MAX(version)
    FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v11
    WHERE
      v2.mv_intreno = mv_intreno AND v2.kjmo = kjmo AND v2.melderegel = melderegel
  )
  AND v2.mv_intreno = v9.mv_intreno_akt
  AND v9.mandant_id = v2.mandant_id
  AND v20.count_kjmo > 1
  AND v2.rhythmus_art = '0001'
UNION ALL
SELECT DISTINCT
  v1.branche_id AS branche_id,
  v1.mandant_id AS mandant_id,
  v1.mietvertrag_nr AS mietvertrag_nr,
  v9.mv_intreno_akt AS mv_intreno,
  v1.partner_id AS partner_id,
  v9.konzessionaer_id_akt AS konzessionaer_id,
  v1.vertragsart_id AS vertragsart_id,
  v2.kjmo AS kjmo,
  v20.count_kjmo AS count_kjmo,
  v77.melderegel_max AS max_melderegel,
  CASE
    WHEN v77.melderegel_max = v2.melderegel
    THEN ROUND(
      CAST(SUBSTR(SUBSTR(CAST(v2.dat_meldungsintervall_bis AS STRING), 1, 20), 6, 2) AS BIGNUMERIC),
      0
    ) - ROUND(
      CAST(SUBSTR(SUBSTR(CAST(v2.dat_meldungsintervall_von AS STRING), 1, 20), 6, 2) AS BIGNUMERIC),
      0
    ) + 1
    ELSE 0
  END AS interval_months,
  v2.melderegel AS melderegel,
  v2.rhythmus_art AS rhythmus_art,
  v2.umsatz_brutto AS umsatz_brutto,
  TRUNC(CAST(v2.umsatz_netto / v7.kurs_zu_euro AS BIGNUMERIC)) AS umsatz_netto,
  v2.umsatzkennung AS umsatzkennung,
  v2.version AS version,
  'EUR' AS wrg_id,
  0 AS wrg_typ_id,
  v8.kj AS kj,
  v8.akt_kj AS akt_kj,
  v8.akt_mo AS akt_mo,
  0 AS akt
FROM kfl_production_dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v1
INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v2
  ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS v6
  ON v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_wrg AS v7
  ON v2.wrg_id = v7.wrg_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_kj_monat AS v8
  ON v2.kjmo = v8.kjmo
INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf AS v9
  ON v1.mietvertrag_nr = v9.mietvertrag_nr AND v1.mandant_id = v9.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_melderegel_count AS v77
  ON v1.mandant_id = v77.mandant_id
  AND v2.mv_intreno = v77.mv_intreno
  AND v2.kjmo = v77.kjmo
INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_umsatz_zu_hilf12 AS v20
  ON v1.mandant_id = v20.mandant_id
  AND v9.mv_intreno_akt = v20.mv_intreno
  AND v9.we_intreno_akt = v20.we_intreno
  AND v9.mo_intreno_akt = v20.mo_intreno
  AND v2.kjmo = v20.kjmo
  AND v2.wrg_id = v20.wrg_id
  AND v6.wrg_typ_id = v20.wrg_typ_id
WHERE
  v2.version = (
    SELECT
      MAX(version)
    FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v11
    WHERE
      v2.mv_intreno = mv_intreno AND v2.kjmo = kjmo AND v2.melderegel = melderegel
  )
  AND v20.count_kjmo = 1
  AND v2.rhythmus_art = '0001';
