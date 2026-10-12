--==============================================================
-- Table: art_umsatz_kmep_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_umsatz_kmep_zu_per_1
   generated from Powerdesigner on Mittwoch, 7. Dezember 2022 21:42:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_UMSATZ_KMEP_ZU_PER_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   art_id                              INTEGER    NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   zeitraum_kz                         VARCHAR(2)      COLLATE 'en-ci' NOT NULL COMMENT 'Kennzeichen für den Zeitraum (KM=Kalendermonat;WW=Werbewoche)',
   dat_von                             DATE            NOT NULL COMMENT 'Umsatzzeitraum von-Wert',
   dat_bis                             DATE            DEFAULT CAST('9999-12-31' AS DATE) NOT NULL COMMENT 'Umsatzzeitraum bis-Wert',
   menge_artbew_sum                    NUMBER(29,3)    DEFAULT 0 NOT NULL COMMENT 'Summe Menge der Artikelbewegung aus artbew_1 (kann in Stueck oder bei Gewichtsartikeln in KG sein)  für den entsprechenden Artikel_1 und Zeitraum. Anzahl der abverkauften Artikel_1 reduziert um zurückgegebene Artikel_1',
   betrag_kmep                         NUMBER(29,4)    COMMENT 'Errechneter Betrag für den K-MEP (Kaufland Markteinstandspreis) als Differenz von EK4N (resp. EK3N) zu EK2N * Umsatzmenge für den entsprechenden Umsatzzeitraum (dat_von - dat_bis).',
   betrag_kmep_einh                    NUMBER(29,4)    NOT NULL COMMENT 'KMEP pro Einheit (Stueck, KG, etc.) - wird im Aggregat berechnet: betrag_kmep/menge_artbew_sum.',
   betrag_kmep_einh_o_fwu              NUMBER(29,4)    COMMENT 'KMEP (Kaufland-Markteinstandspreis) pro Einheit ohne Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen Vergleichswert ohne die Festwertumlage.',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_UMSATZ_KMEP_ZU_PER PRIMARY KEY (mandant_id, art_id, zeitraum_kz, dat_von) NOT ENFORCED
)  COMMENT = 'WWC - Ergebnistabelle K-MEP (Kaufland Markteinstandspreis) - errechnet abhaengig vom Umsatzzeitraum die abhaengigen Boni inkl. Spanne';
