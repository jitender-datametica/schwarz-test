DROP TABLE IF EXISTS ldl_p_lew_bil.t_agg_store_day_piece_perf;
CREATE OR REPLACE TABLE ldl_p_lew_bil.t_agg_store_day_piece_perf (
client_id INTEGER NOT NULL OPTIONS(description='Client identifier'),
src_orig_store_nr INTEGER NOT NULL OPTIONS(description='Store identifier'),
loc_sid_store INTEGER NOT NULL OPTIONS(description='Store identifier'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Record date'),
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Currency code'),
sales_pieces NUMERIC(29,5) OPTIONS(description='Sales pieces with dependency to Net time worked flag'),
sales_pieces_extrapol NUMERIC(29,5) OPTIONS(description='Sales pieces extrapolated'),
sales_pieces_fa NUMERIC(29,5) OPTIONS(description='Sales pieces (foodaction)  with dependency to Net time worked flag'),
val_rtl_net NUMERIC(29,5) OPTIONS(description='Sales net val with dependency to Net time worked flag'),
avg_sales_price NUMERIC(29,5) OPTIONS(description='Average price with dependency to Net time worked flag'),
piece_receipt NUMERIC(29,5) OPTIONS(description='Piece receipt with dependency to Net time worked flag'),
cnt_customer NUMERIC(29,5) OPTIONS(description='Customer count with dependency to Net time worked flag'),
work_time_total_hr NUMERIC(29,5) OPTIONS(description='Work time total hour'),
piece_performance NUMERIC(29,5) OPTIONS(description='Piece performance with dependency to Net time worked flag'),
time_working_netto_fg INTEGER NOT NULL OPTIONS(description='Net time worked flag'),
training_time_hr NUMERIC(29,5) OPTIONS(description='Hours spent training'),
dwh_load_id INTEGER NOT NULL OPTIONS(description='DWH load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) record created'),
val_rtl_net_fa NUMERIC(29,5) OPTIONS(description='Net sales value (foodaction)'),
sales_pieces_total NUMERIC(29,5) OPTIONS(description='Sales pieces'),
sales_pieces_fa_total NUMERIC(29,5) OPTIONS(description='Sales pieces total (foodaction)'),
sales_pieces_wo_multipack_factor NUMERIC(29,5)
OPTIONS(description='Sales pieces with dependency to Net time worked flag without multipack'),
sales_pieces_total_wo_multipack_factor NUMERIC(29,5) OPTIONS(description='Sales pieces without multipack'),
sales_pieces_fa_wo_multipack_factor NUMERIC(29,5)
OPTIONS(description='Sales pieces (foodaction) with dependency to Net time worked flag  without multipack'),
sales_pieces_fa_total_wo_multipack_factor NUMERIC(29,5)
OPTIONS(description='Sales pieces (foodaction) without multipack')
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Store day piece performance');