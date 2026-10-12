CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_art_umbewertung
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.umbew_beleg_id AS umbew_beleg_id,
  v01.umbew_beleg_pos_id AS umbew_beleg_pos_id,
  v01.kj AS kj,
  v01.preis_aend_grund_id AS preis_aend_grund_id,
  v01.art_id AS art_id,
  v01.wup_id AS wup_id,
  v01.nb_id AS nb_id,
  v01.dat_umbew AS dat_umbew,
  v01.menge_umbew AS menge_umbew,
  v01.wrg_id AS wrg_id,
  CASE
    WHEN v01.mandant_id IN (3, 6, 7, 8) AND v01.preis_aend_grund_id IS NULL
    THEN NULL
    WHEN v01.mandant_id = 6 AND v01.preis_aend_grund_id = 50
    THEN 0
    WHEN v01.mandant_id IN (2, 3, 4, 5, 7, 8)
    AND v01.preis_aend_grund_id = 12
    OR v01.mandant_id IN (2, 4, 5, 7, 8)
    AND v01.preis_aend_grund_id = 11
    OR v01.preis_aend_grund_id IN (9, 10)
    THEN v01.menge_umbew
    WHEN v01.mandant_id IN (2, 4, 5, 7, 8)
    AND v01.preis_aend_grund_id = 7
    AND v01.wert_bestand_brutto_alt < 0
    AND v01.menge_bestand_bme < 0
    AND v01.menge_umbew = 0
    OR v01.mandant_id = 6
    AND v01.preis_aend_grund_id = 2
    AND v01.wert_bestand_brutto_alt < 0
    AND v01.menge_bestand_bme < 0
    AND v01.menge_umbew = 0
    OR v01.mandant_id IN (3, 4)
    AND v01.preis_aend_grund_id = 11
    AND v01.wert_bestand_brutto_alt < 0
    AND v01.menge_bestand_bme < 0
    AND v01.menge_umbew = 0
    OR v01.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    AND v01.preis_aend_grund_id = 6
    AND v01.wert_bestand_brutto_alt < 0
    AND v01.menge_bestand_bme < 0
    AND v01.menge_umbew = 0
    THEN v01.menge_erf * -1
    ELSE v01.menge_erf
  END AS menge_berechnet,
  v02.gp_id AS gp_id,
  v300.umrechnungskurs AS umrechnungskurs_0,
  v400.umrechnungskurs AS umrechnungskurs_1,
  v01.diff_wert_bestand_brutto AS diff_wert_bestand_brutto,
  v01.vk_brutto_alt AS vk_brutto_alt,
  v01.diff_wert_bestand_netto AS diff_wert_bestand_netto
FROM kfl_production_dbp_view.v_art_umbewertung AS v01
LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS v02
  ON v01.art_id = v02.art_id
  AND v01.wup_id = v02.wup_id
  AND v01.mandant_id = v02.mandant_id
  AND v01.dat_umbew BETWEEN v02.dat_von AND v02.dat_bis
INNER JOIN kfl_production_dbp_view.v_kurs AS v300
  ON v300.dat_bis = CAST('9999-12-31' AS DATE)
  AND v01.wrg_id = v300.von_wrg_id
  AND v300.kurstyp_id = 3
  AND v300.nach_wrg_id = 'EUR'
INNER JOIN kfl_production_dbp_view.v_kurs AS v400
  ON v01.dat_umbew BETWEEN v400.dat_von AND v400.dat_bis
  AND v01.wrg_id = v400.von_wrg_id
  AND v400.kurstyp_id = 3
  AND v400.nach_wrg_id = 'EUR'
WHERE
  v01.mandant_id <> 1;
