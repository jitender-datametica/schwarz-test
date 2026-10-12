CREATE OR REPLACE TABLE ldl_data_production_eval.t_real_estate_x (
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
real_estate_nr STRING(20) NOT NULL
OPTIONS(description='The number which uniquely identifies a real estate object within a country organization.'),
real_estate_name STRING(100) NOT NULL OPTIONS(description='The name for the real estate object.'),
real_estate_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for real estate objects.'),
ownership_type_cd STRING(20)
OPTIONS(description='The code identifying the ownership type of a real estate object, i.e. if it has been bought or if it is rented.'),
ownership_ratio_type_cd STRING(20)
OPTIONS(description='The code identifying the ownership ratio of a real estate object, i.e. if it is fully owned or partly owned.'),
own_acquisition_fg BOOL
OPTIONS(description='An indicator showing, if the real estate object was acquired by the Schwarz Group without involvement of a third party.'),
real_estate_usg_type_cd STRING(20)
OPTIONS(description='The code for the way, how a real estate object is used. An object may be used by the organization or by a third party.'),
wh_building_type_cd STRING(20) OPTIONS(description='The code for the subtype discriminator for warehouse building.'),
wh_purpose_cd STRING(20) OPTIONS(description='The code identifying the purpose of a warehouse.'),
shared_usg_fg BOOL OPTIONS(description='An indicator showing, if the warehouse is used by multiple parties.'),
contract_dt DATE OPTIONS(description='The date when the contract for this real estate object was signed.'),
precontract_dt DATE
OPTIONS(description='The date when the precontract / letter of intent for this real estate object was signed.'),
construction_start_dt DATE OPTIONS(description='The date when construction started for this real estate object.'),
construction_end_dt DATE OPTIONS(description='The date when construction finished for this real estate object.'),
open_dt DATE OPTIONS(description='The date when this real estate object was opened.'),
planned_open_dt DATE OPTIONS(description='The date when this real estate object was intended to open.'),
close_dt DATE OPTIONS(description='The date when this real estate object was closed.'),
planned_close_dt DATE OPTIONS(description='The date when this real estate object was inteded to be closed.'),
project_cancel_dt DATE
OPTIONS(description='The date when the Schwarz Group had no intention to build a real estate object any more, i.e. when the project was cancelled.'),
project_term_dt DATE
OPTIONS(description='The date when the project was terminated, i.e. when the real estate object was closed and there were no legal obligations any more.'),
sales_area_meas NUMERIC(29,5)
OPTIONS(description='The space which can be used for sales, in the unit indicated by the unit of measure code (e.g. m2).'),
storage_area_meas NUMERIC(29,5)
OPTIONS(description='The space which can be used for storing goods, in the unit indicated by the unit of measure code (e.g. m2).'),
total_sublet_area_meas NUMERIC(29,5)
OPTIONS(description='The total space which can be sublet, in the unit indicated by the unit of measure code (e.g. m2).'),
rented_sublet_area_meas NUMERIC(29,5)
OPTIONS(description='The space which is currently rented out, in the unit indicated by the unit of measure code.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit of measure for the sales area.'),
total_parking_space_cnt INTEGER
OPTIONS(description='The total number of parking spaces that are assigned to this building.'),
own_parking_space_cnt INTEGER
OPTIONS(description='The number of parking spaces that are assigned to this building and which are owned by the Schwarz Group.'),
underground_parking_space_cnt INTEGER
OPTIONS(description='The total number of parking spaces in an underground parking garage that are assigned to this building.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (real_estate_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='Real Estate is property in the form of land or buildings.');