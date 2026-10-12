CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf_2 (
  mandant_id BIGNUMERIC(38, 0),
  mv_intreno STRING(20),
  branche_id BIGNUMERIC(38, 0),
  man_vermietungsauftrag_id BIGNUMERIC(38, 0),
  anlass_zwvermietung_id BIGNUMERIC(38, 0),
  vertragsart_id BIGNUMERIC(38, 0),
  mietvertrag_nr STRING(20),
  mv_objekt_nr STRING(30),
  partner_id STRING(10),
  anschluss_mietvertrag STRING(1),
  mv_option STRING(60),
  dat_kuend_eingang_bis DATE,
  dat_kuend_berechnet_zum DATE,
  kuend_partei STRING(1),
  kuend_frist STRING(20),
  dat_miet_beginn DATE,
  dat_miet_ende DATE,
  restlaufzeit_monate BIGNUMERIC(38, 0),
  mv_akt_gueltig_fg INT64,
  unbefristet_fg INT64,
  mietvertrag_nr_alt STRING(20)
) AS
SELECT
  v1.mandant_id,
  v1.mv_intreno,
  v1.branche_id,
  v1.man_vermietungsauftrag_id,
  v1.anlass_zwvermietung_id,
  v1.vertragsart_id,
  v1.mietvertrag_nr,
  v1.mv_objekt_nr,
  v1.partner_id,
  v1.anschluss_mietvertrag,
  v1.mv_option,
  v1.dat_kuend_eingang_bis,
  v1.dat_kuend_berechnet_zum,
  v1.kuend_partei,
  v1.kuend_frist,
  v1.dat_miet_beginn,
  v1.dat_miet_ende,
  CASE
    WHEN CURRENT_DATE BETWEEN v1.dat_miet_beginn AND v1.dat_miet_ende
    THEN TRUNC(CAST(DATE_DIFF(v1.dat_miet_ende, CURRENT_DATE, DAY) / 30 AS BIGNUMERIC)) + 0.5
    ELSE 0
  END AS restlaufzeit_monate,
  CASE
    WHEN CURRENT_DATE BETWEEN v1.dat_miet_beginn AND v1.dat_miet_ende
    THEN 1
    ELSE 0
  END AS mv_akt_gueltig_fg,
  CASE
    WHEN v1.dat_miet_ende IS NULL OR v1.dat_miet_ende = PARSE_DATE('%F', '9999-12-31')
    THEN 1
    ELSE 0
  END AS unbefristet_fg,
  v1.mietvertrag_nr_alt
FROM kfl_production_dbp_view.v_immo_mietvertrag_per_2 AS v1
LEFT JOIN (
  SELECT DISTINCT
    mv_intreno,
    mandant_id
  FROM kfl_production_dbp_msi_view_immo.mv_mietvertrag_mietsicherheit_2 AS v3
  WHERE
    dat_rueckgabe IS NULL OR dat_rueckgabe > CURRENT_DATE
) AS v2
  ON v1.mandant_id = v2.mandant_id AND v1.mv_intreno = v2.mv_intreno
WHERE
  NOT v1.mv_intreno IN (
    SELECT DISTINCT
      minimal_mv_intreno
    FROM (
      SELECT
        mandant_id,
        mietvertrag_nr,
        COUNT(mv_intreno) AS anzahl_mv_intrenos,
        MIN(mv_intreno) AS minimal_mv_intreno
      FROM kfl_production_dbp_view.v_immo_mietvertrag_per_2
      GROUP BY
        mandant_id,
        mietvertrag_nr
      HAVING
        anzahl_mv_intrenos > 2
    ) AS v112
  )
