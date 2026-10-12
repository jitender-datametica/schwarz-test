CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ma_variable (
mandant_id BIGNUMERIC(38,0) NOT NULL,
buchungskreis_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
def_vollzeit_stunden NUMERIC(9,2) NOT NULL,
shr_freigabe_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);