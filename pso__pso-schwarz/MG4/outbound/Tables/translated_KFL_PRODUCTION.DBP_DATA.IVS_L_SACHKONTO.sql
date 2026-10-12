CREATE OR REPLACE TABLE kfl_production_dbp_data.ivs_l_sachkonto (
sachkonto_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
sachkonto_bez STRING(100),
spr_id INTEGER,
sachkonto_gruppe_id INTEGER NOT NULL,
plantyp_id INTEGER,
plandetail_id INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);