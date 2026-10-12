CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_mietobjekt_1 (
  mandant_id BIGNUMERIC(38, 0),
  mo_intreno STRING(20),
  mo_smenr STRING(8),
  mo_objekt_nr STRING(30),
  mo_branche_id BIGNUMERIC(38, 0),
  mo_typ_id BIGNUMERIC(38, 0),
  mo_art_kz STRING(1),
  mo_nutzung_id BIGNUMERIC(38, 0),
  we_intreno STRING(20),
  dat_mo_gueltig_von DATE,
  dat_mo_gueltig_bis DATE,
  mo_status_id BIGNUMERIC(38, 0),
  mo_akt_gueltig_fg INT64,
  dat_letzte_uebergabe DATE,
  leerstand_seit DATE,
  leerstand_seit_2101 DATE,
  bemessung_art STRING(4),
  bemessung_art_id STRING(4),
  gebaude_nr STRING(8),
  flaechenkategorie_id INT64,
  flaechenkategorie_bez STRING(23),
  flaecheart_leerstand_id INT64,
  flaecheart_leerstand_bez STRING(44)
) AS
SELECT
  v0.mandant_id AS mandant_id,
  v0.mo_intreno AS mo_intreno,
  v0.mo_smenr AS mo_smenr,
  v0.mo_objekt_nr AS mo_objekt_nr,
  v0.branche_id AS mo_branche_id,
  v0.mo_typ_id AS mo_typ_id,
  v0.mo_art_kz AS mo_art_kz,
  v0.mo_nutzung_id AS mo_nutzung_id,
  v0.we_intreno AS we_intreno,
  CASE
    WHEN v0.dat_mo_gueltig_von IS NULL
    OR v0.dat_mo_gueltig_von = PARSE_DATE('%F', '1900-01-01')
    THEN v7.dat_we_gueltig_von
    ELSE v0.dat_mo_gueltig_von
  END AS dat_mo_gueltig_von,
  v0.dat_mo_gueltig_bis AS dat_mo_gueltig_bis,
  v5.mo_status_id AS mo_status_id,
  CASE
    WHEN CURRENT_DATE BETWEEN v0.dat_mo_gueltig_von AND v0.dat_mo_gueltig_bis
    THEN 1
    ELSE 0
  END AS mo_akt_gueltig_fg,
  v1.dat_letzte_uebergabe AS dat_letzte_uebergabe,
  COALESCE(
    DATE_ADD(v4.dat_leerstand_seit, INTERVAL '1' DAY),
    CASE
      WHEN v6.max_dat_status_von = PARSE_DATE('%F', '1900-01-01')
      THEN v0.dat_mo_gueltig_von
      ELSE v6.max_dat_status_von
    END
  ) AS leerstand_seit,
  COALESCE(
    DATE_ADD(v4.dat_leerstand_seit, INTERVAL '1' DAY),
    CASE
      WHEN v0.dat_mo_gueltig_von = PARSE_DATE('%F', '1900-01-01')
      THEN v7.dat_we_gueltig_von
      ELSE v0.dat_mo_gueltig_von
    END
  ) AS leerstand_seit_2101,
  v2.bemessung_art_id AS bemessung_art,
  v2.bemessung_art_id AS bemessung_art_id,
  SUBSTR(v0.mo_smenr, 1, 2) AS gebaude_nr,
  CASE
    WHEN v0.gebaeude_nr = 0
    THEN 6
    WHEN v0.mo_typ_id = 30
    THEN 5
    WHEN v2.bemessung_art_id = '0310'
    THEN 1
    WHEN v2.bemessung_art_id = '0300' AND v2.groesse < 200
    THEN 2
    WHEN v2.bemessung_art_id = '0300' AND v2.groesse >= 200
    THEN 3
    WHEN v2.bemessung_art_id = '0320'
    THEN 4
    ELSE 0
  END AS flaechenkategorie_id,
  CASE
    WHEN v0.gebaeude_nr = 0
    THEN 'Freiflächen'
    WHEN v0.mo_typ_id = 30
    THEN 'SB-Warenhaus'
    WHEN v2.bemessung_art_id = '0310'
    THEN 'Gewerbeflächen'
    WHEN v2.bemessung_art_id = '0300' AND v2.groesse < 200
    THEN 'Handelsflächen < 200m\\u00b2'
    WHEN v2.bemessung_art_id = '0300' AND v2.groesse >= 200
    THEN 'Handelsflächen >= 200m\\u00b2'
    WHEN v2.bemessung_art_id = '0320'
    THEN 'Wohnungen'
    ELSE 'n.v.'
  END AS flaechenkategorie_bez,
  CASE
    WHEN v0.mo_art_kz IN ('I')
    THEN 4
    WHEN v0.mo_art_kz IN ('V')
    THEN 5
    WHEN v0.mo_art_kz IN ('T')
    THEN 7
    WHEN v0.mo_art_kz IN ('U')
    THEN 8
    WHEN v0.mo_art_kz IN ('A')
    THEN 9
    WHEN v2.bemessung_art_id = '0300'
    THEN 1
    WHEN v2.bemessung_art_id = '0310'
    THEN 2
    WHEN v2.bemessung_art_id = '0320'
    THEN 3
    ELSE 0
  END AS flaecheart_leerstand_id,
  CASE
    WHEN v0.mo_art_kz IN ('I')
    THEN 'nicht wirtschaftlicher Invest / hoher Invest'
    WHEN v0.mo_art_kz IN ('V')
    THEN 'Vermietungsflächen an Vertrieb'
    WHEN v0.mo_art_kz IN ('T')
    THEN 'Vetriebsflächen an Vermietung'
    WHEN v0.mo_art_kz IN ('U')
    THEN 'Umbauflächen'
    WHEN v0.mo_art_kz IN ('A')
    THEN 'zu vermietende Allgemeinflächen'
    WHEN v2.bemessung_art_id = '0300'
    THEN 'Handelsflächen'
    WHEN v2.bemessung_art_id = '0310'
    THEN 'Sonderflächen'
    WHEN v2.bemessung_art_id = '0320'
    THEN 'Wohnungen'
    ELSE 'nicht definiert'
  END AS flaecheart_leerstand_bez
