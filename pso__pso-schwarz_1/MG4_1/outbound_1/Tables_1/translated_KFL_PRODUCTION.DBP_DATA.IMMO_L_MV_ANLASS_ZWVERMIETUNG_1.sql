CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_l_mv_anlass_zwvermietung_1 (
mandant_id INTEGER NOT NULL,
anlass_zwvermietung_id INTEGER DEFAULT 0 NOT NULL,
anlass_zwvermietung_bez STRING(50) DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);