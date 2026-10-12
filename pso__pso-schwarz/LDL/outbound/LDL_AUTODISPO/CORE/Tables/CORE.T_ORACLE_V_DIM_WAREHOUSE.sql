CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dim_warehouse (
ware_name STRING(16777216),
country STRING(16777216),
ware_warehouse_id BIGNUMERIC(38,10),
ware_active BIGNUMERIC(38,10),
mod_date DATETIME,
ware_id BIGNUMERIC(38,10),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
int_fc BIGNUMERIC(38,1),
adl_active BIGNUMERIC(38,1)
);