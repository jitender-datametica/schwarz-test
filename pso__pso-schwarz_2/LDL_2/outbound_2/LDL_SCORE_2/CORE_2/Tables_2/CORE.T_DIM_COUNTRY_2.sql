--==============================================================
-- Table: t_dim_country_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_country_2
   generated from Powerdesigner on Dienstag, 2. April 2024 06:38:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_country_2 (
country_cd STRING(2) NOT NULL
OPTIONS(description='The code for the country_2 in which the site (cross docks) resides in.'),
country_descr STRING(100)
OPTIONS(description='A textual description for country_cd written out in group language (German).'),
country_descr_de STRING(100) OPTIONS(description='A textual description for country_cd written out in German.'),
country_descr_en STRING(100) OPTIONS(description='A textual description for country_cd written out in English.'),
suppliers_exist_fg BOOL OPTIONS(description='Flag informs, if supplier_2 exist in this country.'),
haulers_exist_fg BOOL OPTIONS(description='Flag informs, if hauler exist in this country.'),
org_units_exist_fg BOOL OPTIONS(description='Flag informs, if Org Unit_2 exist in this country.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (country_cd) NOT ENFORCED
)
OPTIONS(description='Is by definition the opposite from the business country. Here we don\'t separate islands from the country. ');