CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mdl_frage_antwort_zu_1 (
frage_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Frage ID aus Medallia'),
antwort_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Antwort ID aus Medallia'),
nok_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Manuell gepflegtes Feld, sagt aus, ob Antwort einer Frage ohne (0) oder mit (1) Feststellung ist. Default ist ohne Feststellung'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='KMR - Medallia - Zuordnungstabelle von Frage zu Antwort; welche Antwortmöglichkeiten gibt es bei einer Frage');