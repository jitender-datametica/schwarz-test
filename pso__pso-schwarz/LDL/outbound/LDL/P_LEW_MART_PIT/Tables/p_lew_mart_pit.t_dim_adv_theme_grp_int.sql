/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_THEME_GRP_INT
#-------------------------------------------------------------------------------
# Description: Create DDL for dimension holding static+dynamic(adp) medium entries
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-06-28 Nikolai Toknov	Create the script
#  2.0	2022-05-17 Nikolai Toknov	Change table from DIM_ADV_THEME_GRP to DIM_ADV_THEME_INT_GRP
#  2.1  2023-09-06 Andreas Kurz 	Changes INTEGER /NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INTEGER  / NAT aus APT
#									Changed Default Value and technical fields
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
THEME_GRP_INT_MSTR_SID
*/


-- technical fields
 -- Versioning
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_adv_theme_grp_int (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3) NOT NULL OPTIONS(description='Country code corresponding to the client.'),
country_descr STRING(16777216) NOT NULL OPTIONS(description='Country description corresponding to the client.'),
theme_grp_int_sid INTEGER DEFAULT - 1000 NOT NULL OPTIONS(description='Unique system ID, sid, for the theme.'),
theme_grp_int_name STRING(16777216) DEFAULT 'Kein Werbethema definiert (INTEGER )' NOT NULL
OPTIONS(description='(short) distinct theme name, superset of international'),
theme_grp_int_name_upper STRING(16777216) DEFAULT 'KEIN WERBETHEMA DEFINIERT (INTEGER )' NOT NULL
OPTIONS(description='(short) distinct theme name, superset of internationale: unique version for SID (trimmed and uppercase)'),
theme_grp_int_sort_val INTEGER DEFAULT 127 NOT NULL OPTIONS(description='Sort value for theme in front-end.'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Version			NUMBER of record ; Sequence starting from 0'),
current_fg INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Technical Field: 1 indicates the current record in case of several version'),
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
PRIMARY KEY (client_id, theme_grp_int_sid, valid_from_dt, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Loaded with some static data (Kein Werbethema international definiert and Totals) then all distinct international theme names from ADP');