/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.v_mat_prisma_turnover_2
#----------------------------------------------------------------------------
# History:
#  1.0  01.03.2022    Ross, Ulrich            Init
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_prisma_turnover_2 (orig_store_nr, client_id, dat_formdate, currency_iso_cd
, val_retail_asis, val_retail_net_asis) AS SELECT orig_store_nr,
 client_id,
 dat_formdate,
 currency_iso_cd,
 COALESCE(val_retail_asis, 0) AS val_retail_asis,
 COALESCE(val_retail_net_asis, 0) AS val_retail_net_asis
FROM ldl_p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis_2 AS UMS;