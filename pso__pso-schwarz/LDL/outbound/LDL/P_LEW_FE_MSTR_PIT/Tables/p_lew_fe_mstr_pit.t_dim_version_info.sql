/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_VERSION_INFO
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Adv.Period Dimension Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-18 Mike Davis      	Checks, formatting
#  1.2  2021-09-13 Massimo Morelli 	Fixed SCHEMA, added COMMIT
#  1.8  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0	2022-04-12 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC. 
#-------------------------------------------------------------------------------
*/

/*
VC:
PIT_ENVIRONMENT_LONG_DESCR
VERSION_NBR_DESCR
VERSION_INFO_LONG_DESCR

*/


-- [View] Relevant Columns will be filled in View! Just mentioned here so that we have Column 						COMMENTs

-- Versioning
 -- Technical fields
 CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_dim_version_info (
version_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Version DATE'),
major_nbr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Major Version NUMBER'),
minor_nbr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Minor Version NUMBER'),
build_nbr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='[Optional] Daily Build NUMBER'),
revision_nbr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='[Optional] Revision NUMBER'),
pit_environment_descr STRING(2) DEFAULT 'SF' NOT NULL
OPTIONS(description='Environment info TD ::= Teradata and SF::=Snowflake'),
version_info_descr STRING(16777216) OPTIONS(description='Version Info Description'),
fe_mstr_relevant_fg INTEGER DEFAULT 1 NOT NULL OPTIONS(description='Flag indicates if used on FE_MSTR'),
current_pit_version_fg INTEGER DEFAULT 0 NOT NULL,
current_pit_verion_fg INTEGER DEFAULT 0
OPTIONS(description='Indicator / Flag if the current PIT Version based on current day'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Version NUMBER of record ; Sequence starting from 0'),
current_fg INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Technical Field 1 indicates the current record in case of several version'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (version_dt, valid_from_dt, fe_mstr_relevant_fg, deleted_fg) NOT ENFORCED
) OPTIONS(description='Dimension table for PIT Version Information');