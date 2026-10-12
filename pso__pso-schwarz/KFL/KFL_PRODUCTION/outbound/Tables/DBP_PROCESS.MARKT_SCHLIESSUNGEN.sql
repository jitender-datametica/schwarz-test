CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.markt_schliessungen (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
orga STRING(10) COLLATE 'und:ci',
anlass BIGNUMERIC(38,0),
dat DATE,
td_update TIMESTAMP,
td_insert TIMESTAMP
);