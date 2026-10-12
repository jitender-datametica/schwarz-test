DROP TABLE IF EXISTS ldl_p_lew_bil.t_agg_store_day_piece_perf_sig_1;
CREATE OR REPLACE TABLE ldl_p_lew_bil.t_agg_store_day_piece_perf_sig_1 (
client_id INTEGER NOT NULL OPTIONS(description='Client identifier'),
src_orig_store_nr INTEGER NOT NULL OPTIONS(description='Store identifier'),
loc_sid_store INTEGER NOT NULL OPTIONS(description='Store identifier'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Record date'),
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Currency code'),
item_grp_int_nr INTEGER NOT NULL OPTIONS(description='Item_1 group number'),
sub_item_grp_nr INTEGER NOT NULL OPTIONS(description='Sub item_1 group number'),
sub_item_grp_sid INTEGER NOT NULL OPTIONS(description='Sub item_1 group identifier'),
sales_pieces NUMERIC(29,5) OPTIONS(description='Sales_1 pieces with dependency to Net time worked flag'),
sales_pieces_fa NUMERIC(29,5) OPTIONS(description='Sales_1 pieces (foodaction) with dependency to Net time worked flag'),
val_rtl_net_wgi_uwg NUMERIC(29,5) OPTIONS(description='Net sales_1 value with dependency to Net time worked fla'),
average_price NUMERIC(29,5) OPTIONS(description='Average price with dependency to Net time worked flag'),
piece_receipt NUMERIC(29,5) OPTIONS(description='Piece receipt with dependency to Net time worked flag'),
cnt_customer NUMERIC(29,5) OPTIONS(description='Customer count with dependency to Net time worked flag'),
time_working_netto_fg INTEGER NOT NULL OPTIONS(description='Net time worked flag'),
training_time_hr NUMERIC(29,5) OPTIONS(description='Hours spent training'),
dwh_load_id INTEGER NOT NULL OPTIONS(description='DWH load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) record created'),
val_rtl_net_wgi_uwg_fa NUMERIC(29,5) OPTIONS(description='Net sales_1 value (foodaction)'),
sales_pieces_total NUMERIC(29,5) OPTIONS(description='Sales_1 pieces'),
sales_pieces_fa_total NUMERIC(29,5) OPTIONS(description='Sales_1 pieces total (foodaction)'),
sales_pieces_wo_multipack_factor NUMERIC(29,5)
OPTIONS(description='Sales_1 pieces with dependency to Net time worked flag without multipack'),
sales_pieces_total_wo_multipack_factor NUMERIC(29,5) OPTIONS(description='Sales_1 pieces without multipack'),
sales_pieces_fa_wo_multipack_factor NUMERIC(29,5)
OPTIONS(description='Sales_1 pieces (foodaction) with dependency to Net time worked flag  without multipack'),
sales_pieces_fa_total_wo_multipack_factor NUMERIC(29,5)
OPTIONS(description='Sales_1 pieces (foodaction) without multipack')
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Store day sub item_1 group piece performance.');