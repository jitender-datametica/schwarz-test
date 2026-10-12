DROP TABLE IF EXISTS kfl_production_dbp_ods.ods_talon_2;
CREATE OR REPLACE TABLE kfl_production_dbp_ods.ods_talon_2 (
mandant_id INTEGER NOT NULL,
talon_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
talon_dat DATE NOT NULL,
talon_booking DATETIME NOT NULL,
talon_bon_fg INTEGER DEFAULT 0 NOT NULL,
talon_delta_status_bitfeld INTEGER DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
) CLUSTER BY mandant_id, wup_id;