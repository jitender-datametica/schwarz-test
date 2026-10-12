CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_subitemgroup_delivery_time_target (
subitemgrp_cd STRING(20) NOT NULL OPTIONS(description='Subitemgroup code (higher level of product hierarchy)'),
tgt_delivery_time_week_cnt BIGNUMERIC(38,0) OPTIONS(description='Target delivery time in weeks'),
supplier_name STRING(100) OPTIONS(description='Supplier name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (subitemgrp_cd) NOT ENFORCED
) OPTIONS(description='Target delivery time set for each subitem group by business');