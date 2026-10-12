CREATE OR REPLACE TABLE szd_production_etl.t_client (
client_id INTEGER NOT NULL,
src_client_id INTEGER,
src_country_lidl_cd STRING(160),
src_country_cbx_cd STRING(160),
client_name STRING(800) NOT NULL,
country_sid INTEGER,
country_cd STRING(160) NOT NULL,
curr_sid INTEGER,
curr_cd STRING(160),
client_online_fg INTEGER NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);