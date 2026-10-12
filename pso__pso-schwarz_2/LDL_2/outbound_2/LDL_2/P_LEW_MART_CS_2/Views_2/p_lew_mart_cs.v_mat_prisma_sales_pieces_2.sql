/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.v_mat_prisma_sales_pieces_2
#----------------------------------------------------------------------------
# History:
#  1.0  01.03.2022    Ross, Ulrich            Init
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_prisma_sales_pieces_2 (client_id, src_orig_store_nr, loc_sid_store,
dwh_cal_dt, sales_pieces, dwh_load_id, dwh_created) AS SELECT client_id,
 src_orig_store_nr,
 loc_sid_store,
 dwh_cal_dt,
 sales_pieces,
 dwh_load_id,
 dwh_created
FROM ldl_p_lew_bil_ac.v_agg_store_day_piece_perf_2 AS PERF
WHERE currency_iso_cd = 'EUR';