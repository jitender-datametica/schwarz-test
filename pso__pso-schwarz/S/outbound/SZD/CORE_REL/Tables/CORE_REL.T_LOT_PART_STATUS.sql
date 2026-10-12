/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_PART_STATUS
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_lot_part_status (
lot_part_status_cd STRING(50) NOT NULL OPTIONS(description='The status code for the lot part'),
lot_part_status_descr STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - A textual description for the status code.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lot_part_status_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - The minor dimension that contains the list of possible values for lot status  - Source - VMT');