--==============================================================
-- Table: einh_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: einh_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.einh_spr_zu (
einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Masseinheit aus der Spalte msehi, zum Beispiel  %'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
einh_bez_kaufm STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='externe Masseinheit kaufmaännische Darstellung aus mseh3'),
einh_bez STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kurztext der Masseinheiten Bezeichnung aus mseht (z.Bsp. Prozent)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='AIS - Sprachabhängige Bezeichnungen der Einheiten (für Einkauf) aus t006a');