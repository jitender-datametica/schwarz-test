CREATE OR REPLACE TABLE ldl_data_production_meta.t_scheduling_unit (
scheduling_unit_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the group of ETL jobs that are always executed together.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
scheduling_unit_name STRING(100) NOT NULL OPTIONS(description='The name of the scheduling unit in the ETL tool.'),
scheduling_unit_descr STRING(250)
OPTIONS(description='A textual description of the scheduling unit, detailing its purpose and structure.'),
scheduling_freq_cd STRING(20) NOT NULL
OPTIONS(description='A code defining, how often a scheduling unit is executed. E.g daily, weekly, ...'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (scheduling_unit_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='A scheduling unit is a group of ETL jobs which are always executed together.');