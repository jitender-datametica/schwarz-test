CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_mietvertrag_per_1 (
  mandant_id BIGNUMERIC(38, 0),
  mietvertrag_id STRING(20),
  dat_von DATE,
  dat_bis DATE,
  dat_vertrag_beginn DATE,
  dat_vertrag_ende DATE,
  vertragart_id STRING(3),
  vertrag_status_fg STRING(1),
  konzessionaer_id STRING(16777216),
  vermieter_id BIGNUMERIC(38, 0),
  laufzeit_ende BIGNUMERIC(38, 0),
  laufzeit_beginn BIGNUMERIC(38, 0),
  dat_kuendbar_zum DATE,
  dat_kuendigung DATE,
  kuendigung_frist BIGNUMERIC(38, 0),
  kuend_frist_bez STRING(16777216),
  kaution BIGNUMERIC(38, 9),
  nebenkosten_betrag BIGNUMERIC(38, 9),
  nebenkosten_abschlag BIGNUMERIC(38, 9),
  sonderregelung_fg BIGNUMERIC(38, 0),
  mietindex_prozent NUMERIC(9, 4),
  dat_mietindex DATE,
  mietauftrag_id BIGNUMERIC(38, 0),
  mietvertrag_option STRING(16777216),
  option_bez STRING(16777216),
  debitor_miete_id BIGNUMERIC(38, 0),
  debitor_werbung_id BIGNUMERIC(38, 0),
  wrg_id STRING(12),
  wrg_typ_id BIGNUMERIC(38, 0),
  mietvertrag_nr STRING(25)
) AS
SELECT
  mv.mandant_id AS mandant_id,
  mv.mietvertrag_id AS mietvertrag_id,
  mv.dat_von AS dat_von,
  mv.dat_bis AS dat_bis,
  mv.dat_vertrag_beginn AS dat_vertrag_beginn,
  COALESCE(mv.dat_vertrag_ende, DATE('9999-12-31')) AS dat_vertrag_ende,
  mv.vertragart_id AS vertragart_id,
  mv.vertrag_status_fg AS vertrag_status_fg,
  mv.konzessionaer_id AS konzessionaer_id,
  mv.vermieter_id AS vermieter_id,
  CASE
    WHEN mv.dat_vertrag_ende BETWEEN CURRENT_DATE AND CAST('9999-12-31' AS DATE)
    THEN CAST(DATE_DIFF(mv.dat_vertrag_ende, CURRENT_DATE, DAY) / 30 AS BIGNUMERIC)
    ELSE 0
  END AS laufzeit_ende,
  CASE
    WHEN mv.dat_vertrag_beginn BETWEEN CAST('1900-01-31' AS DATE) AND (
      CURRENT_DATE
    )
    THEN CAST(DATE_DIFF(CURRENT_DATE, mv.dat_vertrag_beginn, DAY) / 30 AS BIGNUMERIC)
    ELSE 0
  END AS laufzeit_beginn,
  COALESCE(mv.dat_kuendbar_zum, DATE('9999-12-31')) AS dat_kuendbar_zum,
  mv.dat_kuendigung AS dat_kuendigung,
  COALESCE(mv.kuendigung_frist, 0) AS kuendigung_frist,
  COALESCE(mv.kuend_frist_bez, '') AS kuend_frist_bez,
  CAST(mv.betrag_kaution * kurs.kurs_1 AS NUMERIC) AS kaution,
  CAST(mv.nebenkosten_betrag * kurs.kurs_1 AS NUMERIC) AS nebenkosten_betrag,
  CAST(mv.nebenkosten_abschlag * kurs.kurs_1 AS NUMERIC) AS nebenkosten_abschlag,
  mv.sonderregelung_fg AS sonderregelung_fg,
  mv.mietindex_prozent AS mietindex_prozent,
  mv.dat_mietindex AS dat_mietindex,
  mv.mietauftrag_id AS mietauftrag_id,
  mv.mietvertrag_option AS mietvertrag_option,
  mv.mietvertrag_option AS option_bez,
  mv.debitor_miete_id AS debitor_miete_id,
  mv.debitor_werbung_id AS debitor_werbung_id,
  kurs.wrg_id AS wrg_id,
  kurs.wrg_typ_id AS wrg_typ_id,
  mv.mietvertrag_nr AS mietvertrag_nr
FROM kfl_production_dbp_view.v_ivs_mietvertrag_per_1 AS mv
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mand_wrg_kurs_zu_per_1 AS kurs_1
  ON mv.mandant_id = kurs.mandant_id
  AND CURRENT_DATE BETWEEN kurs.kurs_dat_von AND kurs.kurs_dat_bis
WHERE
  mv.dat_bis = CAST('9999-12-31' AS DATE)
UNION ALL
SELECT
  mandant_id,
  '0' AS mietvertrag_id,
  DATE('1900-01-01') AS dat_von,
  DATE('9999-12-31') AS dat_bis,
  DATE('1900-01-01') AS dat_vertrag_beginn,
  DATE('9999-12-31') AS dat_vertrag_ende,
  SUBSTR('000', 1, 3) AS vertragart_id,
  SUBSTR('0', 1, 1) AS vertrag_status_fg,
  '0' AS konzessionaer_id,
  CAST(mandant_id * -1 AS BIGNUMERIC) AS vermieter_id,
  0 AS laufzeit_ende,
  0 AS laufzeit_beginn,
  DATE('9999-12-31') AS dat_kuendbar_zum,
  DATE('9999-12-31') AS dat_kuendigung,
  0 AS kuendigung_frist,
  '' AS kuend_frist_bez,
  0 AS betrag_kaution,
  0 AS nebenkosten_betrag,
  0 AS nebenkosten_abschlag,
  0 AS sonderregelung_fg,
  0 AS mietindex_prozent,
  DATE('1900-01-01') AS dat_mietindex,
  0 AS mietauftrag_id,
  '' AS mietvertrag_option,
  '' AS option_bez,
  0 AS debitor_miete_id,
  0 AS debitor_werbung_id,
  wrg_id,
  wrg_typ_id,
  '0' AS mietvertrag_nr
FROM kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS mwt;
