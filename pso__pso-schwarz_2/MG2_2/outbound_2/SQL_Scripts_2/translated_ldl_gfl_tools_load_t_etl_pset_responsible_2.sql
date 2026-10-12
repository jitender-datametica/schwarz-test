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
-- CREATE OR REPLACE file format etl.ff_etl_pset_responsible type = 'CSV' field_delimiter = ',' DATE_FORMAT = 'DD-MM_2-YYYY' skip_header = 1;


-- Create/Recreate intermediate load table to load the source data into


CREATE OR REPLACE TEMPORARY TABLE t_etl_pset_responsible_2 (
division STRING(20) NOT NULL,
project STRING(100) NOT NULL,
application STRING(50),
system_group STRING(50),
interface STRING(100),
pset STRING(200) NOT NULL,
email_developer STRING(100) NOT NULL,
email_team_lead STRING(100),
email_bse STRING(100),
last_reject_at DATETIME,
dwh_created_tmsp DATETIME
);


-- CREATE OR REPLACE STAGE GF_INTERNAL_STAGE;

-- PUT file://${SQL_INPUT_1}/t_etl_pset_responsible.csv @GF_INTERNAL_STAGE;

-- -- Import the data from the STAGE file to the load table.
-- COPY INTO LDL_DATA_PRODUCTION.etl.t_etl_pset_responsible_2 
-- FROM @GF_INTERNAL_STAGE/t_etl_pset_responsible.csv file_format = (format_name = etl.ff_etl_pset_responsible) on_error = ABORT_STATEMENT;


-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.


MERGE INTO t_etl_pset_responsible_2 AS target
USING (SELECT division,
   project,
   application,
   system_group,
   interface,
   pset,
   email_developer,
   email_team_lead,
   email_bse
  FROM t_etl_pset_responsible_2
  EXCEPT DISTINCT
  SELECT division,
   project,
   application,
   system_group,
   interface,
   pset,
   email_developer,
   email_team_lead,
   email_bse
  FROM t_etl_pset_responsible_2) AS t1_2
ON target.division = t1.division AND target.project = t1.project AND target.system_group = t1.system_group AND target.interface
    = t1.interface AND target.pset = t1.pset
WHEN MATCHED THEN UPDATE SET
 email_developer = t1.email_developer,
 email_team_lead = t1.email_team_lead,
 email_bse = t1.email_bse
WHEN NOT MATCHED THEN INSERT VALUES(t1.division, t1.project, t1.application, t1.system_group, t1.interface, t1.pset, t1_2
 .email_developer, t1.email_team_lead, t1.email_bse, CAST(NULL AS DATETIME), CURRENT_TIMESTAMP());


-- commit;