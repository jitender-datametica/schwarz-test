/* --------------------------------------------------------------------------------
   DDL for table: t_data_structure_size_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_data_structure_size_1 (
data_struct_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the data structure.'),
meas_tmsp TIMESTAMP NOT NULL
OPTIONS(description='A point in time, identified by a date and a time component.'),
data_struct_size_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying how the storage space for a data object is measured. E.g. compressed vs. uncompressed size'),
size_meas BIGNUMERIC(38,0)
OPTIONS(description='The size of the data object expressed in the unit_1 of measure (e.g. MB, GB, ...)'),
uom_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the unit_1 of measure.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (meas_tmsp, data_struct_size_type_cd, data_struct_sid) NOT ENFORCED
) OPTIONS(description='This entity tracks the physical size of a data structure (e.g. a table) over time.');