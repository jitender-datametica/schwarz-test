CREATE OR REPLACE VIEW ldl_data_production_meta.v_environment (env_cd
OPTIONS(description='The code which identifies the (development / test / production / ...) environment.'), env_name
OPTIONS(description='The name of the i(development / test / production / ...) environment.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `DEVELOPMENT, TEST AND PRODUCTION CAN BE SEPARATED BY USING DIFFERENT ENVIRONMENTS.`) AS SELECT
 env_cd,
 env_name,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_environment
UNION DISTINCT
SELECT '@',
 'Unknown environment',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';