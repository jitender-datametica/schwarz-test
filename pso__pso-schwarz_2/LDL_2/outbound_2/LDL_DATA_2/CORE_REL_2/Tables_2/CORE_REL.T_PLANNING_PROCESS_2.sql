/* --------------------------------------------------------------------------------
   DDL for table: t_planning_process_2
   generated from Powerdesigner on Mittwoch, 11. September 2024 11:03:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_planning_process_2 (
planning_process_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the planning process.'),
planning_process_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the planning process.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (planning_process_cd) NOT ENFORCED
)
OPTIONS(description='A planning process is an administrative activity which defines a set of planned values. E.g. the short-term staff planning in stores or the annual planning for the next business year. The same type of value (e.g. net revenue) can be planned by several planning processes, however for the model these are different planned value types. I.e. each value is planned by exactly one planning process.');