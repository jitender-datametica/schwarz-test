CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_shopper_art_ebene (anz_bon_af, anz_bon_aktion, anz_bon_sa
, anz_cp_kaeufer, anz_cp_kaeufer_70_prozent, anz_kaeufer_af, anz_kaeufer_sa, anz_markt_baseline_af, anz_tage_baseline_af
, anz_tage_sa, anz_tage_wo1, anz_tage_wo2, anz_tage_wo3, art_id_werbung, kl_art_id_lang, dat_baseline_bis,
dat_baseline_von, ertrag_baseline_af, ertrag_sa, kaeufer_prozent_baseline_af, kaeufer_prozent_sa, kjwo_werbe_ende,
mandant_id, menge_baseline_af, menge_sa, menge_wo1, menge_wo2, menge_wo3, ums_aktivierter_normalpreis,
ums_gesamt_af_mit_wv, ums_gesamt_ausser_artikel, ums_netto_baseline_af, ums_netto_sa, ums_rest_bon_af,
ums_rest_bon_gesamt, vk_brutto_af_mittel, vk_brutto_sa_mittel, vk_brutto_sa_max, wrg_id, anz_markt_sa) AS SELECT SUM(CAST(V01.anz_bon_af AS BIGNUMERIC)
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
 TRIM(CAST(V02.kl_art_id AS STRING FORMAT '00000000')) AS kl_art_id_lang,
 MAX(V01.dat_baseline_bis) AS dat_baseline_bis,
 MIN(V01.dat_baseline_von) AS dat_baseline_von,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN CAST(SUM(V01.ertrag_baseline_af) AS NUMERIC)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN ROUND(CAST(SUM(V01.ertrag_baseline_af) * MAX(V300.umrechnungskurs) AS NUMERIC), 4)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN ROUND(CAST(SUM(V01.ertrag_baseline_af) * MAX(V400.umrechnungskurs) AS NUMERIC), 4)
   ELSE NULL
   END AS NUMERIC) AS ertrag_baseline_af,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN CAST(SUM(V01.ertrag_sa) AS NUMERIC)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN ROUND(CAST(SUM(V01.ertrag_sa) * MAX(V300.umrechnungskurs) AS NUMERIC), 4)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN ROUND(CAST(SUM(V01.ertrag_sa) * MAX(V400.umrechnungskurs) AS NUMERIC), 4)
   ELSE NULL
   END AS NUMERIC) AS ertrag_sa,
   100.00 * CASE
    WHEN SUM(V01.anz_kaeufer_af) = 0
    THEN NULL
    ELSE SUM(V01.anz_kaeufer_af)
    END / CASE
   WHEN SUM(V01.anz_bon_af) = 0
   THEN NULL
   ELSE SUM(V01.anz_bon_af)
   END AS kaeufer_prozent_baseline_af,
   100.00 * CASE
    WHEN SUM(V01.anz_kaeufer_sa) = 0
    THEN NULL
    ELSE SUM(V01.anz_kaeufer_sa)
    END / CASE
   WHEN SUM(V01.anz_bon_aktion) = 0
   THEN NULL
   ELSE SUM(V01.anz_bon_aktion)
   END AS kaeufer_prozent_sa,
 V01.kjwo_werbe_ende,
 V01.mandant_id,
 SUM(V01.menge_baseline_af) AS menge_baseline_af,
 SUM(V01.menge_sa) AS menge_sa,
 SUM(V01.menge_wo1) AS menge_wo1,
 SUM(V01.menge_wo2) AS menge_wo2,
 SUM(V01.menge_wo3) AS menge_wo3,
 CAST(CASE
   WHEN V200.wrg_typ_id IN (0, 1)
   THEN CAST(CASE
      WHEN SUM(V01.ums_gesamt_af_mit_wv) = 0
      THEN NULL
      ELSE SUM(V01.ums_gesamt_af_mit_wv)
      END / CASE
      WHEN SUM(V01.anz_tage_sa) = 0
      THEN NULL
      ELSE SUM(V01.anz_tage_sa)
      END AS NUMERIC)
   ELSE NULL
   END AS NUMERIC) AS ums_aktivierter_normalpreis,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN CAST(SUM(V01.ums_gesamt_af_mit_wv) AS NUMERIC)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN ROUND(CAST(SUM(V01.ums_gesamt_af_mit_wv) * MAX(V300.umrechnungskurs) AS NUMERIC), 4)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN ROUND(CAST(SUM(V01.ums_gesamt_af_mit_wv) * MAX(V400.umrechnungskurs) AS NUMERIC), 4)
   ELSE NULL
   END AS NUMERIC) AS ums_gesamt_af_mit_wv,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN CAST(SUM(V01.ums_gesamt_ausser_artikel) AS NUMERIC)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN ROUND(CAST(SUM(V01.ums_gesamt_ausser_artikel) * MAX(V300.umrechnungskurs) AS NUMERIC), 4)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN ROUND(CAST(SUM(V01.ums_gesamt_ausser_artikel) * MAX(V400.umrechnungskurs) AS NUMERIC), 4)
   ELSE NULL
   END AS NUMERIC) AS ums_gesamt_ausser_artikel,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN CAST(SUM(V01.ums_netto_baseline_af) AS NUMERIC)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN ROUND(CAST(SUM(V01.ums_netto_baseline_af) * MAX(V300.umrechnungskurs) AS NUMERIC), 4)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN ROUND(CAST(SUM(V01.ums_netto_baseline_af) * MAX(V400.umrechnungskurs) AS NUMERIC), 4)
   ELSE NULL
   END AS NUMERIC) AS ums_netto_baseline_af,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN CAST(SUM(V01.ums_netto_sa) AS NUMERIC)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN ROUND(CAST(SUM(V01.ums_netto_sa) * MAX(V300.umrechnungskurs) AS NUMERIC), 4)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN ROUND(CAST(SUM(V01.ums_netto_sa) * MAX(V400.umrechnungskurs) AS NUMERIC), 4)
   ELSE NULL
   END AS NUMERIC) AS ums_netto_sa,
 CAST(CASE
   WHEN V200.wrg_typ_id IN (0, 1)
   THEN CAST(CASE
      WHEN SUM(V01.ums_gesamt_af_mit_wv) = 0
      THEN NULL
      ELSE SUM(V01.ums_gesamt_af_mit_wv)
      END / CASE
      WHEN SUM(V01.anz_cp_kaeufer) = 0
      THEN NULL
      ELSE SUM(V01.anz_cp_kaeufer)
      END AS NUMERIC)
   ELSE NULL
   END AS NUMERIC) AS ums_rest_bon_af,
 CAST(CASE
   WHEN V200.wrg_typ_id IN (0, 1)
   THEN CAST(CASE
      WHEN SUM(V01.ums_gesamt_ausser_artikel) = 0
      THEN NULL
      ELSE SUM(V01.ums_gesamt_ausser_artikel)
      END / CASE
      WHEN SUM(V01.anz_cp_kaeufer) = 0
      THEN NULL
      ELSE SUM(V01.anz_cp_kaeufer)
      END AS NUMERIC)
   ELSE NULL
   END AS NUMERIC) AS ums_rest_bon_gesamt,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN CAST(SUM(V01.vk_brutto_af_mittel) AS NUMERIC)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN ROUND(CAST(SUM(V01.vk_brutto_af_mittel) * MAX(V300.umrechnungskurs) AS NUMERIC), 4)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN ROUND(CAST(SUM(V01.vk_brutto_af_mittel) * MAX(V400.umrechnungskurs) AS NUMERIC), 4)
   ELSE NULL
   END AS NUMERIC) AS vk_brutto_af_mittel,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN CAST(SUM(V01.vk_brutto_sa_mittel) AS NUMERIC)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN ROUND(CAST(SUM(V01.vk_brutto_sa_mittel) * MAX(V300.umrechnungskurs) AS NUMERIC), 4)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN ROUND(CAST(SUM(V01.vk_brutto_sa_mittel) * MAX(V400.umrechnungskurs) AS NUMERIC), 4)
   ELSE NULL
   END AS NUMERIC) AS vk_brutto_sa_mittel,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN CAST(SUM(V01.vk_brutto_sa_max) AS NUMERIC)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN ROUND(CAST(SUM(V01.vk_brutto_sa_max) * MAX(V300.umrechnungskurs) AS NUMERIC), 4)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN ROUND(CAST(SUM(V01.vk_brutto_sa_max) * MAX(V400.umrechnungskurs) AS NUMERIC), 4)
   ELSE NULL
   END AS NUMERIC) AS vk_brutto_sa_max,
 V01.wrg_id,
 SUM(V01.anz_markt_sa) AS anz_markt_sa
FROM kfl_production_dbp_view.v_shopper AS V01
 INNER JOIN kfl_production_dbp_view.v_art AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id_werbung = V02.art_id
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_woche AS V500 ON V01.kjwo_werbe_ende = V500.kjwo
 INNER JOIN kfl_production_dbp_view.v_kurs AS V300 ON V100.default_wrg = V300.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs AS V400 ON V500.wo_dat_von BETWEEN V400.dat_von AND V400.dat_bis AND V100.default_wrg
    = V400.von_wrg_id
WHERE V400.kurstyp_id = 3
 AND V400.nach_wrg_id = 'EUR'
 AND V300.dat_bis = DATE '9999-12-31'
 AND V300.kurstyp_id = 3
 AND V300.nach_wrg_id = 'EUR'
 AND V01.mandant_id > 1
GROUP BY V01.aktion_thema_gruppe_id,
 V01.art_id_werbung,
 V02.kl_art_id,
 V02.art_id,
 V01.kjwo_werbe_ende,
 V01.mandant_id,
 V01.wrg_id,
 V200.wrg_typ_id,
 V200.berichtskurs_typ_id;