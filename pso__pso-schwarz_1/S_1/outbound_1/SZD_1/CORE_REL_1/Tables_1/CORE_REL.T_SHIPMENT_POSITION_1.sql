/* --------------------------------------------------------------------------------
   DDL for table: T_SHIPMENT_POSITION_1
   generated from Powerdesigner on Montag, 19. Mai 2025 09:10:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_shipment_position_1 (
delivery_nr STRING(250) NOT NULL OPTIONS(description='Business/Natural key - The business identifier of the delivery.'),
shipment_nr STRING(250) NOT NULL OPTIONS(description='The unique identifier of the shipment.'),
shipment_position_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique position number of the shipment.'),
created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp when the shipping order position was created in the source system.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (delivery_nr, shipment_nr) NOT ENFORCED
)
OPTIONS(description='Bridge Table - Contains shipping order positions. A shipping order positiion is delivery that is part of the shipping order.');