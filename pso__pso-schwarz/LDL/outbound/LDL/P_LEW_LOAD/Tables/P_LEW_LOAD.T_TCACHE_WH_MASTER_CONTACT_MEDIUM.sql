CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_wh_master_contact_medium (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_id BIGNUMERIC(38,0) NOT NULL,
medium_cd STRING(50) COLLATE 'und:ci',
medium_type_id INTEGER NOT NULL,
modification_date DATE,
read_only INTEGER NOT NULL,
type_id INTEGER NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);