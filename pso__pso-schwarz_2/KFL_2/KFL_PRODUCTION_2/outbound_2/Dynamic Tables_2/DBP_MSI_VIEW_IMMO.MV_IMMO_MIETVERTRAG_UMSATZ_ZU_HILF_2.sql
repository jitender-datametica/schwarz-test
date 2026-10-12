CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_umsatz_zu_hilf_2 AS
SELECT
  mandant_id AS mandant_id,
  mv_intreno AS mv_intreno,
  we_intreno AS we_intreno,
  mo_intreno AS mo_intreno,
  kjmo AS kjmo,
  wrg_id AS wrg_id,
  wrg_typ_id AS wrg_typ_id,
  COUNT(mietvertrag_nr) AS count_kjmo
FROM (
  SELECT DISTINCT
    v1.mandant_id,
    v1.mietvertrag_nr,
    v9.we_intreno_akt AS we_intreno,
    v9.mv_intreno_akt AS mv_intreno,
    v9.mo_intreno_akt AS mo_intreno,
    v2.kjmo,
    v2.rhythmus_art,
    v2.version,
    v2.wrg_id,
    v6.wrg_typ_id,
    v8.kj,
    v8.akt_kj,
    v8.akt_mo
  FROM kfl_production_dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf_2 AS v1
  INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS v2
    ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_typ_zu_2 AS v6
    ON v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_kj_monat_2 AS v8
    ON v2.kjmo = v8.kjmo
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf_2 AS v9
    ON v1.mietvertrag_nr = v9.mietvertrag_nr AND v1.mandant_id = v9.mandant_id
  WHERE
    v2.version = (
      SELECT
        MAX(version)
      FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS v11
      WHERE
        v2.mv_intreno = mv_intreno AND v2.kjmo = kjmo AND v2.melderegel = melderegel
    )
    AND v2.nullumsatz <> 'X'
    AND v2.umsatz_netto > 0
    AND v2.mv_intreno = v9.mv_intreno_akt
    AND v9.mandant_id = v2.mandant_id
    AND v2.rhythmus_art = '0001'
  UNION ALL
  SELECT DISTINCT
    v1.mandant_id,
    v1.mietvertrag_nr,
    v9.we_intreno_akt AS we_intreno,
    v9.mv_intreno_akt AS mv_intreno,
    v9.mo_intreno_akt AS mo_intreno,
    v2.kjmo,
    v2.rhythmus_art,
    v2.version,
    v2.wrg_id,
    v6.wrg_typ_id,
    v8.kj,
    v8.akt_kj,
    v8.akt_mo
  FROM kfl_production_dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf_2 AS v1
  INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS v2
    ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_typ_zu_2 AS v6
    ON v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_kj_monat_2 AS v8
    ON v2.kjmo = v8.kjmo
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf_2 AS v9
    ON v1.mietvertrag_nr = v9.mietvertrag_nr AND v1.mandant_id = v9.mandant_id
  WHERE
    v2.version = (
      SELECT
        MAX(version)
      FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS v11
      WHERE
        v2.mv_intreno = mv_intreno AND v2.kjmo = kjmo AND v2.melderegel = melderegel
    )
    AND v2.nullumsatz <> 'X'
    AND v2.umsatz_netto > 0
  UNION ALL
  SELECT DISTINCT
    v1.mandant_id,
    v1.mietvertrag_nr,
    v9.we_intreno_akt AS we_intreno,
    v9.mv_intreno_akt AS mv_intreno,
    v9.mo_intreno_akt AS mo_intreno,
    v2.kjmo,
    v2.rhythmus_art,
    v2.version,
    'EUR' AS wrg_id,
    0 AS wrg_typ_id,
    v8.kj,
    v8.akt_kj,
    v8.akt_mo
  FROM kfl_production_dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf_2 AS v1
  INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS v2
    ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_typ_zu_2 AS v6
    ON v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_kj_monat_2 AS v8
    ON v2.kjmo = v8.kjmo
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf_2 AS v9
    ON v1.mietvertrag_nr = v9.mietvertrag_nr AND v1.mandant_id = v9.mandant_id
  WHERE
    v2.version = (
      SELECT
        MAX(version)
      FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS v11
      WHERE
        v2.mv_intreno = mv_intreno AND v2.kjmo = kjmo AND v2.melderegel = melderegel
    )
    AND v2.nullumsatz <> 'X'
    AND v2.umsatz_netto > 0
    AND v2.mv_intreno = v9.mv_intreno_akt
    AND v9.mandant_id = v2.mandant_id
    AND v2.rhythmus_art = '0001'
  UNION ALL
  SELECT DISTINCT
    v1.mandant_id,
    v1.mietvertrag_nr,
    v9.we_intreno_akt AS we_intreno,
    v9.mv_intreno_akt AS mv_intreno,
    v9.mo_intreno_akt AS mo_intreno,
    v2.kjmo,
    v2.rhythmus_art,
    v2.version,
    'EUR' AS wrg_id,
    0 AS wrg_typ_id,
    v8.kj,
    v8.akt_kj,
    v8.akt_mo
  FROM kfl_production_dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf_2 AS v1
  INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS v2
    ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_typ_zu_2 AS v6
    ON v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_kj_monat_2 AS v8
    ON v2.kjmo = v8.kjmo
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf_2 AS v9
    ON v1.mietvertrag_nr = v9.mietvertrag_nr AND v1.mandant_id = v9.mandant_id
  WHERE
    v2.version = (
      SELECT
        MAX(version)
      FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS v11
      WHERE
        v2.mv_intreno = mv_intreno AND v2.kjmo = kjmo AND v2.melderegel = melderegel
    )
    AND v2.nullumsatz <> 'X'
    AND v2.umsatz_netto > 0
) AS v18
WHERE
  rhythmus_art = '0001'
GROUP BY
  mandant_id,
  mv_intreno,
  we_intreno,
  mo_intreno,
  kjmo,
  wrg_id,
  wrg_typ_id;
