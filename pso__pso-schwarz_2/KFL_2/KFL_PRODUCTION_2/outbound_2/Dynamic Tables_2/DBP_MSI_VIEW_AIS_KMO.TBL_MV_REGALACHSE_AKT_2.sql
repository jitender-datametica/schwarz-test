CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_kmo.tbl_mv_regalachse_akt_2 (
  aktiv_fg BIGNUMERIC(38, 0),
  art_id BIGNUMERIC(38, 0),
  display_art_id BIGNUMERIC(38, 0),
  ek_mep NUMERIC(18, 4),
  fachboden_nr BIGNUMERIC(38, 0),
  fachboden_pos BIGNUMERIC(38, 0),
  fbb_nr STRING(20),
  kapazitaet NUMERIC(18, 3),
  kapazitaet_faktor NUMERIC(18, 4),
  kapazitaet_menge_einh_id STRING(3),
  mandant_id BIGNUMERIC(38, 0),
  nb_id BIGNUMERIC(38, 0),
  regional_kz BIGNUMERIC(38, 0),
  soll_ist_kz BIGNUMERIC(38, 0),
  vk_brutto NUMERIC(9, 2),
  mwst NUMERIC(12, 2),
  wup_id BIGNUMERIC(38, 0),
  regalachse_flaeche NUMERIC(9, 2),
  umrechnungskurs_0 BIGNUMERIC(38, 5),
  umrechnungskurs_1 BIGNUMERIC(38, 5)
) AS
SELECT
  v01.aktiv_fg AS aktiv_fg,
  v01.art_id AS art_id,
  v01.display_art_id AS display_art_id,
  v01.ek_mep AS ek_mep,
  v01.fachboden_nr AS fachboden_nr,
  v01.fachboden_pos AS fachboden_pos,
  v01.fbb_nr AS fbb_nr,
  v01.kapazitaet AS kapazitaet,
  v01.kapazitaet_faktor AS kapazitaet_faktor,
  v01.kapazitaet_menge_einh_id AS kapazitaet_menge_einh_id,
  v01.mandant_id AS mandant_id,
  v01.nb_id AS nb_id,
  v01.regional_kz AS regional_kz,
  v01.soll_ist_kz AS soll_ist_kz,
  v01.vk_brutto AS vk_brutto,
  COALESCE(v01.mwst, 0) AS mwst,
  v01.wup_id AS wup_id,
  v01.regalachse_flaeche AS regalachse_flaeche,
  v400.umrechnungskurs AS umrechnungskurs_0,
  v500.umrechnungskurs AS umrechnungskurs_1
FROM kfl_production_dbp_data.regalachse_akt_2 AS v01
INNER JOIN kfl_production_dbp_data.mandant_2 AS v100
  ON v01.mandant_id = v100.mandant_id
INNER JOIN kfl_production_dbp_view.v_kurs_2 AS v400
  ON v400.dat_bis = CAST('9999-12-31' AS DATE)
  AND v01.wrg_id = v400.von_wrg_id
  AND v400.kurstyp_id = 3
  AND v400.nach_wrg_id = 'EUR'
INNER JOIN kfl_production_dbp_view.v_kurs_2 AS v500
  ON CURRENT_DATE BETWEEN v500.dat_von AND v500.dat_bis
  AND v01.wrg_id = v500.von_wrg_id
  AND v500.kurstyp_id = 3
  AND v500.nach_wrg_id = 'EUR'
WHERE
  v01.mandant_id <> 1;
