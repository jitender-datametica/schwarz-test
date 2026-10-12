CREATE TABLE IF NOT EXISTS ldl_data_etl.t_tcache_txj_510_load_2_tcache_daily_vat_statistics_intermediate_2 (
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store, in which the end-of-day processing happens.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization.'),
stat_dt DATE NOT NULL OPTIONS(description='The date when the VAT statistics were collected. '),
bus_dt DATE NOT NULL OPTIONS(description='The business date for which the VAT statistics are generated.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization.'),
curr_stat_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the current record for the given key, i.e. the record with the latest statistics date. Filtering on this flag returns the statistics after any corrections.'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the geographical area to which the tax class applies.'),
tax_class_cd STRING(20) NOT NULL OPTIONS(description='The code for the tax class, e.g. Reduced VAT Rate.'),
vat_stat_calc_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the VAT statistics have been calculated.'),
turnover_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The gross turnover in the currency indicated by the currency code, for this store and time period which is taxed with the given VAT class.'),
vat_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The resulting VAT amout in the currency indicated by the currency code, for the given store, time period and VAT class.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (store_sid, bus_dt, stat_dt, geo_area_sid, tax_class_cd, vat_stat_calc_method_cd) NOT ENFORCED
);