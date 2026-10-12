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
CREATE OR REPLACE file format etl.t_tax_type type = 'CSV' field_delimiter = ';' DATE_FORMAT = 'DD-MM-YYYY' skip_header = 1;


-- Create/Recreate intermediate load table to load the source data into
CREATE OR REPLACE TABLE etl.t_tax_type LIKE core_rel.t_tax_type;

-- Technical fields are not required in the load table.
ALTER TABLE etl.t_tax_type DROP COLUMN dwh_created_tmsp;
ALTER TABLE etl.t_tax_type DROP COLUMN dwh_updated_tmsp;
ALTER TABLE etl.t_tax_type DROP COLUMN dwh_load_id;
ALTER TABLE etl.t_tax_type DROP COLUMN dwh_node_cd;


-- Import the data from the STAGE file to the load table.
COPY INTO etl.t_tax_type 
FROM @datastore.stg_dlssdsprldll201_gfl_initial_data/common/int/ files=('tax_type.csv') file_format = (format_name = etl.t_tax_type) on_error = ABORT_STATEMENT;


-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.
MERGE INTO core_rel.t_tax_type AS target USING (
  SELECT 
    tax_type_cd, 
    lang_cd, 
    tax_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    etl.t_tax_type 
  MINUS 
  SELECT 
    tax_type_cd, 
    lang_cd, 
    tax_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    core_rel.t_tax_type
) AS source ON target.tax_type_cd = source.tax_type_cd 
AND target.lang_cd = source.lang_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.tax_type_descr = source.tax_type_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    tax_type_cd, 
    lang_cd, 
    tax_type_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.tax_type_cd, 
    source.lang_cd, 
    source.tax_type_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );

commit;

