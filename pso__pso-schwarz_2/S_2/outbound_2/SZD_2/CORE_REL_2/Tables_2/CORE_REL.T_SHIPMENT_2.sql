/* --------------------------------------------------------------------------------
   DDL for table: T_SHIPMENT_2
   generated from Powerdesigner on Mittwoch, 21. Mai 2025 13:12:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_shipment_2 (
shipment_nr STRING(250) NOT NULL OPTIONS(description='The unique identifier of the shipment.'),
event_dt DATE NOT NULL OPTIONS(description='The date of a change event.'),
shipment_stage_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier of the shipment stage.'),
hauler_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hauler company.'),
external_identification_nr STRING(250)
OPTIONS(description='The external identification number (for example from a system of the external carrier).'),
shipment_transport_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the transport of the shipment has ended.'),
created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp when the record was created in the source system.'),
updated_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the record was last updated in the source system.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (shipment_nr, event_dt) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - Stores detailed information about a shipment. - Source - LExIS');