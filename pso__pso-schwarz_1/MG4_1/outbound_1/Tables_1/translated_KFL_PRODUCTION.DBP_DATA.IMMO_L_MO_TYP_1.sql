CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_l_mo_typ_1 (
mandant_id INTEGER NOT NULL,
mo_typ_id INTEGER DEFAULT 0 NOT NULL,
mo_typ_bez STRING(30),
td_insert TIMESTAMP,
td_update TIMESTAMP
);