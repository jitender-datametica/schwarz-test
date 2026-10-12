CREATE OR REPLACE TABLE szd_production_core.t_dim_store_hist (
store_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a main store. It is identical to the key of the store that has first been assigned to this main store.'),
dwh_valid_from_dt DATE NOT NULL OPTIONS(description='The date when this record became valid.'),
dwh_valid_to_dt DATE NOT NULL OPTIONS(description='The date when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
lob_cd STRING(50) NOT NULL
OPTIONS(description='The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland\nlob=line os business'),
lob_name STRING(100) NOT NULL
OPTIONS(description='The name for the line of business within the Schwarz Group, i.e.Lidl or Kaufland\nlob=line os business'),
company_id INTEGER OPTIONS(description='The Company number of a store e.g. 13'),
company_name STRING(100) OPTIONS(description='The Company name of a store. e.g. Lidl GmbH & Co. KG'),
store_nr STRING(250)
OPTIONS(description='The number by which the store is known to business. This number is unique for a given client_id, but not globally unique. (The same number can be in different clients).'),
store_name STRING(100) OPTIONS(description='The name, by which the store in known.'),
store_active_fg BOOL NOT NULL
OPTIONS(description='An indicator showing if the store had any sales during the last 36 months. (The flag is equivalent to mis_store_active_fg in the core. It is not delivered by a source system, but calculated during the core load.)'),
street_name STRING(100) OPTIONS(description='The name of the street where the store is located.'),
house_nr STRING(20) OPTIONS(description='The number of the building within the street where the store is located.'),
city_name STRING(100) OPTIONS(description='The name of the city where the store is located.'),
zip STRING(15) OPTIONS(description='The postal code of the store address.'),
country_pol_cd STRING(3) NOT NULL OPTIONS(description='The code identifying a political country according to ISO 3166.'),
country_pol_name STRING(100) NOT NULL
OPTIONS(description='The name for a political country in group language, i.e. in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (store_sid, dwh_valid_from_dt) NOT ENFORCED
)
OPTIONS(description='The main store identifies a physical store, regardless if its business store number gets changed in the source systems or not.');