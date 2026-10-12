/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_VESSEL_STATUS_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_vessel_status_2 (
vessel_status_cd STRING(50) NOT NULL OPTIONS(description='Natural Key/Business Key  - The status_2 code for the vessel '),
vessel_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the status_2 code  written out in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (vessel_status_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - The minor dimension that contains the list of possible values for vessel status. - Source - VMT');