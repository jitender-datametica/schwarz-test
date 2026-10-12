/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_MILESTONE_RESULT_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_lot_milestone_result_2 (
lot_milestone_result_cd STRING(50) NOT NULL
OPTIONS(description='A milestone is an event in the lot lifecycle. Table contains the list of the possible events'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lot_milestone_result_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - A milestone is an event in the lot lifecycle. Table contains the list of the result of possible events.  -  Source - VMT');