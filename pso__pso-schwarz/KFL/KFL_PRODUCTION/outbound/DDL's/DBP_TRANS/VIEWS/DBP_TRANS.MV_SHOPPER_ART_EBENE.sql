CREATE OR REPLACE VIEW kfl_production_dbp_trans.mv_shopper_art_ebene (anz_bon_af, anz_bon_aktion, anz_bon_sa,
anz_cp_kaeufer, anz_cp_kaeufer_70_prozent, anz_kaeufer_af, anz_kaeufer_sa, anz_markt_baseline_af, anz_tage_baseline_af,
anz_tage_sa, anz_tage_wo1, anz_tage_wo2, anz_tage_wo3, art_id_werbung, kl_art_id_lang, dat_baseline_bis,
dat_baseline_von, ertrag_baseline_af, ertrag_sa, kaeufer_prozent_baseline_af, kaeufer_prozent_sa, kjwo_werbe_ende,
mandant_id, menge_baseline_af, menge_sa, menge_wo1, menge_wo2, menge_wo3, ums_aktivierter_normalpreis,
ums_gesamt_af_mit_wv, ums_gesamt_ausser_artikel, ums_netto_baseline_af, ums_netto_sa, ums_rest_bon_af,
ums_rest_bon_gesamt, vk_brutto_af_mittel, vk_brutto_sa_mittel, vk_brutto_sa_max, wrg_id, anz_markt_sa) AS
-- Käufer Baseline (AF) und Werbewoche (SA)

-- , NULLIFZERO(SUM(v01.anz_kaeufer_af)) / NULLIFZERO(SUM (anz_tage_baseline_af)) AS anz_kaeufer_af

-- , NULLIFZERO(SUM(v01.anz_kaeufer_sa)) / NULLIFZERO(SUM (anz_tage_sa)) AS anz_kaeufer_sa
 -- 

-- Käuferreichweite Baseline (AF) und Werbewoche - falsche Berechnungsebene -> wurde in FE verlagert
 -- 

-- Aktivierter Normalpreis Umsatz  - falsche Berechnungsebene -> wurde in FE verlagert

-- Restbon  - falsche Berechnungsebene -> wurde in FE verlagert

-- Preispunkt AF /SA  - falsche Berechnungsebene -> wurde in FE verlagert
 SELECT SUM(CAST(ROUND(V01.anz_bon_af) AS INTEGER)
  ) AS anz_bon_af,
 SUM(V01.anz_bon_aktion) AS anz_bon_aktion,
 SUM(V01.anz_bon_sa) AS anz_bon_sa,
 SUM(V01.anz_cp_kaeufer) AS anz_cp_kaeufer,
 SUM(V01.anz_cp_kaeufer_70_prozent) AS anz_cp_kaeufer_70_prozent,
 SUM(V01.anz_kaeufer_af) AS anz_kaeufer_af,
 SUM(V01.anz_kaeufer_sa) AS anz_kaeufer_sa,
 SUM(V01.anz_markt_baseline_af) AS anz_markt_baseline_af,
 SUM(V01.anz_tage_baseline_af) AS anz_tage_baseline_af,
 SUM(V01.anz_tage_sa) AS anz_tage_sa,
 SUM(V01.anz_tage_wo1) AS anz_tage_wo1,
 SUM(V01.anz_tage_wo2) AS anz_tage_wo2,
 SUM(V01.anz_tage_wo3) AS anz_tage_wo3,
 V01.art_id_werbung,
 CAST(V02.kl_art_id AS STRING) AS kl_art_id_lang,
 MAX(V01.dat_baseline_bis) AS dat_baseline_bis,
 MIN(V01.dat_baseline_von) AS dat_baseline_von,
 CAST(SUM(V01.ertrag_baseline_af) AS NUMERIC) AS ertrag_baseline_af,
 CAST(SUM(V01.ertrag_sa) AS NUMERIC) AS ertrag_sa,
   100.00 * IF(SUM(V01.anz_kaeufer_af) = 0, NULL, SUM(V01.anz_kaeufer_af)) / IF(SUM(V01.anz_bon_af) = 0, NULL, SUM(V01.anz_bon_af
    )) AS kaeufer_prozent_baseline_af,
   100.00 * IF(SUM(V01.anz_kaeufer_sa) = 0, NULL, SUM(V01.anz_kaeufer_sa)) / IF(SUM(V01.anz_bon_aktion) = 0, NULL, SUM(V01
    .anz_bon_aktion)) AS kaeufer_prozent_sa,
 V01.kjwo_werbe_ende,
 V01.mandant_id,
 SUM(V01.menge_baseline_af) AS menge_baseline_af,
 SUM(V01.menge_sa) AS menge_sa,
 SUM(V01.menge_wo1) AS menge_wo1,
 SUM(V01.menge_wo2) AS menge_wo2,
 SUM(V01.menge_wo3) AS menge_wo3,
 CAST(IF(SUM(V01.ums_gesamt_af_mit_wv) = 0, NULL, SUM(V01.ums_gesamt_af_mit_wv)) / IF(SUM(V01.anz_tage_sa) = 0, NULL, SUM(V01.anz_tage_sa)) AS NUMERIC)
 AS ums_aktivierter_normalpreis,
 CAST(SUM(V01.ums_gesamt_af_mit_wv) AS NUMERIC) AS ums_gesamt_af_mit_wv,
 CAST(SUM(V01.ums_gesamt_ausser_artikel) AS NUMERIC) AS ums_gesamt_ausser_artikel,
 CAST(SUM(V01.ums_netto_baseline_af) AS NUMERIC) AS ums_netto_baseline_af,
 CAST(SUM(V01.ums_netto_sa) AS NUMERIC) AS ums_netto_sa,
 CAST(IF(SUM(V01.ums_gesamt_af_mit_wv) = 0, NULL, SUM(V01.ums_gesamt_af_mit_wv)) / IF(SUM(V01.anz_cp_kaeufer) = 0, NULL, SUM(V01.anz_cp_kaeufer)) AS NUMERIC)
 AS ums_rest_bon_af,
 CAST(IF(SUM(V01.ums_gesamt_ausser_artikel) = 0, NULL, SUM(V01.ums_gesamt_ausser_artikel)) / IF(SUM(V01.anz_cp_kaeufer) = 0, NULL, SUM(V01.anz_cp_kaeufer)) AS NUMERIC)
 AS ums_rest_bon_gesamt,
 CAST(SUM(V01.vk_brutto_af_mittel) AS NUMERIC) AS vk_brutto_af_mittel,
 CAST(SUM(V01.vk_brutto_sa_mittel) AS NUMERIC) AS vk_brutto_sa_mittel,
 CAST(SUM(V01.vk_brutto_sa_max) AS NUMERIC) AS vk_brutto_sa_max,
 V01.wrg_id,
 SUM(V01.anz_markt_sa) AS anz_markt_sa
FROM kfl_production_dbp_view.v_shopper AS V01
 INNER JOIN kfl_production_dbp_view.v_art AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id_werbung = V02.art_id
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.mandant_id > 1
GROUP BY V01.aktion_thema_gruppe_id,
 V01.art_id_werbung,
 V02.kl_art_id,
 V02.art_id -- , v01.dat_baseline_bis
 -- , v01.dat_baseline_von
,
 V01.kjwo_werbe_ende,
 V01.mandant_id,
 V01.wrg_id;