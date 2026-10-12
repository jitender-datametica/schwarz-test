/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_THEME_GRP_NAT_CAT
#-------------------------------------------------------------------------------
# Description: Create DDL for dimension holding static+dynamic(adp) medium entries
#			   Thema Categorie National (NAT)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-09-06 Andreas Kurz 	Changes INTEGER /NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INTEGER  / NAT aus APT
#									Initial Version 
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
THEME_GRP_NAT_CAT_MSTR_SID
*/


-- technical fields
 -- Versioning
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_adv_theme_grp_nat_cat_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3) NOT NULL OPTIONS(description='Country_1 code corresponding to the client.'),
country_descr STRING(16777216) NOT NULL OPTIONS(description='Country_1 description corresponding to the client.'),
theme_grp_nat_cat_sid INTEGER DEFAULT - 1000 NOT NULL OPTIONS(description='Unique system ID, sid, for the theme.'),
theme_grp_nat_cat_name STRING(16777216) DEFAULT 'Kein Werbethema Kategorie (NAT) definiert' NOT NULL
OPTIONS(description='(short) distinct theme name category (NAT), superset of national'),
theme_grp_nat_cat_name_upper STRING(16777216) DEFAULT 'KEIN WERBETHEMA KATEGORIE (NAT) DEFINIERT' NOT NULL
OPTIONS(description='(short) distinct theme name category (NAT), superset of national: unique version for SID (trimmed and uppercase)'),
theme_grp_nat_cat_sort_val INTEGER DEFAULT 127 NOT NULL OPTIONS(description='Sort value for theme in front-end.'),
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
PRIMARY KEY (client_id, theme_grp_nat_cat_sid, valid_from_dt, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Loaded with some static data (Kein Werbethema definiert and Totals) then all distinct national theme names from ADP');