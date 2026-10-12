/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_INCIDENT_1
   generated from Powerdesigner on Freitag, 17. November 2023 10:01:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charge_incident_1 (
agreement_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the event.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
charger_provider_system_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger provider system.'),
charger_resource_item_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the resource item.'),
charge_point_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charge point.'),
charge_incident_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the charge incident type.'),
incident_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Technical key of the incident.'),
incident_name STRING(1000) OPTIONS(description='The name of the incident.'),
incident_descr STRING(10000) OPTIONS(description='A brief description of the incident given by the caller.'),
incident_dt DATE NOT NULL OPTIONS(description='The date when the incident was filed.'),
created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Technical timestamp when this record was created in the source'),
total_edit_duration_sec BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Total time needed for the processing in seconds.'),
escalated_fg BOOL NOT NULL OPTIONS(description='Flag indicating whether the incident was escalated.'),
car_brand_name STRING(100) OPTIONS(description='Descriptive Attribute - The name of the car brand.'),
client_name STRING(100) NOT NULL OPTIONS(description='The name of the client.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (agreement_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity- Contains the incidents reported by users of a charging station when any kind of problem has occurred while charging the car. - Source - IOTCharger');