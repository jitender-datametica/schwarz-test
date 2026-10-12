CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_artbew_dat_ek_cp_sum_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  art_id AS art_id,
  gp_id AS gp_id,
  bewart_id AS bewart_id,
  bewart_det_id AS bewart_det_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  dat AS dat,
  wrg_id AS wrg_id,
  wup_bereinigt_fg AS wup_bereinigt_fg,
  zek_id AS zek_id,
  eigenmarke_fg AS eigenmarke_fg,
  umsatz_netto AS umsatz_netto,
  umsatz_netto_vj AS umsatz_netto_vj,
  betrag_kmep_kw AS betrag_kmep_kw,
  betrag_kmep_kw_vj AS betrag_kmep_kw_vj,
  betrag_kmep_ww AS betrag_kmep_ww,
  betrag_kmep_ww_vj AS betrag_kmep_ww_vj,
  betrag_kmep_km AS betrag_kmep_km,
  betrag_kmep_km_vj AS betrag_kmep_km_vj,
  logkostenzuschlag AS logkostenzuschlag,
  logkostenzuschlag_vj AS logkostenzuschlag_vj,
  werbe_abschrift_netto AS werbe_abschrift_netto,
  werbe_abschrift_netto_vj AS werbe_abschrift_netto_vj,
  preis_abschrift_netto AS preis_abschrift_netto,
  preis_abschrift_netto_vj AS preis_abschrift_netto_vj
FROM kfl_production_dbp_data.artbew_dat_ek_cp_sum_2
WHERE
  mandant_id = 1 AND wup_bereinigt_fg = 0;
