CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.leist_einzelauswertung_wup_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
leist_einzelauswertung_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);