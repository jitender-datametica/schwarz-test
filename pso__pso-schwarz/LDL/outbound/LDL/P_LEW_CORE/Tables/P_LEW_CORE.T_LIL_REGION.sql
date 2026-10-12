CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_region (
client_id BIGNUMERIC(38,0) NOT NULL,
region_sid BIGNUMERIC(38,0) NOT NULL,
src_region_cd STRING(160) NOT NULL,
region_name STRING(800) NOT NULL,
country_sid BIGNUMERIC(38,0) NOT NULL,
country_pol_sid BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;