CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_objekt_per_2 (
  mandant_id BIGNUMERIC(38, 0),
  immo_objekt_id STRING(20),
  dat_von DATE,
  dat_bis DATE,
  objekt_groesse NUMERIC(18, 2),
  konzessionaer_groesse NUMERIC(18, 2),
  objekt_plz STRING(6),
  objekt_ort STRING(40),
  objekt_strasse STRING(40),
  objekt_name STRING(40),
  dat_1bereich_oeffnung DATE,
  dat_objekt_oeffnung DATE,
  dat_eroeffnung DATE,
  dat_eroeffnung_geplant DATE,
  objektart_id STRING(1),
  objektart_datum_von DATE,
  objektart_datum_bis DATE,
  dat_umgl DATE,
  status_umgl STRING(10),
  eigenmiete_pro_qm BIGNUMERIC(38, 0),
  eigenmiete_pro_monat BIGNUMERIC(38, 0),
  wrg_id STRING(12),
  wrg_typ_id BIGNUMERIC(38, 0),
  immo_objekt_obj_id STRING(25),
  ref_immo_objekt_id STRING(20),
  immo_objekt_nr STRING(25),
  buchungskreis_id BIGNUMERIC(38, 0),
  immo_objekt_bez BIGNUMERIC(38, 0),
  objekt_name_grp STRING(40)
) AS
SELECT
  io.mandant_id AS mandant_id,
  io.immo_objekt_id AS immo_objekt_id,
  io.dat_von AS dat_von,
  io.dat_bis AS dat_bis,
  io.objekt_groesse AS objekt_groesse,
  io.konzessionaer_groesse AS konzessionaer_groesse,
  io.objekt_plz AS objekt_plz,
  kfl_production_dbp_process.transcriptc(io.objekt_ort) AS objekt_ort,
  kfl_production_dbp_process.transcriptc(io.objekt_strasse) AS objekt_strasse,
  kfl_production_dbp_process.transcriptc(io.objekt_name) AS objekt_name,
  io.dat_1bereich_oeffnung AS dat_1bereich_oeffnung,
  io.dat_objekt_oeffnung AS dat_objekt_oeffnung,
  wp.dat_eroeffnung AS dat_eroeffnung,
  COALESCE(io.dat_objekt_oeffnung, wp.dat_eroeffnung) AS dat_eroeffnung_geplant,
  io.objektart_id AS objektart_id,
  NULLIF(io.objektart_datum_von, CAST('1900-01-01' AS DATE)) AS objektart_datum_von,
  NULLIF(io.objektart_datum_bis, CAST('9999-12-31' AS DATE)) AS objektart_datum_bis,
  io.dat_umgl AS dat_umgl,
  io.status_umgl AS status_umgl,
  io.eigenmiete_pro_qm * kurs.kurs_2 AS eigenmiete_pro_qm,
  io.eigenmiete_pro_monat * kurs.kurs_2 AS eigenmiete_pro_monat,
  kurs.wrg_id AS wrg_id,
  kurs.wrg_typ_id AS wrg_typ_id,
  io.immo_objekt_obj_id AS immo_objekt_obj_id,
  io.ref_immo_objekt_id AS ref_immo_objekt_id,
  io.immo_objekt_nr AS immo_objekt_nr,
  io.buchungskreis_id AS buchungskreis_id,
  io.immo_objekt_bez AS immo_objekt_bez,
  kfl_production_dbp_process.transcriptc(
    CASE
      WHEN INSTR(io.objekt_name, 'PAOB') > 0
      THEN TRIM(SUBSTR(io.objekt_name, 1, INSTR(io.objekt_name, 'PAOB') - 1))
      WHEN INSTR(io.objekt_name, ',PAOB') > 0
      THEN TRIM(SUBSTR(io.objekt_name, 1, INSTR(io.objekt_name, ',PAOB') - 1))
      WHEN INSTR(io.objekt_name, 'UMGL') > 0
      THEN TRIM(SUBSTR(io.objekt_name, 1, INSTR(io.objekt_name, 'UMGL') - 1))
      WHEN INSTR(io.objekt_name, ',UMGL') > 0
      THEN TRIM(SUBSTR(io.objekt_name, 1, INSTR(io.objekt_name, ',UMGL') - 1))
      WHEN INSTR(io.objekt_name, 'Partnerobjekt') > 0
      THEN TRIM(SUBSTR(io.objekt_name, 1, INSTR(io.objekt_name, 'Partnerobjekt') - 1))
      ELSE io.objekt_name
    END
  ) AS objekt_name_grp
FROM kfl_production_dbp_view.v_ivs_immo_objekt_per_2 AS io
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mand_wrg_kurs_zu_per_2 AS kurs_2
  ON io.mandant_id = kurs.mandant_id
  AND CURRENT_DATE BETWEEN kurs.kurs_dat_von AND kurs.kurs_dat_bis
LEFT JOIN (
  SELECT
    mandant_id,
    wup_id,
    dat_eroeffnung
  FROM kfl_production_dbp_view.v_wup_2
  WHERE
    nb_id = 0
    AND dat_eroeffnung BETWEEN CAST('1900-01-02' AS DATE) AND CAST('2090-12-30' AS DATE)
) AS wp
  ON io.mandant_id = wp.mandant_id AND io.immo_objekt_bez = wp.wup_id
WHERE
  io.dat_bis = CAST('9999-12-31' AS DATE)
  AND NOT (io.mandant_id, io.immo_objekt_id) IN (
    SELECT
      (mandant_id, immo_objekt_id)
    FROM kfl_production_dbp_view.v_ivs_immo_objekt_per_2
    WHERE
      dat_bis = CAST('9999-12-31' AS DATE)
      AND (
        dat_umgl > CURRENT_DATE
        OR status_umgl = 'UMGL'
        AND dat_umgl IS NULL
        AND (mandant_id, ref_immo_objekt_id) IN (
          SELECT
            (mandant_id, ref_immo_objekt_id)
          FROM kfl_production_dbp_view.v_ivs_immo_objekt_per_2
          WHERE
            dat_umgl <= CURRENT_DATE AND dat_bis = CAST('9999-12-31' AS DATE)
        )
      )
  )
UNION ALL
SELECT
  mandant_id,
  'IW----------0',
  DATE('1900-01-01'),
  DATE('9999-12-31'),
  0,
  0,
  '',
  '',
  '',
  'ohne Zuordnung',
  DATE('1900-01-01'),
  DATE('1900-01-01'),
  DATE('1900-01-01'),
  DATE('1900-01-01'),
  '3',
  DATE('1900-01-01'),
  DATE('9999-12-31'),
  DATE(NULL),
  SUBSTR(NULL, 1, 10),
  0.00,
  0.00,
  wrg_id,
  wrg_typ_id,
  'IW----------0',
  'IW----------0',
  '',
  0,
  0,
  'ohne Zuordnung'
FROM kfl_production_dbp_view.v_mandant_wrg_typ_zu_2;
