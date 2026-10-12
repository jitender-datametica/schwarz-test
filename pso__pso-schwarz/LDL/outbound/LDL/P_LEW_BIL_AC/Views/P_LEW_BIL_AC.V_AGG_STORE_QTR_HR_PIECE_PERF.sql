/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.V_AGG_STORE_QTR_HR_PIECE_PERF
#----------------------------------------------------------------------------
# History:
#  1.0  2023-09-15    Ulrich Ross           Initial
#                                           User Story 516205

#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_agg_store_qtr_hr_piece_perf (client_id, src_orig_store_nr, loc_sid_store,
dwh_cal_dt, qtr_hr, currency_iso_cd, sales_pieces, sales_pieces_total, sales_pieces_extrapol, sales_pieces_fa,
sales_pieces_fa_total, val_rtl_net, val_rtl_net_fa, avg_sales_price, piece_receipt, cnt_customer, work_time_total_hr,
piece_performance, time_working_netto_fg, training_time_hr, dwh_load_id, dwh_created) AS SELECT *
FROM ldl_p_lew_bil.v_agg_store_qtr_hr_piece_perf;