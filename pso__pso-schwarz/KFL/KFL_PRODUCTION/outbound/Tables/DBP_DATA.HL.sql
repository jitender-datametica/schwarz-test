--==============================================================
-- Table: hl
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hl
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hl (
hl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Hausleiter ID entspricht der Mitarbeiter ID            '),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
hl_name STRING(40) COLLATE 'und:ci'
OPTIONS(description='Name des Hausleiters, i.d.R. bestehend aus Anrede, Vor- und Zuname (Herr Hans Mustermann)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (hl_id, mandant_id) NOT ENFORCED
) OPTIONS(description='VIS - Lookup Tabelle der Hausleiter');