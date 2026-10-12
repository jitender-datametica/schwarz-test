CREATE OR REPLACE TABLE ldl_data_production_etl.t_r2d_resource_item_cost_2 (
real_estate_sid INTEGER,
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
cost_type_cd STRING(20),
resource_item_type_cd STRING(20),
curr_cd STRING(20),
cost_val NUMERIC(29,5),
cost_eur_val NUMERIC(29,5)
);