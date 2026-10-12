CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_coupon_redemption_2 (mandant_id, mandant_bez, bonuskauf_id,
einloesedatum, einloesedatum_buchung, gutschriftsdatum, filialnummer, buchungskreis, kaufland_artikel_nr,
artikelbezeichnung, owg_nr, wg_nr, betrag_brutto_gezahlt, betrag_netto_gezahlt, betrag_brutto_gespart,
betrag_netto_gespart, mwst_bez, kategorie, waehrung, anz_coupon, anz_shopper_localty, menge_artikel) AS SELECT P.mandant_id
 ,
  CASE
  WHEN MA.mandant_id = 1
  THEN 'DE'
  ELSE MA.mandant_kbez
  END AS mandant_bez,
 P.bonuskauf_id,
 P.bon_dat AS einloesedatum,
 P.bon_dat AS einloesedatum_buchung,
 'unbekannt' AS gutschriftsdatum,
 P.wup_id AS filialnummer,
 W.buchungskreis_id AS buchungskreis,
 P.kl_art_id AS kaufland_artikel_nr,
 K.gtin_name AS artikelbezeichnung,
 OWG.owg_id AS owg_nr,
 WG.wg_id AS wg_nr,
  SUM(P.umsatz_promo_brutto) * -1 AS betrag_brutto_gezahlt,
 CAST(SUM(P.umsatz_promo_brutto / (100 + M.mwst) * 100) * -1 AS NUMERIC) AS betrag_netto_gezahlt,
  SUM(P.betrag_promo_brutto) * -1 AS betrag_brutto_gespart,
 CAST(SUM(P.betrag_promo_brutto / (100 + M.mwst) * 100) * -1 AS NUMERIC) AS betrag_netto_gespart,
    CAST(M.mwst AS STRING) || ' (' || TRIM(M.mwst_bez) || ')' AS mwst_bez,
 'unbekannt' AS kategorie,
 'EUR' AS waehrung,
  SUM(P.menge_promo) * -1 AS anz_coupon,
 COUNT(DISTINCT P.bon_id) AS anz_shopper_localty,
 SUM(V.menge) AS menge_artikel
FROM smp_production_data_shared_kfl.dbp_ods_ods_promotion_2 AS P
 INNER JOIN smp_production_data_shared_kfl.dbp_ods_ods_bon_verkauf_2 AS V ON P.bon_id = V.bon_id AND P.bon_zeile = V.bon_zeile
      AND P.kl_art_id = V.kl_art_id AND P.bon_dat = V.bon_dat
 INNER JOIN smp_production_data_shared_kfl.dbp_data_wup_2 AS W ON P.mandant_id = W.mandant_id AND P.wup_id = W.wup_id
 INNER JOIN smp_production_core_rel.t_gtin_2 AS K ON K.division_id = 'KFL' AND K.country_id = 'DE' AND TRIM(SUBSTR(CAST(V.ean_kasse AS STRING)
     , 1, 30)) = TRIM(K.gtin_id)
 INNER JOIN (SELECT mandant_id,
   kl_art_id,
   art_id
  FROM smp_production_data_shared_kfl.dbp_data_art_2
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, kl_art_id ORDER BY art_id DESC NULLS FIRST)) = 1) AS t0 ON P.mandant_id
    = t0.mandant_id AND P.kl_art_id = t0.kl_art_id /* ART_2, WG, (WUG_2) */
 INNER JOIN smp_production_data_shared_kfl.dbp_data_art_wg_zu_per_2 AS ARTWGZU ON P.mandant_id = ARTWGZU.mandant_id AND t0
     .art_id = ARTWGZU.art_id AND ARTWGZU.dat_bis = DATE '9999-12-31' AND ARTWGZU.arthiertyp_id = 2 /* WG, OWG, (ABT_2) */
   
 INNER JOIN smp_production_data_shared_kfl.dbp_data_wg_per_2 AS WG ON ARTWGZU.mandant_id = WG.mandant_id AND ARTWGZU.wg_id
      = WG.wg_id AND WG.dat_bis = DATE '9999-12-31' AND WG.arthiertyp_id = 2 /* OWG, HWG */
 INNER JOIN smp_production_data_shared_kfl.dbp_data_owg_per_2 AS OWG ON WG.mandant_id = OWG.mandant_id AND WG.owg_id = OWG
     .owg_id AND OWG.dat_bis = DATE '9999-12-31' AND OWG.arthiertyp_id = 2
 INNER JOIN smp_production_data_shared_kfl.dbp_data_mwst_per_2 AS M ON V.mandant_id = M.mandant_id AND V.mwst_id = M.mwst_id
     AND V.bon_dat BETWEEN M.dat_von AND M.dat_bis
 INNER JOIN smp_production_data_shared_kfl.dbp_data_mandant_2 AS MA ON P.mandant_id = MA.mandant_id
GROUP BY P.mandant_id,
 mandant_bez,
 P.bonuskauf_id,
 einloesedatum,
 einloesedatum_buchung,
 gutschriftsdatum,
 filialnummer,
 buchungskreis,
 kaufland_artikel_nr,
 artikelbezeichnung,
 owg_nr,
 wg_nr,
 mwst_bez,
 kategorie,
 waehrung;