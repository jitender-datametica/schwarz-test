/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_BUYING_PRICE_RANGE
#-------------------------------------------------------------------------------
# Description: Create DDL for Buying Price Range Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-16 Dirk Hering     	Fixes, formatting
#  1.2  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/


-- Versioning
 /* UWG */ -- Technical fields
 /* WGI */ CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_buying_price_range
(
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g 23'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(100) DEFAULT 'N/A' OPTIONS(description='Country Name'),
src_itemgrp_int_cd STRING(16777216) OPTIONS(description='WGI - Code'),
item_grp_int_name STRING(16777216) OPTIONS(description='WGI-Name but mind only for INTEGER . Describptions ::= DE'),
src_subitemgrp_cd STRING(16777216) OPTIONS(description='UWG - Code'),
sub_item_grp_name STRING(16777216) OPTIONS(description='UWG-Name but mind only for INTEGER . Describptions ::= DE'),
buy_price_range_days INTEGER DEFAULT - 1 OPTIONS(description='Buying Price Range in days – defined by controlling'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 OPTIONS(description='Technical Field: Version NUMBER of record ; Sequence starting from 0'),
current_fg INTEGER DEFAULT 1
OPTIONS(description='Technical Field 1 indicates the current record in case of several version'),
reject_fg INTEGER DEFAULT 0
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT 0 OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME)
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, valid_from_dt, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Lookup table Action Type IDs');