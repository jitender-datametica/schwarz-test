/* --------------------------------------------------------------------------------
   DDL for table: t_user_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_meta.t_user_2 (
user_name STRING(100) NOT NULL OPTIONS(description='The name by which the user is identified on the system.'),
emp_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the employee_2 who owns this user.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (user_name) NOT ENFORCED
)
OPTIONS(description='A user is an account_2 on the data warehouse that allows to use the system. (Not every user is assigned to a single physical person.)');