/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_ERROR_2
   generated from Powerdesigner on Freitag, 17. November 2023 13:48:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charge_point_error_2 (
error_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique ID of the occured error.'),
charger_provider_system_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger provider system.'),
charger_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item.'),
charge_point_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charge point.'),
charge_point_error_definition_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key of the error definition.'),
charging_station_owner_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charging station owner.'),
created_at_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Technical timestamp when this record was created in the source.'),
occurance_dt DATE NOT NULL OPTIONS(description='The date when the error has occured.'),
user_required_on_site_fg BOOL NOT NULL
OPTIONS(description='Flag indicating whether the user was required to be in site.'),
technician_required_on_site_fg BOOL NOT NULL
OPTIONS(description='Flag indicating whether a technician was required to be in site.'),
maintenance_window_active_fg BOOL NOT NULL
OPTIONS(description='Flag indicating whether the mainenance window was active.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (error_nr) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - Transactional fact capturing an event when an error is encountered at one of the chargepoints/charger. - Source - IOTCharger');