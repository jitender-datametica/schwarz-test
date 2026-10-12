/* --------------------------------------------------------------------------------
   DDL for table: T_ALCOHOLIC_BEVERAGE_TAX_RATE
   generated from Powerdesigner on Donnerstag, 3. August 2023 09:23:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_alcoholic_beverage_tax_rate (
country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the political country.'),
alcoholic_beverage_tax_rate_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the tax rate for alcoholic beverages within the country.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
alcoholic_beverage_tax_rate_descr STRING(250) NOT NULL
OPTIONS(description='A brief description of the tax rate for alcoholic beverages.'),
excise_tax_rate_val BIGNUMERIC(38,5) NOT NULL OPTIONS(description='The excise rate per liter.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source.'),
PRIMARY KEY (country_location_sid, alcoholic_beverage_tax_rate_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - Contains the tax rates for alcoholic beverages in a certain country. - Source - Manual');