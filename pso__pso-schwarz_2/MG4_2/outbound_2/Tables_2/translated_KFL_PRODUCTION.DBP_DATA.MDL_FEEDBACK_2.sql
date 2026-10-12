CREATE OR REPLACE TABLE kfl_production_dbp_data.mdl_feedback_2 (
feedback_id STRING(300) NOT NULL OPTIONS(description='Feedback ID aus Medallia'),
frage_id INTEGER NOT NULL OPTIONS(description='Frage ID aus Medallia'),
antwort_id INTEGER NOT NULL OPTIONS(description='Antwort ID aus Medallia'),
dat_feedback DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Datum an dem das Feedback gesendet wurde'),
dat_einkauf DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Datum, zu dem der Kunde einkaufen war/Datum des Einkaufs'),
zeitspanne_einkauf_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='ID der Zeitspanne/Einkaufszeit'),
mandant_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Mandant_2 im DWH'),
gf_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Geschäftsführer ID, numerisch'),
wup_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
de_wup_load_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnet deutsche Hauptfragen die zusätzlich auf Filial-Ebene geladen werden'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='KMR - Medallia - Zentrale Faktentabelle Kunden-Feedback');