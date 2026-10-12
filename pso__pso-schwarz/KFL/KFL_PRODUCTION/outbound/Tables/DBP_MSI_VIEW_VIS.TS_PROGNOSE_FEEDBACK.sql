CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_vis.ts_prognose_feedback (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
zeitstempel DATETIME NOT NULL,
prognose_fg BIGNUMERIC(38,0) NOT NULL
);