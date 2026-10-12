CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_travel_cost_center (
trav_cost_center_cd STRING(5) NOT NULL OPTIONS(description='The code for the cost center ( for each source market )'),
trav_source_market_cd STRING(5) OPTIONS(description='The code for the source market in Lidl Travel '),
trav_cost_center_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the cost center in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (trav_cost_center_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the cost center ( for each source market )          10 - Germany          30 - Austria          20 - Switzerland (german speaking)          21 - Switzerland (french speaking) etc');