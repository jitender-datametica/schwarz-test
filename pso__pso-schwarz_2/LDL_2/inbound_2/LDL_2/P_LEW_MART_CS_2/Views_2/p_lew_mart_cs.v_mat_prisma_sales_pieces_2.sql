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
CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_prisma_sales_pieces_2 (
   client_id
  ,src_orig_store_nr
  ,loc_sid_store
  ,dwh_cal_dt
  ,sales_pieces
  ,dwh_load_id
  ,dwh_created
) AS
  SELECT 
     perf.client_id
    ,perf.src_orig_store_nr
    ,perf.loc_sid_store
    ,perf.dwh_cal_dt
    ,perf.sales_pieces
    ,perf.dwh_load_id
    ,perf.dwh_created
  FROM  P_LEW_BIL_AC.v_agg_store_day_piece_perf_2 AS perf 
  WHERE perf.currency_iso_cd = 'EUR'
;