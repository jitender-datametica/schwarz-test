/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_TRANSPORT_STATUS
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_lot_transport_status (
lot_transport_status_cd STRING(50) NOT NULL
OPTIONS(description='Status of lot transport name (e.g. could be also delayed)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lot_transport_status_cd) NOT ENFORCED
) OPTIONS(description='Minor Entity -  Status of lot transport (e.g. could be also delayed)  - Source - VMT');