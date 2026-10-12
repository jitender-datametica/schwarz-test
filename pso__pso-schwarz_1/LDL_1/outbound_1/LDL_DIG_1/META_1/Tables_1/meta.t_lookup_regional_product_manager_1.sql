CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_regional_product_manager_1 (
wshop_cd STRING(5) NOT NULL,
prod_family_cd STRING(20) NOT NULL,
regional_product_manager_cd STRING(100),
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP,
PRIMARY KEY (wshop_cd, prod_family_cd) NOT ENFORCED
);