CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_umsatz_kmep_zu_per (mandant_id
OPTIONS(description='Mandant im DWH'), art_id
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
zeitraum_kz OPTIONS(description='Kennzeichen für den Zeitraum (KM=Kalendermonat;WW=Werbewoche)'), dat_von
OPTIONS(description='Umsatzzeitraum von-Wert'), dat_bis OPTIONS(description='Umsatzzeitraum bis-Wert'), menge_artbew_sum
OPTIONS(description='Summe Menge der Artikelbewegung aus artbew (kann in Stueck oder bei Gewichtsartikeln in KG sein)  für den entsprechenden Artikel und Zeitraum. Anzahl der abverkauften Artikel reduziert um zurückgegebene Artikel'),
betrag_kmep
OPTIONS(description='Errechneter Betrag für den K-MEP (Kaufland Markteinstandspreis) als Differenz von EK4N (resp. EK3N) zu EK2N * Umsatzmenge für den entsprechenden Umsatzzeitraum (dat_von - dat_bis).'),
betrag_kmep_einh
OPTIONS(description='KMEP pro Einheit (Stueck, KG, etc.) - wird im Aggregat berechnet: betrag_kmep/menge_artbew_sum.'),
betrag_kmep_einh_o_fwu
OPTIONS(description='KMEP (Kaufland-Markteinstandspreis) pro Einheit ohne Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen Vergleichswert ohne die Festwertumlage.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'), betrag_kmep_einh_inv
OPTIONS(description='KMEP pro Einheit (Stueck, KG, etc.) - wird im Aggregat berechnet: betrag_kmep/menge_lagerbew_bme (aus lagerbew_det). Nur für Inventur Differenz Buchungen -  KMO  lager_bewart_id (aus lagerbew_det)in (701,702,711,712,741,742).'),
betrag_kmep_einh_abschrift
OPTIONS(description='KMEP pro Einheit (Stueck, KG, etc.) - wird im Aggregat berechnet: betrag_kmep/menge_lagerbew_bme ( aus lagerbew_det). Nur für Abschriften Buchungen -  KMO lager_bewart_id (aus lagerbew_det) in (901,902,905,906,917,918,919,920,921,922,933,934,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988,991,993,994).'))
AS SELECT mandant_id,
 art_id,
 zeitraum_kz,
 dat_von,
 dat_bis,
 menge_artbew_sum,
 betrag_kmep,
 betrag_kmep_einh,
 betrag_kmep_einh_o_fwu,
 wrg_id,
 betrag_kmep_einh_inv,
 betrag_kmep_einh_abschrift
FROM kfl_production_dbp_data.art_umsatz_kmep_zu_per;