CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sb_schwellwert_wtag_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wtag_id BIGNUMERIC(38,0) NOT NULL,
vertrieb_fg BIGNUMERIC(38,0) NOT NULL,
sw_rot_bis NUMERIC(9,2) NOT NULL,
sw_gelb_bis NUMERIC(9,2) NOT NULL,
sw_gelb_ab NUMERIC(9,2) NOT NULL,
sw_rot_ab NUMERIC(9,2) NOT NULL,
sw_soll NUMERIC(9,2) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);