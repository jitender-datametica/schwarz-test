CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_regalachse_akt_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  aktiv_fg AS aktiv_fg,
  art_id AS art_id,
  display_art_id AS display_art_id,
  ek_mep AS ek_mep,
  fachboden_nr AS fachboden_nr,
  fachboden_pos AS fachboden_pos,
  fbb_nr AS fbb_nr,
  kapazitaet AS kapazitaet,
  kapazitaet_faktor AS kapazitaet_faktor,
  kapazitaet_menge_einh_id AS kapazitaet_menge_einh_id,
  mandant_id AS mandant_id,
  nb_id AS nb_id,
  regional_kz AS regional_kz,
  soll_ist_kz AS soll_ist_kz,
  vk_brutto AS vk_brutto,
  vk_brutto / (
    100.000 + mwst
  ) * 100 AS vk_netto,
  wup_id AS wup_id,
  regalachse_flaeche AS regalachse_flaeche
FROM kfl_production_dbp_view.v_regalachse_akt_1
WHERE
  mandant_id = 1 AND aktiv_fg = 1;
