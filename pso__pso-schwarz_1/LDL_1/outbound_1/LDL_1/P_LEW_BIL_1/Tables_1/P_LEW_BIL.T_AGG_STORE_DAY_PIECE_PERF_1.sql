/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.T_AGG_STORE_DAY_PIECE_PERF_1
#----------------------------------------------------------------------------
# History:
#  1.0  2021-06-23    Tris Bayliff          Initial
#                                           20210623_2868_Stuckleistung_DDL
#                                           https://jira.schwarz/browse/REP2-9772
#  2.0  2021-09-16    Tris Bayliff          Copy to SnowFlake
#                                           20210831_2923_Stuckleistung_DDLQV4
#                                           https://jira.schwarz/browse/REP2-10259
#  2.1  2022-06-01    Jaroslaw Syrokosz     Add SALES_PIECES_EXTRAPOL, B-0011292A-AP0134217
#  2.2  2022-08-10    Jaroslaw Syrokosz     New Foodaction column for Net sales_1 value
#                                           B-0011300A-AP0141916
#  2.3 2022-08-23     Jaroslaw Syrokosz     sales_pieces_total added to final table
#                                           B-0011300A-AP0143580
#  2.4 2022-11-28     Marcin Malec          AP0154152, Stueckleistung ph 2, Adding column sales_pieces_fa_total
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_store_day_piece_perf_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client identifier'),
src_orig_store_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store identifier'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store identifier'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Record date'),
currency_iso_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Currency code'),
sales_pieces NUMERIC(18,5) OPTIONS(description='Sales_1 pieces with dependency to Net time worked flag'),
sales_pieces_total NUMERIC(18,5) OPTIONS(description='Sales_1 pieces'),
sales_pieces_extrapol NUMERIC(18,5) OPTIONS(description='Sales_1 pieces extrapolated'),
sales_pieces_fa NUMERIC(18,5) OPTIONS(description='Sales_1 pieces (foodaction)  with dependency to Net time worked flag'),
sales_pieces_fa_total NUMERIC(18,5) OPTIONS(description='Sales_1 pieces total (foodaction)'),
val_rtl_net NUMERIC(18,5) OPTIONS(description='Sales_1 net val with dependency to Net time worked flag'),
val_rtl_net_fa NUMERIC(18,5) OPTIONS(description='Net sales_1 value (foodaction)'),
avg_sales_price NUMERIC(18,5) OPTIONS(description='Average price with dependency to Net time worked flag'),
piece_receipt NUMERIC(18,5) OPTIONS(description='Piece receipt with dependency to Net time worked flag'),
cnt_customer NUMERIC(18,5) OPTIONS(description='Customer count with dependency to Net time worked flag'),
work_time_total_hr NUMERIC(18,5) OPTIONS(description='Work time total hour'),
piece_performance NUMERIC(18,5) OPTIONS(description='Piece performance with dependency to Net time worked flag'),
time_working_netto_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Net time worked flag'),
training_time_hr NUMERIC(18,5) OPTIONS(description='Hours spent training'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp record created')
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Store day piece performance');