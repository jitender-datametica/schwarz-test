CREATE OR REPLACE TABLE kfl_production_dbp_data.woche_kj_kl_1 (
kjwo_kl INTEGER NOT NULL,
kjwo_kl_dat_von DATE,
kjwo_kl_dat_bis DATE,
akt_kjwo_kl INTEGER,
akt_kjwo_kl_komplett INTEGER,
akt_kj INTEGER,
akt_kj_komplett INTEGER,
kjwo INTEGER,
akt_wo INTEGER DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);