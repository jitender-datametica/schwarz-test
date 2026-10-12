/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDLs for T_CNTL_DIM_APPLICATION structures.
#-------------------------------------------------------------------------------
# Description: 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-10-25 Nikolai Toknov    	Initial version
#-------------------------------------------------------------------------------
*/


-- Technical fields
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_dim_application (
application_name STRING(16777216) DEFAULT 'PITonCloud' NOT NULL
OPTIONS(description='General name of the application (see ETL_LOGGING_RUN_SEQ) Name of Application --> Module --> Component'),
application_descr STRING(16777216) DEFAULT 'PITonCloud' NOT NULL OPTIONS(description='Annotation further Description'),
application_cntr_table_prefix STRING(16777216) DEFAULT '' NOT NULL
OPTIONS(description='The prefix indicating which CNTR tables should be used. For example, the prefix PSNF_ for the table  T_CNTL_PSNF_PROCESSING_PARAM_NORMALIZED'),
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
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (application_name, valid_from_dt) NOT ENFORCED
) OPTIONS(description='Control Table - Lookup Applicaton System');