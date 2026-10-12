CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_beschw_antw_1 (
beschwerde_antwort_id INTEGER NOT NULL
OPTIONS(description='Eindeutige ID einer Beschwerdeantwort aus complaint_answer_uid'),
geku_massnahme_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID einer GeKu-Massnahme aus measure_uid'),
berechtigt_fg INTEGER OPTIONS(description='Berechtigt=1 / Unberechtigt=0, aus answer_qualified'),
avg_fg INTEGER OPTIONS(description='AVG ja = 1, nein = 0\n            '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (beschwerde_antwort_id) NOT ENFORCED
) OPTIONS(description='GEKU - Tabelle Beschwerde-Antwort aus s1_dwh_complaint_answer');