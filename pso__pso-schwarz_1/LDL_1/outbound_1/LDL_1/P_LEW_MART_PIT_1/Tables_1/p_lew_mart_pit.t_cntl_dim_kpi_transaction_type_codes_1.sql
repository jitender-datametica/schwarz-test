/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_DIM_KPI_TRANSACTION_TYPE_CODES_1
#-------------------------------------------------------------------------------
# Description: Create DDL for Control Table - Lookup PIT KPIs list of Transactiontype Codes
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-09-14 Andreas Kurz    	Initial version
#  1.1  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
TRANSACTION_TYPE_CD_NR
TRANSACTION_TYPE_CD_DESCR
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_dim_kpi_transaction_type_codes_1 (
kpi_sid INTEGER NOT NULL OPTIONS(description='Autoincrement (0,1)'),
kpi_name STRING(150) NOT NULL OPTIONS(description='KPI Name'),
transaction_type_cd ARRAY < STRING >OPTIONS(description='Array of UPI Columns of the associated table'),
transaction_type_cd_descr STRING(16777216)
OPTIONS(description='String representation of UPI Array with comma separator'),
sf_table_name STRING(150) DEFAULT 'T_CNTL_DIM_KPI_TRANSACTION_TYPE_CODES_1' NOT NULL
OPTIONS(description='SFTable name of Source Table. Could be also a Source View from S2T Mapping. '),
sf_schema_name STRING(150) DEFAULT 'p_lew_mart_pit_1' NOT NULL OPTIONS(description='SF Schema Name of Aggregation '),
sf_database_name STRING(150) DEFAULT 'ldl' NOT NULL OPTIONS(description='SF Database Name'),
sf_warehouse_name STRING(150) DEFAULT 'N/A' NOT NULL OPTIONS(description='SF Warehouse Name'),
annotation STRING(1500) OPTIONS(description='Further annotation'),
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
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / AB>Initio Process ID'),
PRIMARY KEY (kpi_sid, valid_from_dt, deleted_fg) NOT ENFORCED
) OPTIONS(description='Control Table - Lookup PIT KPI Transaction Codes Mapping.');