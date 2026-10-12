--==============================================================
-- Table: geku_beschw_antw
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_beschw_antw
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_beschw_antw (
beschwerde_antwort_id INTEGER NOT NULL
OPTIONS(description='Eindeutige ID einer Beschwerdeantwort aus complaint_answer_uid'),
geku_massnahme_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID einer GeKu-Massnahme aus measure_uid'),
berechtigt_fg BIGNUMERIC(38,0) OPTIONS(description='Berechtigt=1 / Unberechtigt=0, aus answer_qualified'),
avg_fg BIGNUMERIC(38,0) OPTIONS(description='AVG ja = 1, nein = 0            '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (beschwerde_antwort_id) NOT ENFORCED
) OPTIONS(description='GEKU - Tabelle Beschwerde-Antwort aus s1_dwh_complaint_answer');