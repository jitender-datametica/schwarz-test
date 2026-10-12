CREATE OR REPLACE TABLE ldl_data_production_meta.t_solution (
solution_cd STRING(20) NOT NULL OPTIONS(description='The code which identifies the solution.'),
solution_name STRING(100) OPTIONS(description='The name by which the solution is known.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (solution_cd) NOT ENFORCED
)
OPTIONS(description='A solution is an organizational unit which is responsible for the collaboration of business and IT. A solution is responsible for handling data quality issues. It decides on the required steps to resolve the issue and to correct the data, as well as on measures that will prevent the problem from occurring again.');