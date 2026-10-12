CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_buchungsstatus_ker_1 (
kj_ker_mo_id BIGNUMERIC(38,0) NOT NULL,
akt_buchungs_schluss BIGNUMERIC(38,0) NOT NULL,
akt_gj_buchungs_schluss BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
akt_fruehinfo1 BIGNUMERIC(38,0) NOT NULL,
akt_fruehinfo2 BIGNUMERIC(38,0) NOT NULL,
buchungs_schluss_akt BIGNUMERIC(38,0),
buchungs_schluss_vm BIGNUMERIC(38,0),
buchungs_schluss_vvm BIGNUMERIC(38,0),
dat_fruehinfo1 DATE,
dat_fruehinfo2 DATE,
dat_buchungs_schluss DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);