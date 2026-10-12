CREATE OR REPLACE TABLE ldl_data_production_etl.t_planning_process_1 (
planning_process_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the planning process.'),
planning_process_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the planning process.')
);