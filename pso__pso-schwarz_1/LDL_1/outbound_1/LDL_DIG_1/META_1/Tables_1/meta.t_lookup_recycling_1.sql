CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_recycling_1 (
cust_order_type_cd STRING(20),
salesorg STRING(20),
sales_segment_type_cd STRING(20),
cust_nr STRING(20),
storage_loc_cd STRING(20),
batch_nr STRING(20),
material_doc_mov_type_cd STRING(20),
material_doc_mov_process_subtype_name STRING(100),
is_recycling_fg BOOL,
source STRING(20),
valid_from_dt DATE,
valid_to_dt DATE,
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP
);