--==============================================================
-- Table: t_dim_supplier_site_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_supplier_site_2
   generated from Powerdesigner on Mittwoch, 7. August 2024 10:43:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_supplier_site_2 (
supplier_site_sid BIGNUMERIC NOT NULL
OPTIONS(description='Supplier_2 site where the goods are provided, for KoL (Komplettladung / Direktlogistik) logistic types'),
supplier_sid BIGNUMERIC NOT NULL OPTIONS(description='Unique identifier for the supplier_2'),
country_cd STRING(2) OPTIONS(description='The code for the country_2 in which the site (cross docks) resides in.'),
country_descr STRING(100)
OPTIONS(description='A textual description for country_cd written out in group language (German).'),
supplier_site_nr STRING(20) OPTIONS(description='The number which identifies the   in '),
supplier_site_abbr_name STRING(100) OPTIONS(description='The abbreviated name of the supplier_2'),
supplier_site_name STRING(100) OPTIONS(description='The name by which a site is known which is run by a supplier. '),
supplier_site_transpoint_type_cd STRING(20)
OPTIONS(description='The type of the supplier_2 e.g. (PROD = Produktionsstätte, HEAD = Firmensitz, LOAD = Verladestandort)'),
supplier_site_transpoint_type_descr STRING(100)
OPTIONS(description='The german description for the supplier_site_transpoint_type_cd'),
longitude NUMERIC(9,6) OPTIONS(description='Object.address_2-data.coordinates x'),
latitude NUMERIC(9,6) OPTIONS(description='Object.address_2-data.coordinates y'),
city_name STRING(100) OPTIONS(description='Name of the city'),
zip STRING(15) OPTIONS(description='Zip code / PLZ'),
street_name STRING(100) OPTIONS(description='Name of the street'),
gln_nr STRING(13) OPTIONS(description='The Global Location_2 Number where the supplier_2 is located.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (supplier_site_sid) NOT ENFORCED
)
OPTIONS(description='This entity contains sites which are operated by supplier_2, such as factories or distribution warehouses. ');