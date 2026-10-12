CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vorgangsart_wewa_gruppe_zu (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
vorgangsart_id STRING(2) COLLATE 'und:ci' NOT NULL,
wewa_gruppe_id BIGNUMERIC(38,0) NOT NULL,
open_fg BIGNUMERIC(38,0),
gemeldet_fg BIGNUMERIC(38,0),
teilgebucht_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);