CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_revenue_statistics (
store_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store, for which the revenue statistics are generated.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country is not identical to a political country.)'),
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
stat_dt DATE NOT NULL OPTIONS(description='The date when the revenue statistics were collected. '),
bus_dt DATE NOT NULL OPTIONS(description='The date for which the revenue is accrued.'),
curr_stat_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the current record for the given key, i.e. the record with the latest statistics date. Filtering on this flag returns the statistics after any corrections.'),
correction_seq INTEGER
OPTIONS(description='In case multiple corrections apply to one base record, this is the sequence of the correction.'),
receipt_nr INTEGER NOT NULL OPTIONS(description='The number of the receipt which tracks the revenue statistics.'),
receipt_line_nr INTEGER NOT NULL
OPTIONS(description='The number of the positon on the receipt which tracks the revenue statistics.'),
stat_src_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the source or system which provided the statistics.'),
revenue_stat_type_id INTEGER NOT NULL
OPTIONS(description='The identifier for the subtype discriminator for revenue statisticss.'),
receipt_cnt INTEGER
OPTIONS(description='The number of receipts generated on this day in this internal organization (store).'),
turnover_net_val NUMERIC(29,5)
OPTIONS(description='The net turnover amount in the currency indicated by the currency code for this day and this internal organization (store). The net turnover is calclated based on the average VAT rate in this store and day.'),
turnover_gross_val NUMERIC(29,5)
OPTIONS(description='The gross turnover amount in the currency indicated by the currency code for this day and this internal organization (store).'),
curr_cd STRING(3) OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (store_sid, bus_dt, stat_dt, receipt_nr, receipt_line_nr) NOT ENFORCED
) OPTIONS(description='The event of creating revenue statistics for a particular store and day.');