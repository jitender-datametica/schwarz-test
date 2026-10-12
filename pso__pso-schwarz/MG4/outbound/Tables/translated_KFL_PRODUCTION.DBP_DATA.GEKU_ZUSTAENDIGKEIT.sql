CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_zustaendigkeit (
kundenfaktor_id INTEGER NOT NULL OPTIONS(description='eindeutige ID des Kundenfaktors, aktuell zwischen 1 und 27'),
geku_dwh_artikel_id INTEGER NOT NULL
OPTIONS(description='Eine weitere ID, die Vergleichbarkeit der Artikel über alle Länder ermöglichen soll'),
zustaendigkeit STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Die Zuständigkeit kann beim Markt, beim Fachbereich oder bei beiden liegen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (kundenfaktor_id, geku_dwh_artikel_id) NOT ENFORCED
) OPTIONS(description='GEKU - Zuordnungstabelle der geku_dwh_artikel zum Kundenfaktor');