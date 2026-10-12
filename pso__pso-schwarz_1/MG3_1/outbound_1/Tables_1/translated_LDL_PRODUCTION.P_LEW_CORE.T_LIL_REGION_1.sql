DROP TABLE IF EXISTS ldl_production_p_lew_core.t_lil_region_1;
CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_lil_region_1 (
client_id INTEGER NOT NULL,
region_sid INTEGER NOT NULL,
src_region_cd STRING(160) NOT NULL,
region_name STRING(800) NOT NULL,
country_sid INTEGER NOT NULL,
country_pol_sid INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;