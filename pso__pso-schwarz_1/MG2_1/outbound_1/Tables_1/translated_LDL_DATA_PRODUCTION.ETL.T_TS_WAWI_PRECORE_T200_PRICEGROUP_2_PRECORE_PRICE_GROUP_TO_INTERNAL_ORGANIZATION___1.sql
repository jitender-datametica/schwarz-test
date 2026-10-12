CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_wawi_precore_t200_pricegroup_2_precore_price_group_to_internal_organization___1
(
int_org_sid INTEGER,
int_org_type_cd STRING(20),
price_grp_sid INTEGER,
price_grp_prio INTEGER,
datefrom DATETIME,
dateto DATETIME,
open_dt DATE,
close_dt DATE,
dwh_load_id INTEGER,
dwh_node_cd STRING(20),
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg INTEGER
);