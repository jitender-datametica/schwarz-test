--
--   Load the brand_type CSV file into the data warehouse.
--
--   1. Copy the source file into a Snowflake STAGE.
--   2. Import the stage file into a load table.
--   3. Apply changes in data to data warehouse table:
--      a) Update any changes attributes where row already exists in the data warehouse table.
--      b) Insert any new rows from source where they did not already exist in the data warehouse table.
--      Note: Deleted records in the source data ARE NOT DELETED from the target table.
--
--   Colin Williams, December 2022.
--

-- Create a Snowflake FILE FORMAT object to descrribe the source data
--CREATE OR REPLACE file format etl.t_tax_type type = 'CSV' field_delimiter = ';' DATE_FORMAT = 'DD-MM-YYYY' skip_header = 1;


-- Create/Recreate intermediate load table to load the source data into


CREATE OR REPLACE TABLE ldl_data_production_etl.t_tax_type LIKE ldl_data_production_core_rel.t_tax_type;


-- Technical fields are not required in the load table.


ALTER TABLE ldl_data_production_etl.t_tax_type
DROP COLUMN IF EXISTS dwh_created_tmsp;


ALTER TABLE ldl_data_production_etl.t_tax_type
DROP COLUMN IF EXISTS dwh_updated_tmsp;


ALTER TABLE ldl_data_production_etl.t_tax_type
DROP COLUMN IF EXISTS dwh_load_id;


ALTER TABLE ldl_data_production_etl.t_tax_type
DROP COLUMN IF EXISTS dwh_node_cd;


-- Import the data from the STAGE file to the load table.
/*COPY INTO LDL_DATA_PRODUCTION.etl.t_tax_type 
FROM @datastore.stg_dlssdsprldll201_gfl_initial_data/common/int/ files=('tax_type.csv') file_format = (format_name = etl.t_tax_type) on_error = ABORT_STATEMENT;*/


-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.


MERGE INTO ldl_data_production_core_rel.t_tax_type AS target
USING (SELECT tax_type_cd,
   lang_cd,
   tax_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_etl.t_tax_type
  EXCEPT DISTINCT
  SELECT tax_type_cd,
   lang_cd,
   tax_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_core_rel.t_tax_type) AS t1
ON target.tax_type_cd = t1.tax_type_cd AND target.lang_cd = t1.lang_cd
WHEN MATCHED THEN UPDATE SET
 tax_type_descr = t1.tax_type_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = CAST(${LOAD_ID} AS INTEGER),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT VALUES(t1.tax_type_cd, t1.lang_cd, t1.tax_type_descr, CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(), CAST(${LOAD_ID} AS INTEGER), 'MANUAL');


COMMIT TRANSACTION;