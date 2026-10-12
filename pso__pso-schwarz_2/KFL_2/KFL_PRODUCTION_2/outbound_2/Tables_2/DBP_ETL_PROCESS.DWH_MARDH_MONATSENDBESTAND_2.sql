DROP TABLE IF EXISTS kfl_production_dbp_etl_process.dwh_mardh_monatsendbestand_2;
CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.dwh_mardh_monatsendbestand_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
bestand_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutiger Schluessel zur Referenztabelle'),
bezugsweg_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel_2 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
relevant_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL
OPTIONS(description='das Flag legt fest, ob der Datensatz für die Fehlmengenauswertung relevant ist. Wird in der Versorgung aus Listung, Dispomerkmal dismm und kdis gebildet'),
menge_lgbest_erp_frei_bme NUMERIC(18,3) NOT NULL OPTIONS(description='Bewerteter, frei verwendbarer Bestand aus labst'),
menge_lgbest_erp_qual_bme NUMERIC(18,3) NOT NULL
OPTIONS(description='Qualitaetspruefbestand: Menge, die sich in der Qualitaetspruefung befindet. Sie ist Teilmenge des gesamten bewerteten Bestands und ist nicht frei verwendbar.Aus insme'),
fortschreibung_fg BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Flag zur Identifizierung, ob der Datensatz orginaer aus SAP kommt (=0) oder fortgeschrieben wird (=1). Für Migrationsdatensaetze wird der Default -1 gesetzt.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
menge_lgbest_erp_gesp_bme NUMERIC(18,3)
OPTIONS(description='Menge Gesperrter Bestand - Teilmenge des gesamten bewerteten Bestands, die nicht verwendert werden soll und nicht als frei verwendbar gilt. Die Gruende, aus denen ein Bestand in den gesperrten Bestand gebucht wird, sind individuell bestimmbar.')
) CLUSTER BY mandant_id, dat;