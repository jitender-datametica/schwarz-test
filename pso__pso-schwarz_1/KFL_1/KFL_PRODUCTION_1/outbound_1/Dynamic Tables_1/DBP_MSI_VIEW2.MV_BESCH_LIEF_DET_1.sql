CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_besch_lief_det_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  lief_beleg_id AS lief_beleg_id,
  lief_beleg_pos_id AS lief_beleg_pos_id,
  art_id AS art_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  menge_lief_ist_bme AS menge_lief_ist_bme,
  vorlage_beleg_id AS vorlage_beleg_id,
  vorlage_beleg_pos_id AS vorlage_beleg_pos_id,
  diff_id AS diff_id,
  menge_lief_soll_kolli AS menge_lief_soll_kolli,
  bruttogew AS bruttogew,
  verk_menge_einh_id AS verk_menge_einh_id,
  lagerort_id AS lagerort_id,
  menge_kolli AS menge_kolli,
  menge_lief_palette AS menge_lief_palette,
  annahmeverweigerung_id AS annahmeverweigerung_id,
  dat_haltbarkeit AS dat_haltbarkeit,
  dat_aenderung AS dat_aenderung,
  best_beleg_id AS best_beleg_id,
  best_beleg_pos_id AS best_beleg_pos_id,
  dat_lief_soll AS dat_lief_soll,
  menge_lief_soll_bme AS menge_lief_soll_bme,
  menge_lief_ist_kolli AS menge_lief_ist_kolli,
  betrag_lief_ist AS betrag_lief_ist,
  betrag_lief_soll AS betrag_lief_soll,
  menge_lief_ist_lme AS menge_lief_ist_lme,
  aktions_pos_kz AS aktions_pos_kz,
  besch_palette_fg AS besch_palette_fg,
  vk_netto_lief_soll AS vk_netto_lief_soll,
  vk_netto_lief_ist AS vk_netto_lief_ist
FROM kfl_production_dbp_view.v_besch_lief_det_1
WHERE
  mandant_id = 1 AND nb_id <> 99;
