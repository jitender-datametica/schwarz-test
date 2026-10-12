CREATE TABLE IF NOT EXISTS ldl_etl.t_r2d_resource_item_cost_2 (
real_estate_sid BIGNUMERIC(38,0),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
cost_type_cd STRING(20),
resource_item_type_cd STRING(20),
curr_cd STRING(20),
cost_val BIGNUMERIC(38,5),
cost_eur_val BIGNUMERIC(38,5)
);