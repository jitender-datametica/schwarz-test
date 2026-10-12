--==============================================================
-- Table: ruecksendung_status_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ruecksendung_status_spr_zu_2
   generated from Powerdesigner on Freitag, 22. November 2024 11:03:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ruecksendung_status_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ruecksendung_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Status_2 ID der Rücklieferung.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache im DWH'),
ruecksendung_status_bez STRING(100) NOT NULL
OPTIONS(description='Status_2 Bezeichnung der Rücklieferung in verschiedenen Sprachen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, ruecksendung_status_id, spr_id) NOT ENFORCED
) OPTIONS(description='Sprachabhängige Bezeichnung für den Status_2 der Rücksendung');