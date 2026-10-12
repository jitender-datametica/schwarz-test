CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_fehlmengen_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  lagerort_id AS lagerort_id,
  empfaenger_wup_id AS empfaenger_wup_id,
  mandant_id_empfaenger AS mandant_id_empfaenger,
  empfaenger_nb_id AS empfaenger_nb_id,
  art_id AS art_id,
  dat_lief_soll AS dat_lief_soll,
  bestellart_id AS bestellart_id,
  wrg_id AS wrg_id,
  kuerzung_fg AS lieferungskuerzung_fg,
  diff_id AS diff_id,
  menge_lief_soll_kolli AS menge_lief_soll_kolli,
  menge_lief_ist_kolli AS menge_lief_ist_kolli,
  ek_netto_bnk_soll AS ek_netto_bnk_soll,
  ek_netto_bnk_ist AS ek_netto_bnk_ist,
  vk_netto_soll AS vk_netto_lief_soll,
  vk_netto_ist AS vk_netto_lief_ist,
  kuerz_menge_lief_soll_kolli AS kz_menge_lief_soll_kolli,
  kuerz_menge_lief_ist_kolli AS kz_menge_lief_ist_kolli,
  kuerz_ek_netto_bnk_soll AS kz_ek_netto_bnk_soll,
  kuerz_ek_netto_bnk_ist AS kz_ek_netto_bnk_ist,
  kuerz_vk_netto_soll AS kz_vk_netto_lief_soll,
  kuerz_vk_netto_ist AS kz_vk_netto_lief_ist
FROM kfl_production_dbp_view.v_besch_lief_fehlmengen_2 AS v01
WHERE
  mandant_id = 1;
