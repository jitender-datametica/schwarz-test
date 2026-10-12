CREATE OR REPLACE TABLE kfl_production_dbp_data.l_buchungsstatus_ker (
kj_ker_mo_id INTEGER NOT NULL,
akt_buchungs_schluss INTEGER NOT NULL,
akt_gj_buchungs_schluss INTEGER DEFAULT 0 NOT NULL,
akt_fruehinfo1 INTEGER NOT NULL,
akt_fruehinfo2 INTEGER NOT NULL,
buchungs_schluss_akt INTEGER,
buchungs_schluss_vm INTEGER,
buchungs_schluss_vvm INTEGER,
dat_fruehinfo1 DATE,
dat_fruehinfo2 DATE,
dat_buchungs_schluss DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);