/* --------------------------------------------------------------------------------
   DDL for table: T_DELIVERY_NOTIFICATION_POSITION_2
   generated from Powerdesigner on Donnerstag, 15. Mai 2025 14:46:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_delivery_notification_position_2 (
internal_handling_unit_nr STRING(250) NOT NULL
OPTIONS(description='Business/Natural Key - The internal identification number of the handling unit.'),
internal_handling_unit_pos_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Business/Natural Key - The position number within the handling unit.'),
product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant.'),
packaged_base_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The packaged base quantity that is notified to be delivered.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (internal_handling_unit_nr, internal_handling_unit_pos_nr) NOT ENFORCED
)
OPTIONS(description='Bridge Table - The delivery notification position referes to a position within the handling unit_2 that will be notified to the receiver. - Source - LExIS');