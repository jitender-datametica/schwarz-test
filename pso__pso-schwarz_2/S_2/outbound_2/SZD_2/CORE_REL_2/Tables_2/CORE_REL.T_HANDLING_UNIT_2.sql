/* --------------------------------------------------------------------------------
   DDL for table: T_HANDLING_UNIT_2
   generated from Powerdesigner on Mittwoch, 21. Mai 2025 14:12:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_handling_unit_2 (
internal_handling_unit_nr STRING(250) NOT NULL
OPTIONS(description='Business / Natural Key - The unique identification number of the handling unit.'),
event_dt DATE NOT NULL OPTIONS(description='The date of a change event.'),
delivery_nr STRING(250) NOT NULL OPTIONS(description='Business/Natural key - The business identifier of the delivery.'),
packaging_material_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the packaging material as used in the source system.'),
packaging_material_type_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - A description text of the specific type of the packaging material.'),
first_external_handling_unit_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The first external identification number of the handling unit.'),
second_external_handling_unit_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The second external identification number of the handling unit.'),
shipping_point_cd STRING(50)
OPTIONS(description='Descriptive Attribute - The code of the shipping point. This is the location_2 from which the goods are dispatched.'),
created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp when the handling unit_2 was created in the business system.'),
updated_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the handling unit_2 was updated in the business system.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (internal_handling_unit_nr, event_dt) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - A handling unit_2 is a physical unit_2 consisting of packaging materials and the goods contained within. It combines product and packaging information under a unique identification number for easier tracking. - Source - LExIS');