create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ART_UMSATZ_KMEP_ZU_PER_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	ART_ID COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	ZEITRAUM_KZ COMMENT 'Kennzeichen für den Zeitraum (KM=Kalendermonat;WW=Werbewoche)',
	DAT_VON COMMENT 'Umsatzzeitraum von-Wert',
	DAT_BIS COMMENT 'Umsatzzeitraum bis-Wert',
	MENGE_ARTBEW_SUM COMMENT 'Summe Menge der Artikelbewegung aus artbew_1 (kann in Stueck oder bei Gewichtsartikeln in KG sein)  für den entsprechenden Artikel_1 und Zeitraum. Anzahl der abverkauften Artikel_1 reduziert um zurückgegebene Artikel_1',
	BETRAG_KMEP COMMENT 'Errechneter Betrag für den K-MEP (Kaufland Markteinstandspreis) als Differenz von EK4N (resp. EK3N) zu EK2N * Umsatzmenge für den entsprechenden Umsatzzeitraum (dat_von - dat_bis).',
	BETRAG_KMEP_EINH COMMENT 'KMEP pro Einheit (Stueck, KG, etc.) - wird im Aggregat berechnet: betrag_kmep/menge_artbew_sum.',
	BETRAG_KMEP_EINH_O_FWU COMMENT 'KMEP (Kaufland-Markteinstandspreis) pro Einheit ohne Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen Vergleichswert ohne die Festwertumlage.',
	WRG_ID COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
	BETRAG_KMEP_EINH_INV COMMENT 'KMEP pro Einheit (Stueck, KG, etc.) - wird im Aggregat berechnet: betrag_kmep/menge_lagerbew_bme (aus lagerbew_det_1). Nur für Inventur_1 Differenz Buchungen -  KMO  lager_bewart_id (aus lagerbew_det_1)in (701,702,711,712,741,742).',
	BETRAG_KMEP_EINH_ABSCHRIFT COMMENT 'KMEP pro Einheit (Stueck, KG, etc.) - wird im Aggregat berechnet: betrag_kmep/menge_lagerbew_bme ( aus lagerbew_det_1). Nur für Abschriften_1 Buchungen -  KMO lager_bewart_id (aus lagerbew_det_1) in (901,902,905,906,917,918,919,920,921,922,933,934,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988,991,993,994).'
) as 
    SELECT 
        mandant_id,
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

FROM DBP_DATA.ART_UMSATZ_KMEP_ZU_PER_1 ;
