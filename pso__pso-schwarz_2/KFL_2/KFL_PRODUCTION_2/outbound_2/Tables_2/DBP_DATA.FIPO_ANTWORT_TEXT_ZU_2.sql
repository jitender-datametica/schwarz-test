--==============================================================
-- Table: fipo_antwort_text_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_antwort_text_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_antwort_text_zu_2 (
fipo_antwort_text_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID der Zuordnung'),
fipo_antwort_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Eindeutige ID einer Antwort aus ant_id'),
fipo_standard_text_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Standardtextes aus ste_id'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_antwort_text_id) NOT ENFORCED
) OPTIONS(description='FIPO - Zuordnungstabelle von Texten zu Antworten aus der Quelltabelle antworten_texte');