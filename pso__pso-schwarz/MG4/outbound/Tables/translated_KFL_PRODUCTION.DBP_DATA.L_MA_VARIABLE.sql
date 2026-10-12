CREATE OR REPLACE TABLE kfl_production_dbp_data.l_ma_variable (
mandant_id INTEGER NOT NULL,
buchungskreis_id INTEGER NOT NULL,
kjmo INTEGER NOT NULL,
def_vollzeit_stunden NUMERIC(9,2) NOT NULL,
shr_freigabe_fg INTEGER DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);