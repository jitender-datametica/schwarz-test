CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_demand_item_agg_1 (
cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of a calendar_1 month in the form YYYYMM. E.g. 202101 für January 2021.'),
cal_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier of Lidl Country_1'),
country_cd STRING(160) OPTIONS(description='Iso code of the country_1'),
demand_source_name STRING(100) NOT NULL OPTIONS(description='Source name for a demand '),
item_ba_nr BIGNUMERIC(38,0) OPTIONS(description='Item_1 BA number'),
item_ba_descr STRING(500) OPTIONS(description='Item_1 BA decsription'),
item_ian_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Item_1 IAN number'),
item_descr STRING(250) OPTIONS(description='Item_1 IAN description'),
supplier_int_id BIGNUMERIC(38,0) OPTIONS(description='Internal number for a supplier_1'),
pallet_factor BIGNUMERIC(38,0) OPTIONS(description='Pallet factor'),
case_size BIGNUMERIC(38,0) OPTIONS(description='Case size'),
demand_per_week_qty BIGNUMERIC(38,5) OPTIONS(description='Weekly quantity of demand'),
demand_per_week_pal_qty BIGNUMERIC(38,5) OPTIONS(description='Weekly quantity of demand in pallet'),
demand_per_year_qty BIGNUMERIC(38,5) OPTIONS(description='Yearly quantity of demand'),
demand_per_year_pal_qty BIGNUMERIC(38,5) OPTIONS(description='Yearly quantity of demand in pallet'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (cal_month, cal_week, client_id, demand_source_name, item_ian_nr) NOT ENFORCED
) OPTIONS(description='A table that stores demand information enriched with proper product identification');