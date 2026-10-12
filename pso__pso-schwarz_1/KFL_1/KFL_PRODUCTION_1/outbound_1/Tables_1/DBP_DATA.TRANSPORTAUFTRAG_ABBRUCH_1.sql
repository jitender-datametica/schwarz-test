CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportauftrag_abbruch_1 (
transport_beleg_id INTEGER NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
abbr_pos_id BIGNUMERIC(38,0) NOT NULL,
dat_abbr DATE NOT NULL,
zeit_abbr BIGNUMERIC(38,0) NOT NULL,
ebene_wechsel_fg BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);