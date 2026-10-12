DROP TABLE IF EXISTS ldl_data_production_core_rel.t_product_statistics_2;
CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_product_statistics_2 (
store_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store, in which the end-of-day processing happens.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country_2 is not identical to a political country.)'),
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object in which the store is located.'),
stat_dt DATE NOT NULL OPTIONS(description='The date when the product statistics were collected. '),
bus_dt DATE NOT NULL OPTIONS(description='The business date for which the product statistics are generated.'),
curr_stat_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the current record for the given key, i.e. the record with the latest statistics date. Filtering on this flag returns the statistics after any corrections.'),
sales_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the sales_2 variant for which statistics are calculated.'),
sold_cnt INTEGER
OPTIONS(description='The number of sales_2 variants which were sold. (In case the sales_2 variant is sold by weight, this attribute is empty.)'),
returned_cnt INTEGER
OPTIONS(description='The number of sales_2 variants which have been returned. (In case the sales_2 variant is sold by weight, this attribute is empty.)'),
cancel_cnt INTEGER
OPTIONS(description='The number of sales_2 variants for which the line was cancelled. (In case the sales_2 variant is sold by weight, this attribute is empty.)'),
sold_qty NUMERIC(29,5)
OPTIONS(description='The quantity of the sales_2 variant which was sold - in case the sales_2 variant is sold by weight instead of pieces.'),
returned_qty NUMERIC(29,5)
OPTIONS(description='The quantity of the sales_2 variant which have been returned- in case the sales_2 variant is sold by weight instead of pieces.'),
cancel_qty NUMERIC(29,5)
OPTIONS(description='The quantity of the sales_2 variants for which the line was cancelled - in case the sales_2 variant is sold by weight instead of pieces.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_2 of measure.'),
turnover_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover in the currency indicated by the currency code, for this store, sales_2 variant and day.'),
returned_gross_val NUMERIC(29,5) OPTIONS(description='The gross value of the sales_2 variants which have been returned.'),
cancel_gross_val NUMERIC(29,5)
OPTIONS(description='The gross value of the sales_2 variants for which the line was cancelled.'),
curr_cd STRING(3) OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
last_sale_tmsp TIMESTAMP
OPTIONS(description='The time when the last sales_2 was made of this sales_2 variants.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (store_sid, real_estate_sid, bus_dt, stat_dt, sales_variant_sid) NOT ENFORCED
) CLUSTER BY bus_dt
OPTIONS(description='The event of producing product level statistics, showing the quantiy sold and the revenue for each sales_2 variant and store on the given day.');