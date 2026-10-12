CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_frage (
amx_frage_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID einer Frage (Handlung) aus dem Quellfeld guideline.id'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
pruef_kapitel_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Pruef-Kapitels. Aus dem Quellfeld id'),
antwort_wert INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Beantwortung der Frage aus Quellfeld numeric_result'),
amx_frage_katalog_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID einer Frage aus dem Fragenkatalog aus der Quelle guideline.abstract_guideline_id.'),
anmerkung STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Anmerkung aus dem Quellfeld work_description'),
eingabe STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Eingabe aus dem Quellfeld enter_result'),
anz_fehler_amx INTEGER OPTIONS(description='Anzahl Fehler aus dem Quellfeld count_errors'),
stichprobe_umfang INTEGER OPTIONS(description='Stichprobenumfang aus dem Quellfeld audited_amount'),
frage_gewichtung INTEGER OPTIONS(description='Gewichtung der Fragen für die Berechnung des Endergebnisses'),
antwort_wert_text STRING(60) COLLATE 'und:ci'
OPTIONS(description='Textuelle Darstellung des nummerischen Feldes antwort_wert'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_frage_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='VIS audimex - Die Tabelle amx_frage enthält die Fragen (Handlungen) der Prüfprogramme. Aus der Quelle audimex.guideline');