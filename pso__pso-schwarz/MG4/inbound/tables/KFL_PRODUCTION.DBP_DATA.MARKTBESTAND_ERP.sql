create or replace TABLE KFL_PRODUCTION.DBP_DATA.MARKTBESTAND_ERP cluster by (
     MANDANT_ID,
     DAT 
)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
	BESTAND_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutiger Schluessel zur Referenztabelle',
	BEZUGSWEG_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)',
	RELEVANT_FG NUMBER(38,0) NOT NULL DEFAULT 1 COMMENT 'das Flag legt fest, ob der Datensatz für die Fehlmengenauswertung relevant ist. Wird in der Versorgung aus Listung, Dispomerkmal dismm und kdis gebildet',
	MENGE_LGBEST_ERP_FREI_BME NUMBER(18,3) NOT NULL COMMENT 'Bewerteter, frei verwendbarer Bestand aus labst',
	MENGE_LGBEST_ERP_QUAL_BME NUMBER(18,3) NOT NULL COMMENT 'Qualitaetspruefbestand: Menge, die sich in der Qualitaetspruefung befindet. Sie ist Teilmenge des gesamten bewerteten Bestands und ist nicht frei verwendbar.Aus insme',
	FORTSCHREIBUNG_FG NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Flag zur Identifizierung, ob der Datensatz orginaer aus SAP kommt (=0) oder fortgeschrieben wird (=1). Für Migrationsdatensaetze wird der Default -1 gesetzt.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	MENGE_LGBEST_ERP_GESP_BME NUMBER(18,3) COMMENT 'Menge Gesperrter Bestand - Teilmenge des gesamten bewerteten Bestands, die nicht verwendert werden soll und nicht als frei verwendbar gilt. Die Gruende, aus denen ein Bestand in den gesperrten Bestand gebucht wird, sind individuell bestimmbar.',
	constraint PK_MARKTBESTAND_ERP primary key (MANDANT_ID, ART_ID, WUP_ID, NB_ID, DAT)
)COMMENT='AIS - Hier ist der Artikelstatus inkl. Schluessel zur Referenztabelle (Mengen & Preise) pro Artikel, Markt und Tag hinterlegt. Quelle SAP MARD - MULTISET'
;