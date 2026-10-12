--==============================================================
-- Table: marktbestand_erp
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: marktbestand_erp
   generated from Powerdesigner on Mittwoch, 28. September 2022 17:28:43
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MARKTBESTAND_ERP CLUSTER BY (
     MANDANT_ID,
     DAT 
)(
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   art_id                              INTEGER    NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE            NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
   bestand_id                          INTEGER    NOT NULL COMMENT 'Eindeutiger Schluessel zur Referenztabelle',
   bezugsweg_id                        INTEGER    DEFAULT -1 NOT NULL COMMENT 'Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)',
   relevant_fg                         INTEGER    DEFAULT 1 NOT NULL COMMENT 'das Flag legt fest, ob der Datensatz für die Fehlmengenauswertung relevant ist. Wird in der Versorgung aus Listung, Dispomerkmal dismm und kdis gebildet',
   menge_lgbest_erp_frei_bme           NUMBER(29,3)    NOT NULL COMMENT 'Bewerteter, frei verwendbarer Bestand aus labst',
   menge_lgbest_erp_qual_bme           NUMBER(29,3)    NOT NULL COMMENT 'Qualitaetspruefbestand: Menge, die sich in der Qualitaetspruefung befindet. Sie ist Teilmenge des gesamten bewerteten Bestands und ist nicht frei verwendbar.Aus insme',
   menge_lgbest_erp_gesp_bme           NUMBER(29,3)    COMMENT 'Menge Gesperrter Bestand - Teilmenge des gesamten bewerteten Bestands, die nicht verwendert werden soll und nicht als frei verwendbar gilt. Die Gruende, aus denen ein Bestand in den gesperrten Bestand gebucht wird, sind individuell bestimmbar.',
   fortschreibung_fg                   INTEGER    DEFAULT -1 NOT NULL COMMENT 'Flag zur Identifizierung, ob der Datensatz orginaer aus SAP kommt (=0) oder fortgeschrieben wird (=1). Für Migrationsdatensaetze wird der Default -1 gesetzt.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MARKTBESTAND_ERP PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, dat) NOT ENFORCED
)  COMMENT = 'AIS - Hier ist der Artikelstatus inkl. Schluessel zur Referenztabelle (Mengen & Preise) pro Artikel, Markt und Tag hinterlegt. Quelle SAP MARD - MULTISET';
