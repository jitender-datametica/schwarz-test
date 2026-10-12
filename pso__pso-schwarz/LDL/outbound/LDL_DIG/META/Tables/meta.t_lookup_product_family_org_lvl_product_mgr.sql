CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_product_family_org_lvl_product_mgr (
prod_family_cd STRING(20) NOT NULL,
prod_org_lvl_name STRING(50),
prod_manager_cd STRING(100),
prod_group_ldt_cd STRING(100),
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP,
PRIMARY KEY (prod_family_cd) NOT ENFORCED
);