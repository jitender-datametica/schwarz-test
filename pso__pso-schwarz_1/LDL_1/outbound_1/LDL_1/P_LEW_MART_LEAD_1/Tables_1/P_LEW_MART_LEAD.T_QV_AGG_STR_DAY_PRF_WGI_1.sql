/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_STR_DAY_PRF_WGI_1
#----------------------------------------------------------------------------
# History:
#  1.0  2021-08-12    Tris Bayliff          Initial
#                                           20210812_2909_Stuckleistung_DDLQV2
#                                           https://jira.schwarz/browse/REP2-10132
#  1.1  2021-09-01    Tris Bayliff          Split revenue columns in to WGI and Store as they differ.
#                                           20210831_2923_Stuckleistung_DDLQV4
#                                           https://jira.schwarz/browse/REP2-10259
#  2.0  2021-09-16    Tris Bayliff          Copy to SnowFlake
#                                           20210831_2923_Stuckleistung_DDLQV4
#                                           https://jira.schwarz/browse/REP2-10259
#  2.1  2022-06-01    Jaroslaw Syrokosz     Add SALES_PIECES_EXTRAPOL, B-0011292A-AP0134217
#  2.2  2022-08-10    Jaroslaw Syrokosz     New Foodaction column for Net sales_1 value
#                                           B-0011300A-AP0141916
#  2.3  2022-11-15    Marcin Malec          AP0143580, Stueckleistung ph 2, Adding sales_pieces_total, sales_pieces_fa_total, sales_pieces_total_adj, sales_pieces_total_pep _cy / _py
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_qv_agg_str_day_prf_wgi_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client identifier'),
account_manager_id BIGNUMERIC(38,0) OPTIONS(description='Account_1 manager identifier'),
sales_manager_id BIGNUMERIC(38,0) OPTIONS(description='Sales_1 manager identifier'),
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store identifier'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse identifier'),
wh_id_exp BIGNUMERIC(38,0) OPTIONS(description=''),
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Aspect identifier'),
currency_iso_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description=''),
curr_tot_id BIGNUMERIC(38,0) OPTIONS(description='Currency tot identifier'),
dat_formdate DATE NOT NULL OPTIONS(description='Record date'),
itemgroup_int_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
sales_pieces_cy NUMERIC(18,5) OPTIONS(description='Sales_1 pieces: Current year'),
sales_pieces_total_cy NUMERIC(18,5) OPTIONS(description='Sales_1 pieces total: Current year'),
sales_pieces_total_pep_cy NUMERIC(18,5) OPTIONS(description='Sales_1 pieces total plan pep: Current year'),
sales_pieces_fa_cy NUMERIC(18,5) OPTIONS(description='Sales_1 pieces (foodaction): Current year'),
sales_pieces_fa_total_cy NUMERIC(18,5) OPTIONS(description='Sales_1 pieces total (foodaction): Current year'),
sales_pieces_adj_cy NUMERIC(18,5) OPTIONS(description='Adjusted sales_1 pieces: Current year'),
sales_pieces_total_adj_cy NUMERIC(18,5) OPTIONS(description='Adjusted sales_1 pieces total: Current year'),
val_rtl_net_wgi_uwg_cy NUMERIC(18,5) OPTIONS(description='Net revenue (wgi level): Current year'),
val_rtl_net_wgi_uwg_fa_cy NUMERIC(18,5) OPTIONS(description='Net revenue (foodaction)(wgi level): Current year'),
val_rtl_net_cy NUMERIC(18,5) OPTIONS(description='Net revenue (store level): Current year'),
val_rtl_net_fa_cy NUMERIC(18,5) OPTIONS(description='Net revenue (foodaction)(store level): Current year'),
cnt_customer_cy NUMERIC(18,5) OPTIONS(description='Customer count: Current year'),
work_time_total_hr_cy NUMERIC(18,5) OPTIONS(description='Total work time in hours at warehouse level: Current year'),
sales_pieces_extrapol_cy NUMERIC(18,5) OPTIONS(description='Sales_1 pieces  extrapol: Current year '),
sales_pieces_py NUMERIC(18,5) OPTIONS(description='Sales_1 pieces: Previous year'),
sales_pieces_total_py NUMERIC(18,5) OPTIONS(description='Sales_1 pieces total: Previous year'),
sales_pieces_total_pep_py NUMERIC(18,5) OPTIONS(description='Sales_1 pieces total plan pep: Previous year'),
sales_pieces_fa_py NUMERIC(18,5) OPTIONS(description='Sales_1 pieces (foodaction): Previous year'),
sales_pieces_fa_total_py NUMERIC(18,5) OPTIONS(description='Sales_1 pieces total (foodaction): Previous year'),
sales_pieces_adj_py NUMERIC(18,5) OPTIONS(description='Adjusted sales_1 pieces: Previous year'),
sales_pieces_total_adj_py NUMERIC(18,5) OPTIONS(description='Adjusted sales_1 pieces total: Previous year'),
val_rtl_net_wgi_uwg_py NUMERIC(18,5) OPTIONS(description='Net revenue (wgi level): Previous year'),
val_rtl_net_wgi_uwg_fa_py NUMERIC(18,5) OPTIONS(description='Net revenue (foodaction)(wgi level): Previous year'),
val_rtl_net_py NUMERIC(18,5) OPTIONS(description='Net revenue (store level): Previous year'),
val_rtl_net_fa_py NUMERIC(18,5) OPTIONS(description='Net revenue (foodaction)(store level): Previous year'),
cnt_customer_py NUMERIC(18,5) OPTIONS(description='Customer count: Previous year'),
work_time_total_hr_py NUMERIC(18,5) OPTIONS(description='Total work time in hours at warehouse level: Previous year'),
sales_pieces_extrapol_py NUMERIC(18,5) OPTIONS(description='Sales_1 pieces  extrapol: Previous year '),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='DWH record created timestamp'),
dwh_updated DATETIME NOT NULL OPTIONS(description='DWH record updated timestamp')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='QuickView Stuckleistung Store table');