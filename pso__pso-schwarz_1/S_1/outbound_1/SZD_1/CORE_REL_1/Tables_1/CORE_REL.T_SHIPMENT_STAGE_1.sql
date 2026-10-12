/* --------------------------------------------------------------------------------
   DDL for table: T_SHIPMENT_STAGE_1
   generated from Powerdesigner on Montag, 19. Mai 2025 08:50:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_shipment_stage_1 (
shipment_stage_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier of the shipment stage.'),
shipment_stage_name STRING(100) NOT NULL OPTIONS(description='The name of the shipment stage.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (shipment_stage_id) NOT ENFORCED
) OPTIONS(description='Minor Entity - Contains the possible stages of a shipment. - Source - Manual');