/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PASSENGER_TYPE_CLUSTER_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 25. Oktober 2022 10:38:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_passenger_type_cluster_2 (
passenger_type_cluster_cd STRING(25) NOT NULL
OPTIONS(description='The code for the categorization of passanger based on their age and gender ( Single traveler , Small Family , etc)'),
passenger_type_cluster_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for thecategorization of passanger based on their age and gender ( Single traveler , Small Family , etc)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (passenger_type_cluster_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the categorization of passanger based on their age and gender ( Single traveler , Small Family , etc)');