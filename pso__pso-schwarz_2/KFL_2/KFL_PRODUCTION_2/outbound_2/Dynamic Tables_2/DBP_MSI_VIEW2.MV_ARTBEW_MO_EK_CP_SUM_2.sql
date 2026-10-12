CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_artbew_mo_ek_cp_sum_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  art_id AS art_id,
  gp_id AS gp_id,
  bewart_id AS bewart_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  kjmo AS kjmo,
  wrg_id AS wrg_id,
  wup_bereinigt_fg AS wup_bereinigt_fg,
  zek_id AS zek_id,
  eigenmarke_fg AS eigenmarke_fg,
  umsatz_netto AS umsatz_netto,
  umsatz_netto_vj AS umsatz_netto_vj,
  betrag_kmep AS betrag_kmep,
  betrag_kmep_vj AS betrag_kmep_vj,
  logkostenzuschlag AS logkostenzuschlag,
  logkostenzuschlag_vj AS logkostenzuschlag_vj,
  werbe_abschrift_netto AS werbe_abschrift_netto,
  werbe_abschrift_netto_vj AS werbe_abschrift_netto_vj,
  preis_abschrift_netto AS preis_abschrift_netto,
  preis_abschrift_netto_vj AS preis_abschrift_netto_vj
FROM kfl_production_dbp_data.artbew_mo_ek_cp_sum_2
WHERE
  mandant_id = 1 AND wup_bereinigt_fg = 0;
