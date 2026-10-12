CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_bsch_lief_det
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.best_beleg_id AS bsch_id,
  v01.best_beleg_pos_id AS bsch_pos_id,
  v01.dat_buch AS dat_lief,
  v01.dat_buch AS dat,
  v01.endlief_fg AS status,
  v01.annahmeverweigerung_id AS annahmeverweigerung_id,
  v01.nb_id AS nb_id,
  v01.art_id AS art_id,
  v01.gp_id AS beleg_gp_id,
  v01.wup_id AS wup_id,
  v01.bestellart_id AS bestellart_id,
  v01.dat_best_beleg AS dat_best,
  v01.dat_lief_wunsch AS dat_lief_wunsch,
  v01.dat_lief_bewertung AS dat_lief_bewertung,
  v01.menge_lief AS lief_menge,
  v01.betrag_lagerbew_ek_n AS lieferwert,
  v01.betrag_best_ek_n AS bestellwert,
  v01.menge_best_bme AS best_menge,
  v01.menge_best_bme * v01.best_menge_orig_fg AS menge_best_orig,
  v01.menge_lief_soll_kolli * v01.best_menge_orig_fg AS menge_best_kolli_orig,
  v01.lagerort_id AS lagerort_id,
  v02.gp_id AS gp_id,
  v01.loesch_fg_ekko AS loesch_fg_ekko,
  v01.loesch_fg_ekpo AS loesch_fg_ekpo,
  v01.selbstabhol_fg AS selbstabhol_fg,
  v01.anzahl_lief AS anzahl_lief,
  v01.anzahl_lief_pos AS anzahl_lief_pos,
  v01.lager_bewart_id AS lager_bewart_id
FROM kfl_production_dbp_view.v_besch_best_lief_lbs AS v01
INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.art_id = v02.art_id
  AND v01.dat_buch BETWEEN v02.dat_von AND v02.dat_bis
WHERE
  v01.mandant_id = 1 AND v01.nb_id <> 99;
