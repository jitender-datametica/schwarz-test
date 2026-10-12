/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_UNIT
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_unit (
unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the unit (e.g. material unit, production line parameter)'),
unit_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key - Unit code as a technical identifier of the unit from the source system or manually maintained (e.g. C for Celsius degree, Kg for Kilogramm, URGENT for Urgency in Days)'),
unit_name STRING(100) NOT NULL OPTIONS(description='Full name of the unit (e.g. celsius degree, Prio, Urgency in days)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (unit_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - with units (e.g. plastic materials, production line parameter). The unit in which a quantity is expressed. This includes mostly physical units, such as kilogram, meters or seconds, but also units such as slices or pieces. Source - Partially manual');