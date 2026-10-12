/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for <schema name>.<table or view name>
#----------------------------------------------------------------------------
# History:
#   1.0            23.09.2021        Ulrich Roß               checking tables creating scripts
#                                                             https://jira.schwarz/browse/DDLE-1783
#                                                             Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_s_store_main (
client_id INTEGER NOT NULL,
store_id BIGNUMERIC(38) NOT NULL,
valid_from DATE NOT NULL,
valid_until DATE NOT NULL,
orig_store_nr BIGNUMERIC(38),
object_nr STRING(10) COLLATE 'und:ci',
real_opening_date DATE,
opening DATE,
closing DATE,
opening_ovis DATE,
closing_ovis DATE,
store_descr STRING(100) COLLATE 'und:ci',
is_test_store INTEGER,
is_closed INTEGER,
mde_print_cd INTEGER,
mde_lang_cd INTEGER,
street STRING(140) COLLATE 'und:ci',
zipcode STRING(30) COLLATE 'und:ci',
city STRING(100) COLLATE 'und:ci',
phone STRING(100) COLLATE 'und:ci',
fax STRING(70) COLLATE 'und:ci',
zipcode_postbox STRING(30) COLLATE 'und:ci',
postbox STRING(100) COLLATE 'und:ci',
store_valid_from DATE,
open_time_mo STRING(50) COLLATE 'und:ci',
open_time_tu STRING(50) COLLATE 'und:ci',
open_time_we STRING(50) COLLATE 'und:ci',
open_time_th STRING(50) COLLATE 'und:ci',
open_time_fr STRING(50) COLLATE 'und:ci',
open_time_sa STRING(50) COLLATE 'und:ci',
open_time_su STRING(50) COLLATE 'und:ci',
default_min_qty STRING COLLATE 'und:ci',
default_order_unit STRING(10) COLLATE 'und:ci',
license_nr STRING(20) COLLATE 'und:ci',
region_cd INTEGER,
language_id INTEGER,
last_refresh DATETIME,
src_id BIGNUMERIC(38),
load_id BIGNUMERIC(38)
);