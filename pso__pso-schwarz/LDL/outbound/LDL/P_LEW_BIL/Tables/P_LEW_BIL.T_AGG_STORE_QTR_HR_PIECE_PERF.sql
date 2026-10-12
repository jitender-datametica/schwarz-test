/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.T_AGG_STORE_QTR_HR_PIECE_PERF
#----------------------------------------------------------------------------
# History:
#  1.0  2023-09-18    Ulrich Ross           Initial
#                                           User Story 516205

#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_store_qtr_hr_piece_perf (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client identifier'),
src_orig_store_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store identifier'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store identifier'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Record date'),
qtr_hr BIGNUMERIC(38,0) OPTIONS(description='Quarter hour ID'),
currency_iso_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Currency code'),
sales_pieces NUMERIC(18,5) OPTIONS(description='Sales pieces with dependency to Net time worked flag'),
sales_pieces_total NUMERIC(18,5) OPTIONS(description='Sales pieces'),
sales_pieces_extrapol NUMERIC(18,5) OPTIONS(description='Sales pieces extrapolated'),
sales_pieces_fa NUMERIC(18,5) OPTIONS(description='Sales pieces (foodaction)  with dependency to Net time worked flag'),
sales_pieces_fa_total NUMERIC(18,5) OPTIONS(description='Sales pieces total (foodaction)'),
val_rtl_net NUMERIC(18,5) OPTIONS(description='Sales net val with dependency to Net time worked flag'),
val_rtl_net_fa NUMERIC(18,5) OPTIONS(description='Net sales value (foodaction)'),
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