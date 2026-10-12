CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_vis_tag_fwws_wg
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  nb_id AS nb_id,
  wup_id AS wup_id,
  bezugsweg_id AS bezugsweg_id,
  arthiertyp_id AS arthiertyp_id,
  abt_id AS abt_id,
  wg_id AS wg_id,
  dat AS dat,
  kjwo AS kjwo,
  kjmo AS kjmo,
  gj AS gj,
  akt_tag AS akt_tag,
  disponent_id AS disponent_id,
  dispomerkmal AS dispomerkmal,
  anz_artikel_autodispo AS anz_artikel_autodispo,
  anz_artikel_markt_gelistet_okd AS anz_artikel_markt_gelistet_okd,
  anz_artikel_markt_gelistet AS anz_artikel_markt_gelistet,
  anz_artikel_exc209 AS anz_artikel_exc209,
  anz_artikel_exc214 AS anz_artikel_exc214,
  anz_artikel_autodispo_dm12 AS anz_artikel_autodispo_dm12,
  sum_artikel_autodispo AS sum_artikel_autodispo,
  sum_artikel_markt_gelistet_okd AS sum_artikel_markt_gelistet_okd,
  sum_artikel_markt_gelistet AS sum_artikel_markt_gelistet,
  tagesartikel_fg AS tagesartikel_fg
FROM kfl_production_dbp_msi_v_view.v_vis_tag_fwws_wg AS v01
WHERE
  mandant_id = 1;
