CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_country_statistics_by_month_1 (
reporting_country_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the reporting country. (i.e. a country_1 definition which is different from a geographical country_1)'),
stat_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of metric which is calculated for the reporting country.'),
stat_dt DATE NOT NULL OPTIONS(description='The date when the statistics were collected. '),
cal_month INTEGER NOT NULL
OPTIONS(description='The identifier of a calendar_1 month in the form YYYYMM. E.g. 202101 für January 2021.'),
curr_stat_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the current record(s) for the given key, Filtering on this flag returns the statistics after any corrections.'),
stat_val NUMERIC(29,5)
OPTIONS(description='The calculated statistics amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'),
curr_cd STRING(3) OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
stat_cnt INTEGER
OPTIONS(description='The calculated statistics count for the given month, statistics type and reporting country.'),
stat_qty NUMERIC(29,5)
OPTIONS(description='The calculated statistics quantity for the given month, statistics type and reporting country.'),
stat_meas NUMERIC(29,5)
OPTIONS(description='The calculated statistics measure for the given month, statistics type and reporting country.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_1 of measure for the statistics measure.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (reporting_country_sid, stat_dt, cal_month, stat_type_cd) NOT ENFORCED
)
OPTIONS(description='Various derived metrics can be calculated on the level of a month and a reporting country. These values are not necessarily in sync with the underlying base events. The table contains separate columns for each domain of statistics values. Depending on the statistics type, one of them is filled.');