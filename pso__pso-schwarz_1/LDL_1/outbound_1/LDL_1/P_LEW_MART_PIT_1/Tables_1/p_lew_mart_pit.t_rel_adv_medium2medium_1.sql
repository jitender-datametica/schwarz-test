/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for REL_ADV_MEDIUM2MEDIUM
#-------------------------------------------------------------------------------
# Description: Create DDL for pseudo dimension holding static medium to main medium mappings.
#              It maps all media found in ADP having a similar name to one main medium (to the one with the min. MEDIUM_SID).
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-09-10 Dirk Hering      Initial version
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
MEDIUM_MSTR_SID
MAIN_MEDIUM_MSTR_SID


*/


-- Versioning
 -- TECHNICAL FIELDS
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_rel_adv_medium2medium_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
medium_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique system ID, sid, for the medium (ADP Channel SID).'),
medium_name STRING(16777216) DEFAULT 'Sonstige' NOT NULL
OPTIONS(description='(short) medium name in local language: first version to be found in ADP, case insensitive (trimmed) - the one displayed'),
medium_reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='For the medium: Flag indicates if the record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
medium_reject_reason_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='For the medium: Link to DQ Reject Reason Codes'),
main_medium_sid INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unique system ID, sid, for the main medium (ADP Channel SID).'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Version           NUMBER of record ; Sequence starting from 0'),
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
PRIMARY KEY (client_id, medium_sid, main_medium_sid, valid_from_dt, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Intially loaded with Medium Static Data and then added with new Media from ADP by daily load');