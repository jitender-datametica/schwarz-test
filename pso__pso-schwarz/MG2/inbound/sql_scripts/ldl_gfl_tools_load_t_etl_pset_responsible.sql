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
CREATE OR REPLACE file format etl.ff_etl_pset_responsible type = 'CSV' field_delimiter = ',' DATE_FORMAT = 'DD-MM-YYYY' skip_header = 1;


-- Create/Recreate intermediate load table to load the source data into
CREATE OR REPLACE TEMPORARY TABLE etl.t_etl_pset_responsible LIKE etl_process.t_etl_pset_responsible;

CREATE OR REPLACE STAGE GF_INTERNAL_STAGE;

PUT file://${SQL_INPUT_1}/t_etl_pset_responsible.csv @GF_INTERNAL_STAGE;

-- Import the data from the STAGE file to the load table.
COPY INTO etl.t_etl_pset_responsible 
FROM @GF_INTERNAL_STAGE/t_etl_pset_responsible.csv file_format = (format_name = etl.ff_etl_pset_responsible) on_error = ABORT_STATEMENT;


-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.
MERGE INTO etl_process.t_etl_pset_responsible AS target USING (
  SELECT 
        DIVISION
        ,PROJECT
        ,APPLICATION
        ,SYSTEM_GROUP
        ,INTERFACE
        ,PSET
        ,EMAIL_DEVELOPER
        ,EMAIL_TEAM_LEAD
        ,EMAIL_BSE
  FROM 
    etl.t_etl_pset_responsible 
  MINUS 
  SELECT 
        DIVISION
        ,PROJECT
        ,APPLICATION
        ,SYSTEM_GROUP
        ,INTERFACE
        ,PSET
        ,EMAIL_DEVELOPER
        ,EMAIL_TEAM_LEAD
        ,EMAIL_BSE
  FROM 
    etl_process.t_etl_pset_responsible
) AS source 
ON target.DIVISION = source.DIVISION 
AND target.PROJECT = source.PROJECT 
AND target.SYSTEM_GROUP = source.SYSTEM_GROUP 
AND target.INTERFACE = source.INTERFACE 
AND target.PSET = source.PSET 
WHEN matched THEN 
UPDATE 
SET 
  target.EMAIL_DEVELOPER = source.EMAIL_DEVELOPER, 
  target.EMAIL_TEAM_LEAD = source.EMAIL_TEAM_LEAD, 
  target.EMAIL_BSE = source.EMAIL_BSE 
WHEN NOT matched THEN INSERT (
        DIVISION
        ,PROJECT
        ,APPLICATION
        ,SYSTEM_GROUP
        ,INTERFACE
        ,PSET
        ,EMAIL_DEVELOPER
        ,EMAIL_TEAM_LEAD
        ,EMAIL_BSE
        ,LAST_REJECT_AT
        ,DWH_CREATED_TMSP
  ) 
VALUES 
  (
        source.DIVISION
        ,source.PROJECT
        ,source.APPLICATION
        ,source.SYSTEM_GROUP
        ,source.INTERFACE
        ,source.PSET
        ,source.EMAIL_DEVELOPER
        ,source.EMAIL_TEAM_LEAD
        ,source.EMAIL_BSE
        ,NULL
        ,CURRENT_TIMESTAMP
  );

commit;

