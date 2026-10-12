CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_marktabschriften
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.wup_id AS wup_id,
  v01.wup_abschrift_id AS wup_abschrift_id,
  v01.positionsnummer_id AS positionsnummer_id,
  v01.abschriftart_id AS abschriftart_id,
  v01.nb_id AS nb_id,
  v01.dat AS dat,
  v01.woche_id AS woche_id,
  v01.art_id AS art_id,
  v01.lastupd_dat AS lastupd_dat,
  v03.gewart_id AS gewart_id,
  v02.gp_id AS gp_id,
  SUBSTR(
    CASE WHEN NOT v200.posten_id IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END,
    1,
    2
  ) AS posten_kz_per,
  v01.menge_abschrift AS menge_abschrift,
  v01.abschriftbetrag_brutto AS abschriftbetrag_brutto,
  v300.umrechnungskurs AS umrechnungskurs_0,
  v400.umrechnungskurs AS umrechnungskurs_1,
  v01.abschriftbetrag_netto AS abschriftbetrag_netto
FROM kfl_production_dbp_data.marktabschriften AS v01
LEFT JOIN kfl_production_dbp_data.art_gp_nm_zu_per AS v02
  ON v01.art_id = v02.art_id
  AND v01.wup_id = v02.wup_id
  AND v01.mandant_id = v02.mandant_id
  AND v01.dat BETWEEN v02.dat_von AND v02.dat_bis
INNER JOIN kfl_production_dbp_data.art AS v03
  ON v01.mandant_id = v03.mandant_id AND v01.art_id = v03.art_id
INNER JOIN kfl_production_dbp_data.mandant AS v100
  ON v01.mandant_id = v100.mandant_id
LEFT JOIN kfl_production_dbp_data.art_per AS v200
  ON v01.mandant_id = v200.mandant_id
  AND v01.art_id = v200.art_id
  AND v01.dat BETWEEN v200.dat_von AND v200.dat_bis
INNER JOIN kfl_production_dbp_data.kurs AS v300
  ON v300.dat_bis = CAST('9999-12-31' AS DATE)
  AND v01.wrg_id = v300.von_wrg_id
  AND v300.kurstyp_id = 3
  AND v300.nach_wrg_id = 'EUR'
INNER JOIN kfl_production_dbp_data.kurs AS v400
  ON v01.dat BETWEEN v400.dat_von AND v400.dat_bis
  AND v01.wrg_id = v400.von_wrg_id
  AND v400.kurstyp_id = 3
  AND v400.nach_wrg_id = 'EUR'
WHERE
  v01.abschriftart_id BETWEEN 905 AND 994
  AND v01.mandant_id <> 1
  AND (
    v01.abschriftart_id <> 955 OR v01.mandant_id <> 2
  )
UNION ALL
SELECT
  v01.mandant_id,
  v01.wup_id,
  v01.lagerbew_beleg_id,
  v01.lagerbew_beleg_pos_id,
  CASE
    WHEN v01.lager_bewart_id IN ('Y01', 'Y02')
    THEN 210
    WHEN v01.lager_bewart_id IN ('Y07', 'Y08')
    THEN 211
    WHEN v01.lager_bewart_id IN ('Y11', 'Y12')
    THEN 240
    WHEN v01.lager_bewart_id IN ('Y05', 'Y06')
    THEN 241
    WHEN v01.lager_bewart_id IN ('Y35', 'Y36')
    THEN 242
    ELSE NULL
  END AS lager_bewart_id,
  v01.nb_id,
  v01.dat_buch,
  ROUND(
    CAST(CASE
      WHEN EXTRACT(ISOWEEK FROM v01.dat_buch) < 10
      THEN CONCAT(EXTRACT(YEAR FROM v01.dat_buch), '0', EXTRACT(ISOWEEK FROM v01.dat_buch))
      ELSE CONCAT(EXTRACT(YEAR FROM v01.dat_buch), EXTRACT(ISOWEEK FROM v01.dat_buch))
    END AS BIGNUMERIC),
    0
  ) AS v01_dat_buch_v01_dat_buch_v01_dat_buch_v01_dat_buch_v01_dat_buch,
  v01.art_id,
  v01.dat_buch AS dat_buch0,
  v03.gewart_id,
  v01.gp_id,
  SUBSTR(
    CASE WHEN NOT v200.posten_id IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END,
    1,
    2
  ) AS posten_kz_per,
  CASE
    WHEN v03.gewart_id = 'KG'
    THEN v01.menge_lagerbew_bme * 1000
    ELSE v01.menge_lagerbew_bme
  END,
  v01.betrag_verkauf,
  v300.umrechnungskurs AS umrechnungskurs_0,
  v400.umrechnungskurs AS umrechnungskurs_1,
  v01.betrag_vk_netto_vz
FROM kfl_production_dbp_data.lagerbew_det AS v01
INNER JOIN kfl_production_dbp_data.art AS v03
  ON v01.mandant_id = v03.mandant_id AND v01.art_id = v03.art_id
LEFT JOIN kfl_production_dbp_data.art_per AS v200
  ON v01.mandant_id = v200.mandant_id
  AND v01.art_id = v200.art_id
  AND v01.dat_buch BETWEEN v200.dat_von AND v200.dat_bis
INNER JOIN kfl_production_dbp_data.kurs AS v300
  ON v300.dat_bis = CAST('9999-12-31' AS DATE)
  AND v01.wrg_id = v300.von_wrg_id
  AND v300.kurstyp_id = 3
  AND v300.nach_wrg_id = 'EUR'
INNER JOIN kfl_production_dbp_data.kurs AS v400
  ON v01.dat_buch BETWEEN v400.dat_von AND v400.dat_bis
  AND v01.wrg_id = v400.von_wrg_id
  AND v400.kurstyp_id = 3
  AND v400.nach_wrg_id = 'EUR'
WHERE
  v01.lager_bewart_id IN ('Y01', 'Y02', 'Y07', 'Y08', 'Y11', 'Y12', 'Y05', 'Y06', 'Y35', 'Y36')
  AND v01.mandant_id <> 1;
