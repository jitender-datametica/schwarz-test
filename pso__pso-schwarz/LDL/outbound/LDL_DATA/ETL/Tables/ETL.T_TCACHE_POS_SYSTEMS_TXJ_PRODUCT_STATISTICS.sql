CREATE TABLE IF NOT EXISTS ldl_data_etl.t_tcache_pos_systems_txj_product_statistics (
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store, in which the end-of-day processing happens.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country organization.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object in which the store is located.'),
stat_dt DATE NOT NULL OPTIONS(description='The date when the product statistics were collected. '),
bus_dt DATE NOT NULL OPTIONS(description='The business date for which the product statistics are generated.'),
curr_stat_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the current record for the given key, i.e. the record with the latest statistics date. Filtering on this flag returns the statistics after any corrections.'),
sales_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the sales variant for which statistics are calculated.'),
sold_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of sales variants which were sold. (In case the sales variant is sold by weight, this attribute is empty.)'),
returned_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of sales variants which have been returned. (In case the sales variant is sold by weight, this attribute is empty.)'),
cancel_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of sales variants for which the line was cancelled. (In case the sales variant is sold by weight, this attribute is empty.)'),
sold_qty BIGNUMERIC(38,5)
OPTIONS(description='The quantity of the sales variant which was sold - in case the sales variant is sold by weight instead of pieces.'),
returned_qty BIGNUMERIC(38,5)
OPTIONS(description='The quantity of the sales variant which have been returned- in case the sales variant is sold by weight instead of pieces.'),
cancel_qty BIGNUMERIC(38,5)
OPTIONS(description='The quantity of the sales variants for which the line was cancelled - in case the sales variant is sold by weight instead of pieces.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit of measure.'),
turnover_gross_val BIGNUMERIC(38,5)
OPTIONS(description='The gross turnover in the currency indicated by the currency code, for this store, sales variant and day.'),
returned_gross_val BIGNUMERIC(38,5)
OPTIONS(description='The gross value of the sales variants which have been returned.'),
cancel_gross_val BIGNUMERIC(38,5)
OPTIONS(description='The gross value of the sales variants for which the line was cancelled.'),
last_sale_tmsp TIMESTAMP
OPTIONS(description='The time when the last sales was made of this sales variants.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);