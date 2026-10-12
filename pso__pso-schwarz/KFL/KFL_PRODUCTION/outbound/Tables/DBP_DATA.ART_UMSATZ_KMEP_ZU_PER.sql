--==============================================================
-- Table: art_umsatz_kmep_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_umsatz_kmep_zu_per
   generated from Powerdesigner on Mittwoch, 7. Dezember 2022 21:42:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_umsatz_kmep_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
zeitraum_kz STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichen für den Zeitraum (KM=Kalendermonat;WW=Werbewoche)'),
dat_von DATE NOT NULL OPTIONS(description='Umsatzzeitraum von-Wert'),
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL OPTIONS(description='Umsatzzeitraum bis-Wert'),
menge_artbew_sum BIGNUMERIC(38,3) DEFAULT 0 NOT NULL
OPTIONS(description='Summe Menge der Artikelbewegung aus artbew (kann in Stueck oder bei Gewichtsartikeln in KG sein)  für den entsprechenden Artikel und Zeitraum. Anzahl der abverkauften Artikel reduziert um zurückgegebene Artikel'),
betrag_kmep BIGNUMERIC(38,4)
OPTIONS(description='Errechneter Betrag für den K-MEP (Kaufland Markteinstandspreis) als Differenz von EK4N (resp. EK3N) zu EK2N * Umsatzmenge für den entsprechenden Umsatzzeitraum (dat_von - dat_bis).'),
betrag_kmep_einh BIGNUMERIC(38,4) NOT NULL
OPTIONS(description='KMEP pro Einheit (Stueck, KG, etc.) - wird im Aggregat berechnet: betrag_kmep/menge_artbew_sum.'),
betrag_kmep_einh_o_fwu BIGNUMERIC(38,4)
OPTIONS(description='KMEP (Kaufland-Markteinstandspreis) pro Einheit ohne Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen Vergleichswert ohne die Festwertumlage.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, dat_von) NOT ENFORCED
)
OPTIONS(description='WWC - Ergebnistabelle K-MEP (Kaufland Markteinstandspreis) - errechnet abhaengig vom Umsatzzeitraum die abhaengigen Boni inkl. Spanne');