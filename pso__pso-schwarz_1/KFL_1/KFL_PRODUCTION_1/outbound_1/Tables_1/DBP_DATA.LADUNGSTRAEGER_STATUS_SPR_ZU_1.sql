--==============================================================
-- Table: ladungstraeger_status_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ladungstraeger_status_spr_zu_1
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 07:40:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ladungstraeger_status_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel'),
ladungstraeger_status_id STRING(2) NOT NULL OPTIONS(description='Ladungsträger Status_1 ID     '),
ladungstraeger_status_bez STRING(60) OPTIONS(description='Ladungsträger Status_1 Bezeichnung   '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Ladungsträger Status_1 Bezeichnung');