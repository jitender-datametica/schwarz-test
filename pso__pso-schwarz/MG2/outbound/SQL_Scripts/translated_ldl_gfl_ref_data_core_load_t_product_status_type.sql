/*   Load the product_status_type CSV file into the data warehouse. */ /*   1. Copy the source file into a Snowflake STAGE. */ /*   2. Import the stage file into a load table. */ /*   3. Apply changes in data to data warehouse table: */ /*      a) Update any changes attributes where row already exists in the data warehouse table. */ /*      b) Insert any new rows from source where they did not already exist in the data warehouse table. */ /*      Note: Deleted records in the source data ARE NOT DELETED from the target table. */ /*   Colin Williams, December 2022. */ /* Create a Snowflake FILE FORMAT object to descrribe the source data */ /* No target-dialect support for source-dialect-specific CREATE FILE FORMAT */ /* Create/Recreate intermediate load table to load the source data into */
CREATE OR REPLACE TABLE etl.t_product_status_type;

ALTER TABLE etl.t_product_status_type
DROP COLUMN dwh_created_tmsp /* Technical fields are not required in the load table. */;

ALTER TABLE etl.t_product_status_type
DROP COLUMN dwh_updated_tmsp;

ALTER TABLE etl.t_product_status_type
DROP COLUMN dwh_load_id;

ALTER TABLE etl.t_product_status_type
DROP COLUMN dwh_node_cd;

MERGE INTO core_rel.t_product_status_type AS target
USING (
  SELECT
    prod_status_type_id,
    lang_cd,
    prod_status_type_descr,
    current_timestamp() AS dwh_created_tmsp,
    current_timestamp() AS dwh_updated_tmsp,
    ${load_id} AS dwh_load_id,
    'MANUAL' AS dwh_node_cd
  FROM etl.t_product_status_type
  EXCEPT DISTINCT
  SELECT
    prod_status_type_id,
    lang_cd,
    prod_status_type_descr,
    current_timestamp() AS dwh_created_tmsp,
    current_timestamp() AS dwh_updated_tmsp,
    ${load_id} AS dwh_load_id,
    'MANUAL' AS dwh_node_cd
  FROM core_rel.t_product_status_type
) AS source
ON target.prod_status_type_id = source.prod_status_type_id
AND target.lang_cd = source.lang_cd
WHEN MATCHED THEN UPDATE SET
  prod_status_type_descr = source.prod_status_type_descr,
  dwh_updated_tmsp = current_timestamp(),
  dwh_load_id = ${load_id},
  dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT (
  prod_status_type_id,
  lang_cd,
  prod_status_type_descr,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
) VALUES (
  source.prod_status_type_id,
  source.lang_cd,
  source.prod_status_type_descr,
  current_timestamp(),
  current_timestamp(),
  source.${load_id},
  'MANUAL'
) /* Import the data from the STAGE file to the load table. */ /* COPY INTO etl.t_product_status_type 
FROM @datastore.stg_dlssdsprldll201_gfl_initial_data/ files=('product_status_type.csv') file_format = (format_name = etl.t_product_status_type) on_error = ABORT_STATEMENT; */ /* Apply the changes as INSERTs or UPDATES ignoring any unchanged rows. */;

COMMIT TRANSACTION;