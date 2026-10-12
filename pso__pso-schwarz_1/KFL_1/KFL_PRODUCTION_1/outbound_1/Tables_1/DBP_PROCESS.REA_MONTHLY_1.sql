CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.rea_monthly_1 (
kennung STRING(3),
kjmo BIGNUMERIC(38,0) NOT NULL,
menge INTEGER,
wup_id BIGNUMERIC(38,0) NOT NULL,
kl_art_id BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);