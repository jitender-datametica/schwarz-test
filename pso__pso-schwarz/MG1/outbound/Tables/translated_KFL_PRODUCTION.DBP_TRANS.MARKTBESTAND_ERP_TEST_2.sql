DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_TRANS.MARKTBESTAND_ERP_TEST_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_TRANS.MARKTBESTAND_ERP_TEST_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
BESTAND_ID INTEGER NOT NULL OPTIONS(description='Eindeutiger Schluessel zur Referenztabelle'),
BEZUGSWEG_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
RELEVANT_FG INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='das Flag legt fest, ob der Datensatz für die Fehlmengenauswertung relevant ist. Wird in der Versorgung aus Listung, Dispomerkmal dismm und kdis gebildet'),
MENGE_LGBEST_ERP_FREI_BME NUMERIC(18,3) NOT NULL OPTIONS(description='Bewerteter, frei verwendbarer Bestand aus labst'),
MENGE_LGBEST_ERP_QUAL_BME NUMERIC(18,3) NOT NULL
OPTIONS(description='Qualitaetspruefbestand: Menge, die sich in der Qualitaetspruefung befindet. Sie ist Teilmenge des gesamten bewerteten Bestands und ist nicht frei verwendbar.Aus insme'),
FORTSCHREIBUNG_FG INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag zur Identifizierung, ob der Datensatz orginaer aus SAP kommt (=0) oder fortgeschrieben wird (=1). Für Migrationsdatensaetze wird der Default -1 gesetzt.'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
MENGE_LGBEST_ERP_GESP_BME NUMERIC(18,3)
OPTIONS(description='Menge Gesperrter Bestand - Teilmenge des gesamten bewerteten Bestands, die nicht verwendert werden soll und nicht als frei verwendbar gilt. Die Gruende, aus denen ein Bestand in den gesperrten Bestand gebucht wird, sind individuell bestimmbar.')
) CLUSTER BY MANDANT_ID, DAT;