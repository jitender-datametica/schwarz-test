CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_prod_status_replenishment_flag_2 (
global_status STRING(5),
online_status STRING(5),
listing_status STRING(5),
is_replenishment_considered BOOL,
replenishment_from_venlo BOOL,
replenishment_from_supplier BOOL,
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP
);