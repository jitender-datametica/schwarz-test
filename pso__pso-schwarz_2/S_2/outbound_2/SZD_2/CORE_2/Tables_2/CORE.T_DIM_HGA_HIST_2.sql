/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_HGA_HIST_2
   generated from Powerdesigner on Dienstag, 25. März 2025 15:46:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_hga_hist_2 (
hga_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store'),
dwh_valid_from_dt DATE NOT NULL OPTIONS(description='The date when this record became valid.'),
dwh_valid_to_dt DATE NOT NULL OPTIONS(description='The date when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a main store. It is identical to the key of the store that has first been assigned to this main store.'),
lob_cd STRING(50) NOT NULL
OPTIONS(description='The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland             lob=line os business'),
manufacturer_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a company which produces deposit machines.'),
hga_version_nr STRING(250) OPTIONS(description='The version for the Hot Beverage machine.'),
serial_nr STRING(250) NOT NULL
OPTIONS(description='The identifier for a hot beverage machine which is located in a store.'),
store_nr STRING(250) NOT NULL
OPTIONS(description='The number by which the store is known to business. This number is unique for a given client_id, but not globally unique. (The same number can be in different clients).'),
store_name STRING(100) NOT NULL OPTIONS(description='The name, by which the store in known.'),
country_pol_cd STRING(3) NOT NULL OPTIONS(description='The code identifying a political country_2 according to ISO 3166.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (hga_sid, dwh_valid_from_dt) NOT ENFORCED
) OPTIONS(description='The major dimension for hot beverage machines located in stores');