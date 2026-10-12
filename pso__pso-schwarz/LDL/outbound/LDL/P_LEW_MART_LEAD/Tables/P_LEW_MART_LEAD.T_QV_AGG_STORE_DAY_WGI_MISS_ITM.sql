/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_WGI_MISS_ITM
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-20 Marcin Malec          Initial; User Story 481680: [BE] - Fehlartikel Filiale | Quick View
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_qv_agg_store_day_wgi_miss_itm (
client_id INTEGER NOT NULL OPTIONS(description='Client identifier'),
account_manager_id INTEGER OPTIONS(description='Account manager identifier'),
sales_manager_id INTEGER OPTIONS(description='Sales manager identifier'),
move_to_store_id INTEGER NOT NULL OPTIONS(description='Store identifier'),
wh_id INTEGER NOT NULL OPTIONS(description='Warehouse identifier'),
wh_id_exp INTEGER OPTIONS(description=''),
aspect_id INTEGER NOT NULL OPTIONS(description='Aspect identifier'),
currency_iso_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description=''),
curr_tot_id INTEGER OPTIONS(description='Currency tot identifier'),
dat_formdate DATE NOT NULL OPTIONS(description='Record date'),
itemgroup_int_id INTEGER NOT NULL OPTIONS(description=''),
miss_item_cnt_cy INTEGER OPTIONS(description='Missing item count: Current year'),
miss_item_cnt_fa_cy INTEGER OPTIONS(description='Missing item count (foodaction): Current year'),
miss_item_cnt_py INTEGER OPTIONS(description='Missing item count: Previous year'),
miss_item_cnt_fa_py INTEGER OPTIONS(description='Missing item count (foodaction): Previous year'),
store_day_cnt_cy INTEGER OPTIONS(description='Store Day count: Current year'),
store_day_cnt_fa_cy INTEGER OPTIONS(description='Store Day count (foodaction): Current year'),
store_day_cnt_py INTEGER OPTIONS(description='Store Day count: Previous year'),
store_day_cnt_fa_py INTEGER OPTIONS(description='Store Day count (foodaction): Previous year'),
miss_item_fg_cy BIGNUMERIC OPTIONS(description='Missing item flag: Current year (if there was any missing item)'),
miss_item_fg_fa_cy BIGNUMERIC
OPTIONS(description='Missing item flag: Current year (foodaction) (if there was any missing item)'),
miss_item_fg_py BIGNUMERIC OPTIONS(description='Missing item flag: Previous year (if there was any missing item)'),
miss_item_fg_fa_py BIGNUMERIC
OPTIONS(description='Missing item flag: Previous year (foodaction) (if there was any missing item)'),
skipped_fg_cy BIGNUMERIC
OPTIONS(description='0 - Not skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value (or 300) from LDL.P_LEW_MART_LEAD.T_REF_PARAMETER_VT with p_id = 1'),
skipped_fg_fa_cy BIGNUMERIC
OPTIONS(description='0 - Not skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value (or 300) from LDL.P_LEW_MART_LEAD.T_REF_PARAMETER_VT with p_id = 1'),
skipped_fg_py BIGNUMERIC
OPTIONS(description='0 - Not skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value (or 300) from LDL.P_LEW_MART_LEAD.T_REF_PARAMETER_VT with p_id = 1'),
skipped_fg_fa_py BIGNUMERIC
OPTIONS(description='0 - Not skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value (or 300) from LDL.P_LEW_MART_LEAD.T_REF_PARAMETER_VT with p_id = 1'),
dwh_load_id INTEGER NOT NULL OPTIONS(description='DWH load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='DWH record created timestamp'),
dwh_updated DATETIME NOT NULL OPTIONS(description='DWH record updated timestamp')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='QuickView Fehlartikel Store table');