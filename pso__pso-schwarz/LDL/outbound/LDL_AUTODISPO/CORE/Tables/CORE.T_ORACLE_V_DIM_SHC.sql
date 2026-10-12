CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dim_shc (
sh_qty_correction_value BIGNUMERIC(38,10),
mod_date DATETIME,
country STRING(16777216),
sh_qty_wawi BIGNUMERIC(38,10),
sh_qty_correction_percentage BIGNUMERIC(38,10),
sh_aoc_shc_unit_id BIGNUMERIC(38,10),
sh_wawi_shc_unit_id BIGNUMERIC(38,10),
sh_item_nr STRING(16777216),
sh_store_nr BIGNUMERIC(38,10),
sh_qty_aoc BIGNUMERIC(38,10),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);