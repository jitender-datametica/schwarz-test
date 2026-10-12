CREATE OR REPLACE TABLE szd_production_eval.t_etl_dim_rvm_hist_s_file_b_2 (
rvm_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
manufacturer_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a company which produces deposit machines.'),
rvm_type_cd STRING(50) NOT NULL
OPTIONS(description='The code by which this type of deposit machine is identied, as assigned by the manufacturer.'),
store_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a main store. It is identical to the key of the store that has first been assigned to this main store.'),
country_pol_cd STRING(3) OPTIONS(description='The code identifying a political country_2 according to ISO 3166.'),
lob_cd STRING(50) NOT NULL
OPTIONS(description='The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland\n            lob=line os business'),
rvm_sort_type_cd STRING(50) NOT NULL OPTIONS(description='The code for the deposit machine background system sort type'),
rvm_orientation_cd STRING(50) NOT NULL
OPTIONS(description='The code for the deposit machine background system orientation'),
rvm_pack_type_cd STRING(50) NOT NULL OPTIONS(description='The code for the deposit machine background system packtype'),
rvm_winding_cd STRING(50) NOT NULL OPTIONS(description='The code for the deposit machine background system winding'),
rvm_active_id INTEGER NOT NULL OPTIONS(description='The id showing the activity state of the deposit machine.'),
manufacturer_name STRING(100) NOT NULL OPTIONS(description='The name of a company which produces deposit machines.'),
serial_nr STRING(250) NOT NULL
OPTIONS(description='The serial number of this machine, as assigned by the manufacturer.'),
initial_installation_dt DATE NOT NULL OPTIONS(description='The date when this machine was first installed.'),
inactive_dt DATE OPTIONS(description='The date when the machine was inactivated.'),
store_nr STRING(250) NOT NULL
OPTIONS(description='The number by which the store is known to business. This number is unique for a given client_id, but not globally unique. (The same number can be in different clients).'),
store_name STRING(100) NOT NULL OPTIONS(description='The name, by which the store in known.'),
lob_name STRING(100) NOT NULL
OPTIONS(description='The name for the line of business within the Schwarz Group, i.e.Lidl or Kaufland\n            lob=line os business'),
rvm_donation_start_dt DATE OPTIONS(description='The start date of the donation, if the RVM supports donations'),
in_store_seq INTEGER OPTIONS(description='The number consecutively of deposit machines in one store'),
energy_save_mode_fg BOOL
OPTIONS(description='The flag showing, if the deposit machine supports energy saving mode i.e. false'),
conf_crate_fg BOOL NOT NULL
OPTIONS(description='The flag showing, if the deposit machine is able to take back crate items.'),
conf_refillable_fg BOOL NOT NULL
OPTIONS(description='The flag showing, if the deposit machine is able to take back refillable items.'),
conf_non_refillable_fg BOOL NOT NULL
OPTIONS(description='The flag showing, if the deposit machine is able to take back non-refillable items.'),
conf_back_sys_crate_fg BOOL
OPTIONS(description='The flag showing, if the deposit machine has a backgroundsystem for crates.'),
conf_back_sys_table_fg BOOL
OPTIONS(description='The flag showing, if the deposit machine has a backgroundsystem for table.'),
conf_last_update_tmsp TIMESTAMP
OPTIONS(description='The timestamp for the last backgroundsystem sort type'),
rvm_software_version_nr STRING(250)
OPTIONS(description='The release number of the current software version of this machine.'),
rvm_software_last_update_dt DATE
OPTIONS(description='The date when the last software update was done for this machine.'),
smr_software_version_nr STRING(250)
OPTIONS(description='The release number of the current software version of this machine SMR.'),
smr_software_last_update_dt DATE
OPTIONS(description='The date when the last software update was done for this machine SMR.'),
time_zone_offset_hour_cnt STRING(250)
OPTIONS(description='The current time zone of the machine, i.e. the offset to UTC.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The identifier for the first source the table refers to.'),
src_2_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The identifier for the second source the table refers to.'),
src_3_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The identifier for the third source the table refers to.'),
PRIMARY KEY (rvm_sid, dwh_valid_from_tmsp) NOT ENFORCED
);