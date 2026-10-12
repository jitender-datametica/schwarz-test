--==============================================================
-- Table: l_nachhaltigkeitslogo_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_nachhaltigkeitslogo_2
   generated from Powerdesigner on Thursday, March 17, 2022 2:37:32 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_nachhaltigkeitslogo_2 (
nachhaltigkeitslogo_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id des Nachhaltigkeitslogos (bspw. Blauer Engel)'),
logo_kzstg STRING(3) DEFAULT '' NOT NULL OPTIONS(description='Nachhaltigkeitslogo SAP'),
nachhaltigkeitslogo_bez STRING(50) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Nachhaltigkeitslogos (bspw. Blauer Engel)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (nachhaltigkeitslogo_id, logo_kzstg) NOT ENFORCED
) OPTIONS(description='AIS - Lookup für Nachhaltigkeitslogos. Initialbeladung durch DWH.');