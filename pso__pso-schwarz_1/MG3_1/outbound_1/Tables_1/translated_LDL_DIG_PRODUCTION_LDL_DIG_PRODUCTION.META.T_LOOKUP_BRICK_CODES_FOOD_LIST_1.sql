CREATE OR REPLACE TABLE ldl_dig_production_meta.t_lookup_brick_codes_food_list_1 (
prod_gs1_lvl1_brick_descr STRING(250),
prod_gs1_lvl1_brick_cd STRING(40),
prod_brick_cd STRING(40) NOT NULL,
prod_brick_descr STRING(250),
tmsp_update TIMESTAMP,
tmsp_insert TIMESTAMP,
PRIMARY KEY (prod_brick_cd) NOT ENFORCED
);