/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for CNTL_PROCESSING_PARAM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-30 Mike Davis      	Checks, formatting
#  1.2	2021-09-13 Massimo Morelli 	Fixed SCHEMA, added COMMIT
#  1.3  2022-02-14 Andreas Kurz		Reworked DDL 
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
PARAM_VALUE_ARRAY_NR
PARAM_VALUE_ARRAY_DESCR
*/

/*
---------------------------------------------------------------------
0. Create CNTL Table in T_CNTL_PROCESSING_PARAM
------------------------------------------------------------------------
*/


/* PARAM_VALUE_ARRAY_NR 		INTEGER		 					AS (ARRAY_SIZE(PARAM_VALUE_ARRAY)) 				COMMENT '[VC] Parameter Array Number of Values',
	PARAM_VALUE_ARRAY_DESCR 	STRING 						AS (ARRAY_TO_STRING(PARAM_VALUE_ARRAY, ',')) 	COMMENT '[VC] Parameter Array Descr comma-separated', */
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_processing_param (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='PIT Country'),
param_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Identifier for the parameter. Note a parameter is specified by the client_id, param_id pair. I.e. the same parameter can have different values for the different clients.'),
param_value BIGNUMERIC(38,5) DEFAULT 0
OPTIONS(description='Parameter numeric value of the parameter, where appropriate'),
param_value_char STRING(16777216) OPTIONS(description='Parameter character value of the parameter, where appropriate'),
param_value_array ARRAY < STRING >OPTIONS(description='Parameter Array of Values, where appropriate'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Version Number of record ; Sequence starting from 0'),
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
PRIMARY KEY (client_id, param_id, valid_from_dt, deleted_fg) NOT ENFORCED
) OPTIONS(description='Control Table - PIT processing params');