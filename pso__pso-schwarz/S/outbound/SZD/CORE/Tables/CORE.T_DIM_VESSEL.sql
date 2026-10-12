/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_VESSEL
   generated from Powerdesigner on Freitag, 2. August 2024 08:21:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_vessel (
resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the vessel'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
vessel_nr STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - Unique identifier for the vessel voyage in a source system'),
vessel_name STRING(100) NOT NULL OPTIONS(description='Natural Key/Business Key - The name of the vessel'),
voyage_name STRING(100) NOT NULL
OPTIONS(description='Natural Key/Business Key - Voyage numbers are used to identify shipments'),
loop_name STRING(100) OPTIONS(description='Descriptive Attribute - A loop is like a bus shedule for ships '),
vessel_status_cd STRING(50) NOT NULL OPTIONS(description='The status code for the vessel '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (resource_item_sid, dwh_valid_to_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - A vessel instance - a combination of ship in particular voyage going by particular root. - Source - VMT');