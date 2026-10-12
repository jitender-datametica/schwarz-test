CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_hive_active_items_1 (
country_1 STRING(16777216),
warehouseno BIGNUMERIC(38,1),
itemno STRING(16777216),
date_ DATE,
source_extraction_tmsp TIMESTAMP,
snflk_insert_tmsp TIMESTAMP,
snflk_update_tmsp TIMESTAMP
) CLUSTER BY date_, country_1, warehouseno;