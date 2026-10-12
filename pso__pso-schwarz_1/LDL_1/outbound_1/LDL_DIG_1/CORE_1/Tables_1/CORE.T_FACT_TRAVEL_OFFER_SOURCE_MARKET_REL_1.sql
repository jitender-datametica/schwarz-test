/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_TRAVEL_OFFER_SOURCE_MARKET_REL_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 17. August 2022 08:14:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_travel_offer_source_market_rel_1 (
trav_source_market_cd STRING(5) NOT NULL OPTIONS(description='The code for the source market in Lidl Travel'),
trav_offer_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the travel offering'),
trav_offer_active_from_tmsp TIMESTAMP
OPTIONS(description='The timestamp from when the travel offer is valid'),
trav_offer_active_to_tmsp TIMESTAMP
OPTIONS(description='The timestamp till when the travel offer is valid'),
trav_offer_active_fg BOOL OPTIONS(description='The indicator for identifying the active offers'),
trav_offer_operator_cd STRING(100) OPTIONS(description='The code for the travel offer operator'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (trav_source_market_cd, trav_offer_sid) NOT ENFORCED
)
OPTIONS(description='This factless fact table holds the details of travel offers that can be activated for several markets.             ');