FROM kfl_production_dbp_view.v_immo_mietobjekt_1 AS v0
INNER JOIN (
  SELECT
    mandant_id,
    mo_intreno,
    MAX(mo_status_id) AS mo_status_id
  FROM kfl_production_dbp_view.v_immo_mo_status_per_1
  WHERE
    CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis
  GROUP BY
    mandant_id,
    mo_intreno
) AS v5
  ON v0.mandant_id = v5.mandant_id AND v0.mo_intreno = v5.mo_intreno
LEFT JOIN (
  SELECT
    mandant_id,
    mo_intreno,
    MAX(dat_bis) AS dat_leerstand_seit
  FROM kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1
  WHERE
    CURRENT_DATE > dat_bis
  GROUP BY
    mandant_id,
    mo_intreno
) AS v4
  ON v0.mandant_id = v4.mandant_id
  AND v0.mo_intreno = v4.mo_intreno
  AND v5.mo_status_id IN (0, 2, 3)
LEFT JOIN (
  SELECT
    mandant_id,
    mo_intreno,
    MAX(dat_status_von) AS max_dat_status_von
  FROM kfl_production_dbp_view.v_immo_mo_status_per_1
  WHERE
    CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis
  GROUP BY
    mandant_id,
    mo_intreno
) AS v6
  ON v0.mandant_id = v6.mandant_id AND v0.mo_intreno = v6.mo_intreno
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_immo_mietobjekt_messung_1 AS v2
  ON v0.mo_intreno = v2.mo_intreno AND v0.mandant_id = v2.mandant_id
LEFT JOIN (
  SELECT
    mandant_id,
    mo_status_id,
    mo_intreno,
    MAX(dat_status_von) AS dat_letzte_uebergabe
  FROM kfl_production_dbp_view.v_immo_mo_status_per_1
  WHERE
    mo_status_id = 4 AND CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis
  GROUP BY
    mandant_id,
    mo_status_id,
    mo_intreno
) AS v1
  ON v0.mandant_id = v1.mandant_id AND v0.mo_intreno = v1.mo_intreno
LEFT JOIN kfl_production_dbp_view.v_immo_wirtschaftseinheit_1 AS v7
  ON v0.mandant_id = v7.mandant_id AND v0.we_intreno = v7.we_intreno;
