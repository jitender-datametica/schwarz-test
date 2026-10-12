/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_rdcaddress_1
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_rdcaddress_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
city_name STRING(512) OPTIONS(description='City'),
country_name STRING(512) OPTIONS(description='Country_1'),
day_of_week STRING(512) NOT NULL OPTIONS(description='Day of the week this address_1 is for'),
default_comment STRING(512) OPTIONS(description='Default comment for any address_1 states for this address_1'),
end_open_tm STRING(512) OPTIONS(description='End of the opening hours '),
extra_info STRING(512) OPTIONS(description='Free text field to fill external information'),
has_ramp_fg BOOL OPTIONS(description='Indicates whether a ramp is available at the address_1'),
house_nr STRING(512) OPTIONS(description='HouseNumber'),
address_id STRING(512) NOT NULL OPTIONS(description='ID of the address_1/store'),
soft_delete_fg BOOL OPTIONS(description='Used for soft delete'),
special_store_fg BOOL
OPTIONS(description='TRUE if this address_1 is a special stores that require different delivery handling'),
store_fg BOOL OPTIONS(description='Indicates whether the address_1 is a store'),
dismount_allowed_fg BOOL
OPTIONS(description='Indicates whether at this location_1 a resource can be left behind - Phase 2'),
unman_deliv_allowed_fg BOOL OPTIONS(description='Indicator of an unmanned delivery is allowed'),
address_long_name STRING(512) OPTIONS(description='Full name of an address_1'),
address_name STRING(512) OPTIONS(description='Name of the address_1/store'),
post_code STRING(512) OPTIONS(description='PostCode'),
start_open_tm STRING(512) OPTIONS(description='Start of the opening hours'),
state STRING(512) OPTIONS(description='State'),
street_name STRING(512) OPTIONS(description='Street'),
max_length BIGNUMERIC(38,10)
OPTIONS(description='The maximum length a resource set is allowed to have to visit this address.'),
max_predelivered_cnt BIGNUMERIC(38,10)
OPTIONS(description='Maximum number of pallets that can be delivered early per store'),
max_undelivered_cnt BIGNUMERIC(38,10)
OPTIONS(description='Maximum number of pallets that can be delivered late per store'),
location_lat BIGNUMERIC(38,10) OPTIONS(description='The geographical location.'),
location_lon BIGNUMERIC(38,10) OPTIONS(description='The geographical location.'),
location_x BIGNUMERIC(38,10) OPTIONS(description='X value for the location_1 Object'),
location_y BIGNUMERIC(38,10) OPTIONS(description='Y value for the location_1 Object'),
location_y_user BIGNUMERIC(38,10) OPTIONS(description='Y value for the location_1 Object'),
vehicles_unmanned_delivery_max_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of different vehicles allowed (models number of keys)'),
stops_per_delivery_day_user_max_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of stops that are allowed for one store per delivery day set by a User'),
max_weight BIGNUMERIC(38,10) OPTIONS(description='Maximum weight of a truck that can park/approach the store.'),
docks_max_cnt BIGNUMERIC(38,0) OPTIONS(description='Maximum number of (un)loads allowed at the same time'),
max_width BIGNUMERIC(38,10)
OPTIONS(description='The maximum width a resource set is allowed to have to visit this address.'),
pre_action_duration STRING(512)
OPTIONS(description='Fixed (un)loading time in seconds when loading is done at an address_1'),
pre_action_duration_unloading STRING(512)
OPTIONS(description='Fixed (un)loading time when unloading is done at an RDC only'),
additionaladdressinfo STRING(512)
OPTIONS(description='Additional information for the Address_1 set by the user e.g. tax number'),
hasuniquedefinitionperweekday BOOL
OPTIONS(description='True (not violated) if there are no RDCGlobalParameter objects that cover any of the same days of the week as this object'),
isaddressindicatoravailable BOOL OPTIONS(description='TRUE if there is indicator related to this rdc address_1'),
isclusteravailable BOOL OPTIONS(description='TRUE if there is cluster related to this rdc address_1'),
nicplacestoreid BIGNUMERIC(38,0)
OPTIONS(description='Presents which alert rules NicCompartment needs to apply when travelling to that address.'),
isemissionfree BOOL OPTIONS(description='TRUE if only emission free deliveries are allowed on this address_1'),
isexternalwarehouse BOOL OPTIONS(description='TRUE if this is an external warehouse'),
isinternalwarehouse BOOL OPTIONS(description='TRUE if this is an internal warehouse'),
isnonfoodwarehouse BOOL OPTIONS(description='TRUE if this is a non food warehouse'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, address_id, day_of_week, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='Object type in quintiq is RDCAddress');