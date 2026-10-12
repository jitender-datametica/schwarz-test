CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_supplier_final_order_error_1 (
country_1 STRING(16777216),
fo_supplier_wh BIGNUMERIC(38,0),
fo_supplier_nr STRING(16777216),
fo_item_nr STRING(16777216),
fo_item_packagecapacity BIGNUMERIC(38,3),
fo_generation_date TIMESTAMP,
fo_delivery_date TIMESTAMP,
fo_order_pieces_quantity BIGNUMERIC(38,0),
fo_order_unit_quantity BIGNUMERIC(38,0),
fo_order_unit_id BIGNUMERIC(38,0),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
fo_is_sent BIGNUMERIC(38,0)
);