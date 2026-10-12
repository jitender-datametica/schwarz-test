/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.T_AGG_STORE_DAY_PIECE_PERF_ITEM
#----------------------------------------------------------------------------
# History:
#  1.0  2021-06-23    Tris Bayliff          Initial
#                                           20210623_2868_Stuckleistung_DDL
#                                           https://jira.schwarz/browse/REP2-9772
#  2.0  2021-09-16    Tris Bayliff          Copy to SnowFlake
#                                           20210831_2923_Stuckleistung_DDLQV4
#                                           https://jira.schwarz/browse/REP2-10259
#  2.1  2022-10-12    Marcin Malec          sales_pieces_total added to final table
#                                           B-0011300A-AP0143580
#  2.2  2022-11-28    Marcin Malec          AP0154152, Stueckleistung ph 2, Adding column sales_pieces_fa_total
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_store_day_piece_perf_item (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client identifier'),
src_orig_store_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store identifier'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store identifier'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Record date'),
currency_iso_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Currency code'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Item  identifier'),
sales_pieces NUMERIC(18,5) OPTIONS(description='Sales pieces with dependency to Net time worked flag'),
sales_pieces_total NUMERIC(18,5) OPTIONS(description='Sales pieces'),
sales_pieces_fa NUMERIC(18,5) OPTIONS(description='Sales pieces (foodaction) with dependency to Net time worked flag'),
sales_pieces_fa_total NUMERIC(18,5) OPTIONS(description='Sales pieces total (foodaction)'),
val_rtl_net_ejr NUMERIC(18,5)
OPTIONS(description='Net sales value from Receiptline with dependency to Net time worked flag'),
average_price NUMERIC(18,5) OPTIONS(description='Average price with dependency to Net time worked flag'),
piece_receipt NUMERIC(18,5) OPTIONS(description='Piece receipt with dependency to Net time worked flag'),
cnt_customer NUMERIC(18,5) OPTIONS(description='Customer count with dependency to Net time worked flag'),
time_working_netto_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Net time worked flag'),
training_time_hr NUMERIC(18,5) OPTIONS(description='Hours spent training'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp record created')
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Store day item piece performance.');