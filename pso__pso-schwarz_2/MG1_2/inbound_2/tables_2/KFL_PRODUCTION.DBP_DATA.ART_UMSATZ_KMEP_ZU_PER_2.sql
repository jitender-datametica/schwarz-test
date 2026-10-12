create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_UMSATZ_KMEP_ZU_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	ZEITRAUM_KZ VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen für den Zeitraum (KM=Kalendermonat;WW=Werbewoche)',
	DAT_VON DATE NOT NULL COMMENT 'Umsatzzeitraum von-Wert',
	DAT_BIS DATE NOT NULL DEFAULT CAST('9999-12-31' AS DATE) COMMENT 'Umsatzzeitraum bis-Wert',
	MENGE_ARTBEW_SUM NUMBER(38,3) NOT NULL DEFAULT 0 COMMENT 'Summe Menge der Artikelbewegung aus artbew_2 (kann in Stueck oder bei Gewichtsartikeln in KG sein)  für den entsprechenden Artikel_2 und Zeitraum. Anzahl der abverkauften Artikel_2 reduziert um zurückgegebene Artikel_2',
	BETRAG_KMEP NUMBER(38,4) WITH MASKING POLICY #unknown_policy COMMENT 'Errechneter Betrag für den K-MEP (Kaufland Markteinstandspreis) als Differenz von EK4N (resp. EK3N) zu EK2N * Umsatzmenge für den entsprechenden Umsatzzeitraum (dat_von - dat_bis).',
	BETRAG_KMEP_EINH NUMBER(38,4) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'KMEP pro Einheit (Stueck, KG, etc.) - wird im Aggregat berechnet: betrag_kmep/menge_artbew_sum.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	WRG_ID VARCHAR(3) COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
	BETRAG_KMEP_EINH_O_FWU NUMBER(38,4) WITH MASKING POLICY #unknown_policy COMMENT 'KMEP (Kaufland-Markteinstandspreis) pro Einheit ohne Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen Vergleichswert ohne die Festwertumlage.',
	constraint PK_ART_UMSATZ_KMEP_ZU_PER primary key (MANDANT_ID, ART_ID, ZEITRAUM_KZ, DAT_VON)
)COMMENT='WWC - Ergebnistabelle K-MEP (Kaufland Markteinstandspreis) - errechnet abhaengig vom Umsatzzeitraum die abhaengigen Boni inkl. Spanne'
;