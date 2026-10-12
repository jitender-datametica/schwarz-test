CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_item_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
country_iso_cd STRING(3) NOT NULL,
orig_item_nr BIGNUMERIC(38,0) NOT NULL,
orig_item_nr_int INTEGER,
case_size BIGNUMERIC(38,4) NOT NULL,
package_qty BIGNUMERIC(38,4),
item_name STRING(100) NOT NULL,
item_descr STRING(250) NOT NULL,
src_orig_item_nr_int INTEGER OPTIONS(description='An IAN number that was mapped in data warehouse'),
familygrp_cd STRING(20) OPTIONS(description='Family group code (lower level of product hierarchy_2)'),
subitemgrp_cd STRING(20) OPTIONS(description='Subitemgroup code (higher level of product hierarchy_2)'),
dwh_created_tmsp DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (client_id, country_iso_cd, orig_item_nr, case_size, item_name, item_descr) NOT ENFORCED
) OPTIONS(description='Product Data');