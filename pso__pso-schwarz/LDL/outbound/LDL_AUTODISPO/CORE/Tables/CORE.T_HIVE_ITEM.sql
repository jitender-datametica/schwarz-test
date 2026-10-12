CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_hive_item (
country STRING(16777216),
itemno STRING(16777216),
itemdesc STRING(16777216),
itemgroupno BIGNUMERIC(38,10),
itemgroupdesc STRING(16777216),
subgroupno BIGNUMERIC(38,10),
subgroupdesc STRING(16777216),
familyno BIGNUMERIC(38,10),
familydesc STRING(16777216),
tax_rate BIGNUMERIC(38,10),
is_weighted BIGNUMERIC(38,10),
is_sale_withdrawn BIGNUMERIC(38,10),
source_extraction_tmsp TIMESTAMP,
snflk_insert_tmsp TIMESTAMP,
snflk_update_tmsp TIMESTAMP
);