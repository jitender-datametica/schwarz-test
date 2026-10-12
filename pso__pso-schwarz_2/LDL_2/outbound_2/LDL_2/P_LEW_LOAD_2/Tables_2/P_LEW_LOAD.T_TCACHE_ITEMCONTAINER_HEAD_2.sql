CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_itemcontainer_head_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
container_id BIGNUMERIC(38,0) NOT NULL,
desc_int STRING(100),
status_2 BIGNUMERIC(38,0),
information STRING(100),
country_2 STRING(10) NOT NULL,
desc_nat STRING(100),
cont_id_local BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
dwh_mapping_date DATE,
extraction_dt DATE,
PRIMARY KEY (container_id, country_2, cont_id_local) NOT ENFORCED
);