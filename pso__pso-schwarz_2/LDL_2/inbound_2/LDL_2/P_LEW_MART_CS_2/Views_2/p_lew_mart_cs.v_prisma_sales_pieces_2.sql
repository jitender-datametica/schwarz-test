/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.v_prisma_sales_pieces_2
#----------------------------------------------------------------------------
# History:
#  1.0  01.03.2022    Ross, Ulrich            Init
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_prisma_sales_pieces_2
(
  client_id
  , src_orig_store_nr
  , dwh_cal_dt
  , sales_pieces
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
SELECT  
  client_id
  , src_orig_store_nr
  , dwh_cal_dt
  , sales_pieces
  , cs_updated
  , cs_created
  , cs_load_id
FROM p_lew_mart_cs.t_prisma_sales_pieces_2
;