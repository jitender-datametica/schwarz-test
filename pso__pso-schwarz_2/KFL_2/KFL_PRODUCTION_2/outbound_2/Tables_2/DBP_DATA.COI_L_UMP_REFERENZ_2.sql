--==============================================================
-- Table: coi_l_ump_referenz_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_l_ump_referenz_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.coi_l_ump_referenz_2 (
referenzgrund_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die ID für den Grund warum eine_2 Referenzfiliale herangezogen wurde'),
referenzgrund_bez STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des Grundes warum eine_2 Referenzfiliale herangezogen wurde'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (referenzgrund_id) NOT ENFORCED
)
OPTIONS(description='Lookup Tabelle für die Referenzgründe die als Dropdown-Feld in der Uploadexel vom Fachbereich ausgewählt werden können, warum an gewissen Stellen eine_2 Referenzfiliale ausgewählt wird');