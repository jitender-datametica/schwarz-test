CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dim_order_group (
country STRING(16777216),
dog_wh BIGNUMERIC(38,0),
dog_name STRING(16777216),
dog_item STRING(16777216),
dog_active BIGNUMERIC(38,0),
mod_date DATETIME,
dog_calculationmethod BIGNUMERIC(38,0),
dog_store BIGNUMERIC(38,0),
dwh_valid_from_tmsp TIMESTAMP NOT NULL,
dwh_valid_to_tmsp TIMESTAMP NOT NULL,
source_extraction_tmsp TIMESTAMP NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL
);