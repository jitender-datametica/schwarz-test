CREATE OR REPLACE TABLE kfl_production_dbp_data.l_nachhaltigkeitslogo_1 (
nachhaltigkeitslogo_id INTEGER NOT NULL OPTIONS(description='Id des Nachhaltigkeitslogos (bspw. Blauer Engel)'),
nachhaltigkeitslogo_bez STRING(50) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Nachhaltigkeitslogos (bspw. Blauer Engel)'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
logo_kzstg STRING(3) DEFAULT '' NOT NULL OPTIONS(description='Nachhaltigkeitslogo SAP'),
PRIMARY KEY (nachhaltigkeitslogo_id, logo_kzstg) NOT ENFORCED
) OPTIONS(description='AIS - Lookup für Nachhaltigkeitslogos. Initialbeladung durch DWH.');