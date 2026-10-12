CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_shopper_art_ebene
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.aktion_thema_gruppe_id AS aktion_thema_gruppe_id,
  SUM(v01.anz_bon_af) AS anz_bon_af,
  SUM(v01.anz_bon_aktion) AS anz_bon_aktion,
  SUM(v01.anz_bon_sa) AS anz_bon_sa,
  SUM(v01.anz_cp_kaeufer) AS anz_cp_kaeufer,
  SUM(v01.anz_cp_kaeufer_70_prozent) AS anz_cp_kaeufer_70_prozent,
  SUM(v01.anz_kaeufer_af) AS anz_kaeufer_af,
  SUM(v01.anz_kaeufer_sa) AS anz_kaeufer_sa,
  SUM(v01.anz_markt_baseline_af) AS anz_markt_baseline_af,
  SUM(v01.anz_tage_baseline_af) AS anz_tage_baseline_af,
  SUM(v01.anz_tage_sa) AS anz_tage_sa,
  SUM(v01.anz_tage_wo1) AS anz_tage_wo1,
  SUM(v01.anz_tage_wo2) AS anz_tage_wo2,
  SUM(v01.anz_tage_wo3) AS anz_tage_wo3,
  v01.art_id_werbung AS art_id_werbung,
  CAST(v02.art_id / 100 AS STRING FORMAT '0000000') AS art_id_langlaeufer,
  v01.baseline AS baseline,
  MAX(v01.dat_baseline_bis) AS dat_baseline_bis,
  MIN(v01.dat_baseline_von) AS dat_baseline_von,
  SUM(v01.ertrag_baseline_af) AS ertrag_baseline_af,
  SUM(v01.ertrag_sa) AS ertrag_sa,
  100.00 * CASE WHEN SUM(v01.anz_kaeufer_af) = 0 THEN NULL ELSE SUM(v01.anz_kaeufer_af) END / CASE WHEN SUM(v01.anz_bon_af) = 0 THEN NULL ELSE SUM(v01.anz_bon_af) END AS kaeufer_prozent_baseline_af,
  100.00 * CASE WHEN SUM(v01.anz_kaeufer_sa) = 0 THEN NULL ELSE SUM(v01.anz_kaeufer_sa) END / CASE WHEN SUM(v01.anz_bon_aktion) = 0 THEN NULL ELSE SUM(v01.anz_bon_aktion) END AS kaeufer_prozent_sa,
  v01.kjwo_werbe_ende AS kjwo_werbe_ende,
  v01.mandant_id AS mandant_id,
  v01.medien_kz AS medien_kz,
  SUM(v01.menge_baseline_af) AS menge_baseline_af,
  SUM(v01.menge_sa) AS menge_sa,
  SUM(v01.menge_wo1) AS menge_wo1,
  SUM(v01.menge_wo2) AS menge_wo2,
  SUM(v01.menge_wo3) AS menge_wo3,
  CASE
    WHEN SUM(v01.ums_gesamt_af_mit_wv) = 0
    THEN NULL
    ELSE SUM(v01.ums_gesamt_af_mit_wv)
  END / CASE WHEN SUM(v01.anz_tage_sa) = 0 THEN NULL ELSE SUM(v01.anz_tage_sa) END AS ums_aktivierter_normalpreis,
  SUM(v01.ums_gesamt_af_mit_wv) AS ums_gesamt_af_mit_wv,
  SUM(v01.ums_gesamt_ausser_artikel) AS ums_gesamt_ausser_artikel,
  SUM(v01.ums_netto_baseline_af) AS ums_netto_baseline_af,
  SUM(v01.ums_netto_sa) AS ums_netto_sa,
  CASE
    WHEN SUM(v01.ums_gesamt_af_mit_wv) = 0
    THEN NULL
    ELSE SUM(v01.ums_gesamt_af_mit_wv)
  END / CASE WHEN SUM(v01.anz_cp_kaeufer) = 0 THEN NULL ELSE SUM(v01.anz_cp_kaeufer) END AS ums_rest_bon_af,
  CASE
    WHEN SUM(v01.ums_gesamt_ausser_artikel) = 0
    THEN NULL
    ELSE SUM(v01.ums_gesamt_ausser_artikel)
  END / CASE WHEN SUM(v01.anz_cp_kaeufer) = 0 THEN NULL ELSE SUM(v01.anz_cp_kaeufer) END AS ums_rest_bon_gesamt,
  SUM(v01.vk_brutto_af_mittel) AS vk_brutto_af_mittel,
  SUM(v01.vk_brutto_sa_mittel) AS vk_brutto_sa_mittel,
  SUM(v01.vk_brutto_sa_max) AS vk_brutto_sa_max,
  v01.wrg_id AS wrg_id,
  SUM(v01.anz_markt_sa) AS anz_markt_sa
FROM kfl_production_dbp_view.v_shopper AS v01
INNER JOIN kfl_production_dbp_view.v_art AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.art_id_werbung = v02.art_id
WHERE
  v01.mandant_id = 1
GROUP BY
  v01.aktion_thema_gruppe_id,
  v01.art_id_werbung,
  v02.art_id,
  v01.baseline,
  v01.kjwo_werbe_ende,
  v01.mandant_id,
  v01.medien_kz,
  v01.wrg_id;
