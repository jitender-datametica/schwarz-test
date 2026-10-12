CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_de_frage_1 (
amx_frage_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID einer Frage (Handlung) aus dem Quellfeld guideline.id'),
pruef_kapitel_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Prüf Kapitels'),
antwort_wert INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Beantwortung der Frage aus dem Quellfeld numeric_result'),
amx_frage_katalog_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Eindeutige ID einer Frage aus dem Fragenkatalog'),
anmerkung STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Anmerkung aus dem Quellfeld work_description'),
eingabe STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Eingabe aus dem Quellfeld enter_result'),
anz_fehler_amx INTEGER OPTIONS(description='Anzahl Fehler'),
stichprobe_umfang INTEGER OPTIONS(description='Stichprobenumfang'),
frage_gewichtung INTEGER OPTIONS(description='Gewichtung der Frage für die Berechnung des Endergebnisses'),
antwort_wert_text STRING(60) COLLATE 'und:ci' OPTIONS(description='Textuelle Darstellung des Felder antwort_wert'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_frage_id) NOT ENFORCED
) OPTIONS(description='KMR - Audimex. Enthält die Fragen der Prüfprogramme für Kurzcheck DE Daten');