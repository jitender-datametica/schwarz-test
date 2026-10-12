/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_HOUSEKEEPING_PARAM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for configuration for the old data cleanup table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-05-10 Nikolai Toknov    	Initial version
#-------------------------------------------------------------------------------
*/

/*
---------------------------------------------------------------------
0. Create CNTL Table in T_CNTL_HOUSEKEEPING_PARAM
------------------------------------------------------------------------
*/


-- VERSION_NR 					INTEGER		 		NOT NULL 	DEFAULT 0 										COMMENT 'Technical Field: Version Number of record ; Sequence starting from 0',

CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_housekeeping_param (
sf_schema STRING(16777216) NOT NULL OPTIONS(description='SF Schema'),
sf_table_name STRING(16777216) NOT NULL OPTIONS(description='SF Table Name'),
housekeeping_param STRING(16777216) OPTIONS(description='Parameters for deleting records in the table'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
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
PRIMARY KEY (sf_schema, sf_table_name, valid_from_dt) NOT ENFORCED
) OPTIONS(description='Control Table - PIT housekeeping params');


/*TO DO:
- validate columns name
- add column like type of data (PV/FA) (?)
*/