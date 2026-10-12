CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_l_mietvertrag (
  mandant_id BIGNUMERIC(38, 0),
  mv_intreno STRING(20),
  mv_branche_id BIGNUMERIC(38, 0),
  man_vermietungsauftrag_id BIGNUMERIC(38, 0),
  anlass_zwvermietung_id BIGNUMERIC(38, 0),
  vertragsart_id BIGNUMERIC(38, 0),
  mietvertrag_nr STRING(20),
  mv_objekt_nr STRING(30),
  anschluss_mietvertrag STRING(1),
  mv_option STRING(16777216),
  dat_kuend_eingang_bis DATE,
  dat_kuend_berechnet_zum DATE,
  kuend_partei STRING(1),
  kuend_frist STRING(20),
  dat_miet_beginn DATE,
  dat_miet_ende DATE,
  restlaufzeit_monate BIGNUMERIC(38, 0),
  mv_akt_gueltig_fg INT64,
  unbefristet_fg INT64,
  mietvertrag_nr_alt STRING(20),
  dat_aktivierung DATE
) AS
SELECT
  mandant_id AS mandant_id,
  mv_intreno AS mv_intreno,
  branche_id AS mv_branche_id,
  man_vermietungsauftrag_id AS man_vermietungsauftrag_id,
  anlass_zwvermietung_id AS anlass_zwvermietung_id,
  vertragsart_id AS vertragsart_id,
  mietvertrag_nr AS mietvertrag_nr,
  mv_objekt_nr AS mv_objekt_nr,
  anschluss_mietvertrag AS anschluss_mietvertrag,
  CASE
    WHEN mv_option <> ''
    THEN mv_option || '/' || CASE WHEN mv_option_bez = 'T' THEN 'A' ELSE mv_option_bez END
    ELSE mv_option
  END AS mv_option,
  dat_kuend_eingang_bis AS dat_kuend_eingang_bis,
  dat_kuend_berechnet_zum AS dat_kuend_berechnet_zum,
  kuend_partei AS kuend_partei,
  kuend_frist AS kuend_frist,
  dat_miet_beginn AS dat_miet_beginn,
  dat_miet_ende AS dat_miet_ende,
  CASE
    WHEN CURRENT_DATE BETWEEN dat_miet_beginn AND dat_miet_ende
    THEN TRUNC(CAST(DATE_DIFF(dat_miet_ende, CURRENT_DATE, DAY) / 30 AS BIGNUMERIC)) + 0.5
    ELSE 0
  END AS restlaufzeit_monate,
  CASE WHEN CURRENT_DATE BETWEEN dat_miet_beginn AND dat_miet_ende THEN 1 ELSE 0 END AS mv_akt_gueltig_fg,
  CASE
    WHEN dat_miet_ende IS NULL OR dat_miet_ende = CAST('9999-12-31' AS DATE)
    THEN 1
    ELSE 0
  END AS unbefristet_fg,
  mietvertrag_nr_alt AS mietvertrag_nr_alt,
  dat_aktivierung AS dat_aktivierung
FROM kfl_production_dbp_view.v_immo_mietvertrag_per AS v1
UNION ALL
SELECT
  mandant_id,
  '' AS mv_intreno,
  0 AS mv_branche_id,
  0 AS man_vermietungsauftrag_id,
  0 AS anlass_zwvermietung_id,
  0 AS vertragsart_id,
  '' AS mietvertrag_nr,
  '' AS mv_objekt_nr,
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
  '' AS mietvertrag_nr_alt,
  CAST('9999-12-31' AS DATE) AS dat_aktivierung
FROM kfl_production_dbp_view.v_mandant;
