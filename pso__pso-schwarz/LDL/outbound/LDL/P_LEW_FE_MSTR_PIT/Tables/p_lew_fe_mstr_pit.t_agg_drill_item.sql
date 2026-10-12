/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_DRILL_ITEM
#-------------------------------------------------------------------------------
# Description: Create DDL for Frontend Drilling Table, containing links from each individual item to the history 
# of this item (the previous advertising weeks, in which this item was advertised).
# This table has the links for Region (WH) and Advertising Week, no comparison weeks on item level.
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-12 Dirk Hering     	Fixes, formatting
#  1.2	2021-09-13 Massimo Morelli 	Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0	2022-07-12 Nikolai Toknov  Changing the script for DevOps
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was CROSS JOIN
#  2.2  2022-10-12 Nikolai Toknov   Add CLUSTER BY (CLIENT_ID)
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_agg_drill_item (
client_id INTEGER NOT NULL OPTIONS(description='Client id'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
warehouse_gid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Warehouse Surrogate GID - As-Was CROSS JOIN key for Frontend'),
warehouse_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
warehouse_sid INTEGER NOT NULL OPTIONS(description='Warehouse Surrogate ID'),
warehouse_mstr_sid INTEGER OPTIONS(description='Warehouse Surrogate ID'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Warehouse			NUMBER  / code from Wawi'),
adv_week_id INTEGER NOT NULL OPTIONS(description='Advertising week BK'),
adv_week_mstr_id INTEGER
OPTIONS(description='Advertising week MSTR Key (AdvWeek No. concatenated with 2-digit client ID)'),
orig_item_gid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='NAN orig Item number Surrogate GID - As-Was CROSS JOIN key for Frontend'),
orig_item_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
orig_item_nr INTEGER NOT NULL OPTIONS(description='Item business identifier.NaN := National Article			NUMBER'),
orig_item_mstr_nr INTEGER
OPTIONS(description='Item business identifier.(NaN := National Article			NUMBER) MSTR Key: Special MSTR CROSS JOIN criteria to have surrogate ORIG_ITEM_NR + CLIENT_ID'),
item_int_descr STRING(16777216)
OPTIONS(description='(long) item description in international LANGUAGE of centre (Deutsch)'),
drill_to_hist_link_html STRING(16777216)
OPTIONS(description='Link to the target detailed report, which shows the history of this item (the previous advertising weeks, in which this item was advertised)'),
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
PRIMARY KEY (client_id, warehouse_sid, adv_week_id, orig_item_nr, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Frontend Drilling Table, containing links from each individual item to the history of this item (the previous advertising weeks, in which this item was advertised). This table has the links for Region (WH) and Advertising Week, no comparison weeks on item level.');