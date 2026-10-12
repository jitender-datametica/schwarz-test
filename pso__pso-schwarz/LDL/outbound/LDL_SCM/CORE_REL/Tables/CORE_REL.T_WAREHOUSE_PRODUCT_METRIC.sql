CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_warehouse_product_metric (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier of Lidl Country'),
src_wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The warehouse number '),
orig_item_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wawi Item short number'),
case_size BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Wawi Case size'),
bus_dt DATE NOT NULL OPTIONS(description='Business Date '),
metric_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the type of metric which is collected for internal companies.'),
metric_qty BIGNUMERIC(38,5) OPTIONS(description='Metric quantity'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (client_id, src_wh_id, orig_item_nr, case_size, bus_dt, metric_type_cd) NOT ENFORCED
) OPTIONS(description='A table that stores KPI on the warehouse and products level on daily level');