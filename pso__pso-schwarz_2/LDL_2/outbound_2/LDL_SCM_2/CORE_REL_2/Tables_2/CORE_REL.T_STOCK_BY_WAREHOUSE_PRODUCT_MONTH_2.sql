CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_stock_by_warehouse_product_month_2 (
cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of a calendar_2 month in the form YYYYMM. E.g. 202101 für January 2021.'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier of Lidl Country_2'),
src_wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The warehouse number '),
orig_item_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wawi Item_2 short number'),
case_size BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Wawi Case size'),
stock_qty BIGNUMERIC(38,5) OPTIONS(description='Stock quantity'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (cal_month, client_id, src_wh_id, orig_item_nr, case_size) NOT ENFORCED
) OPTIONS(description='A table that stores KPI on the warehouse and products level on weekly and monthly level');