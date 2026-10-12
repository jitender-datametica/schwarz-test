CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_cal_cum_business_year_to_half_year_1 (
bus_half_year INTEGER NOT NULL
OPTIONS(description='The business half year for which the business-year-to-half-year interval is defined.'),
incl_bus_half_year INTEGER NOT NULL
OPTIONS(description='The business half year that needs to be included in the business-year-to-half-year interval.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (bus_half_year, incl_bus_half_year) NOT ENFORCED
)
OPTIONS(description='This table relates a business half year to all business half years that form the business-half-year-to-year interval of this business half year. E.g. for the20211 this is 20211 and 20212.');