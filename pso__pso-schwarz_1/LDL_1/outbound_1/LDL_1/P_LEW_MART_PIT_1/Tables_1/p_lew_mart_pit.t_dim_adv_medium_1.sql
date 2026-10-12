/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_MEDIUM
#-------------------------------------------------------------------------------
# Description: Create DDL for dimension holding static+dynamic(adp) medium entries
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-10-01 Aparna Rayanki    Initial version
#  1.1  2022-03-04 Mike Davis        Make SID MD5
#                                    Add MEDIUM_DISPLAY_NAME
#                                    Move name so that it can be processed re. MD5
#  1.2  2022-03-09 Mike Davis        Use SELECT ' section' AS ""
#  1.3  2022-03-23 Mike Davis        Add Coalesce to the md5 calculation
#  1.4  2022-04-01 Mike Davis        Add mstr_sid
#  1.5  2022-04-04 Mike Davis        Adapt to '{MEDIUM_NOT_DEFINED}'
#  1.6  2022-05-02 Mike Davis        Adapt to 'Kein Werbemedium definiert'
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
Questions:
    create or replace
    what about create or replace?
   	DEFAULT of 127: maybe higher now?
    do we need a Sonstige medium for each client (see initialize script)?
    If so, should the sort value for this be different from the	DEFAULT?
*/
/*
VC:
MEDIUM_NAME_UPPER
MEDIUM_MSTR_SID

*/


-- Versioning
 -- BUSINESS KEY
 -- TECHNICAL KEYS
 -- TECHNICAL FIELDS
 -- DATA
 CREATE TABLE IF NOT EXISTS
ldl_p_lew_mart_pit.t_dim_adv_medium_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3),
country_descr STRING(16777216),
medium_name STRING(16777216) DEFAULT 'Sonstige' NOT NULL
OPTIONS(description='(short) medium name in local language: first version to be found case insensitive (trimmed) - the one displayed'),
medium_name_ldescr STRING(16777216)
OPTIONS(description='Concatenate medium name + medium code in local language: for debugging purposes'),
medium_sid INTEGER DEFAULT - 1000 NOT NULL OPTIONS(description='[Unique system ID, sid, for the medium.'),
medium_sort_val INTEGER DEFAULT 127 NOT NULL OPTIONS(description='internal sorting value for the medium'),
missing_medium_fg INTEGER DEFAULT 0 NOT NULL,
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
source_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, medium_sid, valid_from_dt, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Intially loaded with Medium Static Data and then added with new Media from ADP by daily load');