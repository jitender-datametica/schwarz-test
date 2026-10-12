CREATE OR REPLACE TABLE biaid_tools_projects_production_fe_mstr_timesheets.t_timesheet_entry (
dwh_timesheet_entry_uuid STRING(40) NOT NULL
OPTIONS(description='Universally unique identifier - identifying the timesheet entry row. Can be used for exports and reimports of editted version of a row, without exposing the PK'),
timesheet_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artificially Generated | Unique identifier of the timesheet. All entries within a single timesheet have the same timesheet_sid value'),
psp_element_cd STRING(50) NOT NULL
OPTIONS(description='SrcFile.PSP-Element | Code of the PSP element to which the efforts are booked'),
project_task_cd STRING(50) NOT NULL
OPTIONS(description='SrcFile.ID-Nummer | Code of the task/work package to which the efforts are booked'),
task_subject STRING(255)
OPTIONS(description='SrcFile.Benennung | Name/Subject of the task/work package to which the efforts are booked'),
bs_its_cd STRING(50) OPTIONS(description='SrcFile.Log_BS_ITS |  Code of the business/IT solution'),
leer1 STRING(255) OPTIONS(description='empty. reserved for future use'),
leer2 STRING(255) OPTIONS(description='empty. reserved for future use'),
timesheet_entry_dt DATE NOT NULL
OPTIONS(description='SrcFile.Datum | Date for which the efforts are booked (when the actual work was done)'),
work_duration_hours BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='SrcFile.Stunden | Duration of the booked efforts in hours ( 1.50 means 90 mins)'),
work_location_cd STRING(50) NOT NULL
OPTIONS(description='SrcFile.Onsite/Ofsite | Value indicating if the work was done onsite or offsite'),
external_employee_comment_txt STRING(1000)
OPTIONS(description='SrcFile.Tätigkeitsbeschreibung |  Notes from the external employee attached to the effort booking'),
department_name STRING(50) OPTIONS(description='SrcFile.Abteilung | Department for which this external employee works'),
team_name STRING(50) OPTIONS(description='SrcFile.Team | Team for which this external employee works'),
quota_order_nr STRING(50)
OPTIONS(description='MISSING - should be in SrcFile.Bestellung | Number of the quota order for manpower'),
external_employee_full_name STRING(100) NOT NULL
OPTIONS(description='SrcFile.Name | Full name of the external employee'),
external_supplier_name STRING(100) NOT NULL
OPTIONS(description='SrcFile.Log_DL | name of the company that provides external employees'),
timesheet_entry_status STRING(25)
OPTIONS(description='Set from MSTR/AbIntiio | Status of the timesheet entry (submitted, approved, rejected, exported, corrected)'),
intended_approver_name STRING(100)
OPTIONS(description='MISSING - should be in SrcFile | Name of the solution expert who should (approve/reject) the timesheet entry'),
actual_approver_name STRING(100)
OPTIONS(description='Set from MSTR | Name of the solution expert who actually approved/rejected the timesheet entry'),
actual_approver_comment_txt STRING(500)
OPTIONS(description='Set from MSTR | Comments set by solution expert (usually when rejecting a record)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='System Filed | Point in time when this row was created in the database'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='System Filed | Point in time of the last update of this record'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='System Filed | Name of the source file from which this record is imported'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='System Filed | timestamp (date created) of the source file for this record.'),
PRIMARY KEY (dwh_timesheet_entry_uuid) NOT ENFORCED
)
OPTIONS(description='Table contains one row per every time sheet records (entry) booked on a project in Schwarz Group');