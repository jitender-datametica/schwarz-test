CREATE OR REPLACE TABLE p_lew_mart_pit.t_cntl_dim_processing_param (
param_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Identifier for the parameter. Note a parameter is specified by the client_id, param_id pair. I.e. the same parameter can have different values for the different clients.'),
param_name STRING(16777216) DEFAULT 'N/A' NOT NULL OPTIONS(description='Parameter name in local LANGUAGE'),
param_descr STRING(16777216) OPTIONS(description='Parameter description in local LANGUAGE'),
param_column_datatype STRING(16777216) DEFAULT 'STRING' NOT NULL
OPTIONS(description='Data type specifier for the parameter (e.g.: TEXT, DATE, TIME, TIMESTAMP, FLOAT64, NUMBER)'),
abinitio_exec_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='ABInitio Execution Flag / Indicator, 1::= Parameter is used also for ABInitio Injection'),
abinitio_param_name STRING(16777216) OPTIONS(description='ABInitio Parameter Name'),
valid_from_dt DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Technical field Data Historization Valid to'),
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
PRIMARY KEY (param_id, valid_from_dt, deleted_fg) NOT ENFORCED
) OPTIONS(description='Control Table - Lookup PIT processing params');