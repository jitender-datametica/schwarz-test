CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_rauchverlust (
mandant_id BIGNUMERIC(38,0) NOT NULL,
werk_id BIGNUMERIC(38,0) NOT NULL,
dat_rauchvorgang DATE NOT NULL,
zeit_rauchvorgang TIME NOT NULL,
flw_art_id BIGNUMERIC(38,0) NOT NULL,
flw_arbeitsplatz1_id STRING(8) COLLATE 'und:ci' NOT NULL,
transport_einheit_id INTEGER DEFAULT - 1 NOT NULL,
flw_tenum_rauchprozess_kennzeichen STRING(3) COLLATE 'und:ci' NOT NULL,
rauchwagen_id STRING(10) COLLATE 'und:ci' DEFAULT '-1' NOT NULL,
nettogew_in NUMERIC(18,3),
nettogew_out NUMERIC(18,3),
basismenge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
nettogew_diff_in_out NUMERIC(10,3),
td_update TIMESTAMP,
td_insert TIMESTAMP
);