UNION ALL
SELECT
  v1.mandant_id,
  v1.mv_intreno,
  v1.branche_id,
  v1.man_vermietungsauftrag_id,
  v1.anlass_zwvermietung_id,
  v1.vertragsart_id,
  t18.mietvertrag_nr,
  v1.mv_objekt_nr,
  v1.partner_id,
  v1.anschluss_mietvertrag,
  v1.mv_option,
  v1.dat_kuend_eingang_bis,
  v1.dat_kuend_berechnet_zum,
  v1.kuend_partei,
  v1.kuend_frist,
  v1.dat_miet_beginn,
  v1.dat_miet_ende,
  CASE
    WHEN CURRENT_DATE BETWEEN v1.dat_miet_beginn AND v1.dat_miet_ende
    THEN TRUNC(CAST(DATE_DIFF(v1.dat_miet_ende, CURRENT_DATE, DAY) / 30 AS BIGNUMERIC)) + 0.5
    ELSE 0
  END AS restlaufzeit_monate,
  CASE
    WHEN CURRENT_DATE BETWEEN v1.dat_miet_beginn AND v1.dat_miet_ende
    THEN 1
    ELSE 0
  END AS mv_akt_gueltig_fg,
  CASE
    WHEN v1.dat_miet_ende IS NULL OR v1.dat_miet_ende = PARSE_DATE('%F', '9999-12-31')
    THEN 1
    ELSE 0
  END AS unbefristet_fg,
  v1.mietvertrag_nr_alt
FROM kfl_production_dbp_view.v_immo_mietvertrag_per_2 AS v1
LEFT JOIN (
  SELECT DISTINCT
    mv_intreno,
    mandant_id
  FROM kfl_production_dbp_msi_view_immo.mv_mietvertrag_mietsicherheit_2 AS v3
  WHERE
    dat_rueckgabe IS NULL OR dat_rueckgabe > CURRENT_DATE
) AS v2
  ON v1.mandant_id = v2.mandant_id AND v1.mv_intreno = v2.mv_intreno
INNER JOIN (
  SELECT
    mandant_id,
    mv_intreno,
    mietvertrag_nr0 AS mietvertrag_nr
  FROM (
    SELECT DISTINCT
      v10.mandant_id,
      v10.mv_intreno,
      v2.mietvertrag_nr AS mietvertrag_nr0
    FROM kfl_production_dbp_view.v_immo_mietvertrag_per_2 AS v10
    INNER JOIN (
      SELECT DISTINCT
        mandant_id,
        mv_intreno,
        mietvertrag_nr,
        mietvertrag_nr_alt
      FROM kfl_production_dbp_view.v_immo_mietvertrag_per_2
    ) AS v2
      ON v10.mietvertrag_nr = v2.mietvertrag_nr_alt AND v10.mandant_id = v2.mandant_id
  ) AS v16
) AS t18
  ON v1.mandant_id = t18.mandant_id AND v1.mv_intreno = t18.mv_intreno
WHERE
  NOT v1.mv_intreno IN (
    SELECT DISTINCT
      minimal_mv_intreno
    FROM (
      SELECT
        mandant_id,
        mietvertrag_nr,
        COUNT(mv_intreno) AS anzahl_mv_intrenos,
        MIN(mv_intreno) AS minimal_mv_intreno
      FROM kfl_production_dbp_view.v_immo_mietvertrag_per_2
      GROUP BY
        mandant_id,
        mietvertrag_nr
      HAVING
        anzahl_mv_intrenos > 2
    ) AS v112
  )
UNION ALL
SELECT
  mandant_id AS mandant_id,
  '' AS mv_intreno,
  0 AS branche_id,
  0 AS man_vermietungsauftrag_id,
  0 AS anlass_zwvermietung_id,
  0 AS vertragsart_id,
  '' AS mietvertrag_nr,
  '' AS mv_objekt_nr,
  '' AS partner_id,
  '' AS anschluss_mietvertrag,
  '' AS mv_option,
  CAST('9999-12-31' AS DATE) AS dat_kuend_eingang_bis,
  CAST('9999-12-31' AS DATE) AS dat_kuend_berechnet_zum,
  '' AS kuend_partei,
  '' AS kuend_frist,
  CAST('1900-01-01' AS DATE) AS dat_miet_beginn,
  CAST('9999-12-31' AS DATE) AS dat_miet_ende,
  0 AS restlaufzeit_monate,
  1 AS mv_akt_gueltig_fg,
  0 AS unbefristet_fg,
  '' AS mietvertrag_nr_alt
FROM kfl_production_dbp_view.v_mandant_2;
