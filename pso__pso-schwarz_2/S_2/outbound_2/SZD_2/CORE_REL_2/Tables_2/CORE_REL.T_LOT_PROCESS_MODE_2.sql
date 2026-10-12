/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_PROCESS_MODE_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_lot_process_mode_2 (
lot_process_mode_cd STRING(50) NOT NULL
OPTIONS(description='Processing mode defines who handles the unloading and the transport to the country_2 distribution center. '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lot_process_mode_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Processing mode defines who handles the unloading and the transport to the country_2 distribution center. When OWIM DWH is selected the container goes through the import warehouses. In other cases, the container is delivered directly to the specific countries - Source - VMT');