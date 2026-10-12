CREATE TABLE IF NOT EXISTS szd_core.t_dim_deposit_article (
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier for an item'),
item_gtin STRING(20) NOT NULL OPTIONS(description='The gtin of an item'),
lob_cd STRING(50) NOT NULL
OPTIONS(description='The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland\n            lob=line os business'),
manufacturer_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a company which produces deposit machines.'),
unitsize_descr STRING(250) OPTIONS(description='The size of a deposit article'),
item_name STRING(100) OPTIONS(description='The name of an item'),
item_container_type_cd STRING(50) NOT NULL
OPTIONS(description='The description of a container which can be foreign or own container'),
item_package_type_descr STRING(250) OPTIONS(description='The type of a package e.g. PET, Bottle'),
first_distributor_name STRING(100) OPTIONS(description='The first distributor to the market'),
country_pol_cd STRING(3) NOT NULL OPTIONS(description='The code identifying a political country according to ISO 3166.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(250) NOT NULL
OPTIONS(description='The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)'),
src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The identifier for the first source the table refers to.'),
src_2_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The identifier for the second source the table refers to.'),
src_3_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The identifier for the third source the table refers to.'),
PRIMARY KEY (item_sid) NOT ENFORCED
) OPTIONS(description='The base data table for deposit articles coming from Kaufland and Lidl');