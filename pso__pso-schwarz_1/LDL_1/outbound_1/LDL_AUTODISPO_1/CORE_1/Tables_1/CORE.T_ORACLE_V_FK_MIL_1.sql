CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_mil_1 (
country_1 STRING(250),
store BIGNUMERIC(38,0),
itemnr_long BIGNUMERIC(38,0),
item_nr STRING(250),
item_packagecapacity BIGNUMERIC(38,0),
itemdesc STRING(250),
entrydate DATETIME,
warehousemil BIGNUMERIC(38,0),
orderarea BIGNUMERIC(38,0),
std NUMERIC(10,2),
status_1 BIGNUMERIC(38,0),
quantity NUMERIC(10,2),
capacity NUMERIC(10,2),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
) CLUSTER BY entrydate, country_1;