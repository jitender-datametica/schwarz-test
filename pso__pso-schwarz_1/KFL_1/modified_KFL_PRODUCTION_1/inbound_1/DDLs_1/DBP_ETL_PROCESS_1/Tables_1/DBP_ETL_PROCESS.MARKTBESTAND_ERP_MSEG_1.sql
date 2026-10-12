create or replace TABLE MARKTBESTAND_ERP_MSEG_1 cluster by (MANDANT_ID, DAT)(
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	ART_ID INTEGER NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	WUP_ID INTEGER NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID INTEGER NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT',
	BESTAND_ID INTEGER NOT NULL COMMENT 'Eindeutiger Schluessel zur Referenztabelle',
	BEZUGSWEG_ID INTEGER NOT NULL DEFAULT -1 COMMENT 'Kennzeichnet, ob der Artikel_1 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)',
	RELEVANT_FG INTEGER NOT NULL DEFAULT 1 COMMENT 'das Flag legt fest, ob der Datensatz für die Fehlmengenauswertung relevant ist. Wird in der Versorgung aus Listung, Dispomerkmal dismm und kdis gebildet',
	MENGE_LGBEST_ERP_FREI_BME NUMBER(29,3) NOT NULL COMMENT 'Bewerteter, frei verwendbarer Bestand aus labst',
	MENGE_LGBEST_ERP_QUAL_BME NUMBER(29,3) NOT NULL COMMENT 'Qualitaetspruefbestand: Menge, die sich in der Qualitaetspruefung befindet. Sie ist Teilmenge des gesamten bewerteten Bestands und ist nicht frei verwendbar.Aus insme',
	FORTSCHREIBUNG_FG INTEGER NOT NULL DEFAULT -1 COMMENT 'Flag zur Identifizierung, ob der Datensatz orginaer aus SAP kommt (=0) oder fortgeschrieben wird (=1). Für Migrationsdatensaetze wird der Default -1 gesetzt.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	MENGE_LGBEST_ERP_GESP_BME NUMBER(29,3) COMMENT 'Menge Gesperrter Bestand - Teilmenge des gesamten bewerteten Bestands, die nicht verwendert werden soll und nicht als frei verwendbar gilt. Die Gruende, aus denen ein Bestand in den gesperrten Bestand gebucht wird, sind individuell bestimmbar.'
);