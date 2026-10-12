/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_INCIDENT_TYPE_2
   generated from Powerdesigner on Donnerstag, 9. November 2023 13:46:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charge_incident_type_2 (
charge_incident_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the charge incident type.'),
charge_incident_type_descr STRING(250) NOT NULL OPTIONS(description='A brief description of the incident.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (charge_incident_type_id) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Defines the possible types of incidents that can happen when charging a car. - Source - IOTCharger');