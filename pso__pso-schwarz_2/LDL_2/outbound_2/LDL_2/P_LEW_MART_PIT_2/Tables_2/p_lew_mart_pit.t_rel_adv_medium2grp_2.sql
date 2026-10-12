/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for REL_ADV_MEDIUM2GRP
#-------------------------------------------------------------------------------
# Description: Create DDL for pseudo dimension holding static medium to medium group mappings
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-03-11 Mike Davis    Initial version based on OnPrem solution.
#                                Note: this is not technically a dimension, it is
#                                a relationship table. Exact name to be determined.
#  1.1  2022-03-15 Mike Davis    Change name.
#  1.2  2022-04-01 Mike Davis    add mstr_sids for both medium and medium_grp
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
Questions:
    think about what happens if this is not found in medium: check if medium_sid -1
    ok - it's going to be inner join so if there are any typos - can check the mapping specifically that get the same records
*/

/*
VC:
MEDIUM_MSTR_SID
MEDIUM_GRP_MSTR_SID

*/


-- TECHNICAL FIELDS
 -- Versioning
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_rel_adv_medium2grp_2 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
medium_sid INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unique system ID, sid, for the medium (from T_DIM_ADV_MEDIUM_2).'),
medium_grp_sid INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unique system ID, sid, for the medium group (from T_DIM_ADV_MEDIUM_GRP_2).'),
medium_ignore_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Indicator / Flag Medium Ignore: ignore this medium in this mapping.'),
medium_delete_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Indicator / Flag Medium Delete: this medium has been technically deleted from this mapping.'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Version			NUMBER of record ; Sequence starting from 0'),
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