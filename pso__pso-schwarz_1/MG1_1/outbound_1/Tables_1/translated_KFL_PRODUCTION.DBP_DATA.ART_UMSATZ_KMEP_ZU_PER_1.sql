CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_UMSATZ_KMEP_ZU_PER_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
ZEITRAUM_KZ STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichen für den Zeitraum (KM=Kalendermonat;WW=Werbewoche)'),
DAT_VON DATE NOT NULL OPTIONS(description='Umsatzzeitraum von-Wert'),
DAT_BIS DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL OPTIONS(description='Umsatzzeitraum bis-Wert'),
MENGE_ARTBEW_SUM NUMERIC(29,3) DEFAULT 0 NOT NULL
OPTIONS(description='Summe Menge der Artikelbewegung aus artbew_1 (kann in Stueck oder bei Gewichtsartikeln in KG sein)  für den entsprechenden Artikel_1 und Zeitraum. Anzahl der abverkauften Artikel_1 reduziert um zurückgegebene Artikel_1'),
BETRAG_KMEP NUMERIC(29,4)
OPTIONS(description='Errechneter Betrag für den K-MEP (Kaufland Markteinstandspreis) als Differenz von EK4N (resp. EK3N) zu EK2N * Umsatzmenge für den entsprechenden Umsatzzeitraum (dat_von - dat_bis).'),
BETRAG_KMEP_EINH NUMERIC(29,4) NOT NULL
OPTIONS(description='KMEP pro Einheit (Stueck, KG, etc.) - wird im Aggregat berechnet: betrag_kmep/menge_artbew_sum.'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
BETRAG_KMEP_EINH_O_FWU NUMERIC(29,4)
OPTIONS(description='KMEP (Kaufland-Markteinstandspreis) pro Einheit ohne Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen Vergleichswert ohne die Festwertumlage.'),
PRIMARY KEY (MANDANT_ID, ART_ID, DAT_VON) NOT ENFORCED
)
OPTIONS(description='WWC - Ergebnistabelle K-MEP (Kaufland Markteinstandspreis) - errechnet abhaengig vom Umsatzzeitraum die abhaengigen Boni inkl. Spanne');