/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_ITEM_EJR_ASIS_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.03.2022    Białek, Aleksander        Implementing Container context (part of Sortimentmodularity, AzureDevops: US 298238, BBT-3750, AP0101040)
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_ITEM_EJR_ASIS_SOMO_1 (
  CLIENT_ID
, CNT_DISCOUNT_EJR_ASIS
, CNT_RETAIL_EJR_ASIS
, CNT_RETURN_EJR_ASIS
, CNT_VOID_EJR_ASIS
, DAT_FORMDATE
, CY_MONTH
, ITEM_ID
, ORIG_STORE_NR
, CONTAINER_ID
, CONTAINER_HIST_ID	
, DISCOUNT_ID
, PRICE_RTL_EJR_ADJSTD_ASIS
, PRICE_RTL_NET_EJR_ADJSTD_ASIS
, PRICE_RTL_EJR_ASIS
, PRICE_RTL_NET_EJR_ASIS
, QTY_DISC_PIECE_EJR_ASIS
, QTY_DISC_WEIGHT_EJR_ASIS
, QTY_DISC_PIECE_WEIGTH_EJR_ASIS
, QTY_PIECE_EJR_ASIS
, QTY_RETURN_EJR_ASIS
, QTY_VOID_EJR_ASIS
, QTY_WEIGHT_EJR_ASIS
, STORE_ID
, MOVE_TO_STORE_ID
, TIME_LAST_SOLD_EJR_ASIS
, VAL_DISCOUNT_EJR_ASIS
, VAL_DISCOUNT_NET_EJR_ASIS
, VAL_DISCOUNT_HQ_EJR_ASIS
, VAL_DISCOUNT_HQ_NET_EJR_ASIS
, VAL_DISC_RTL_GROSS_EJR_ASIS
, VAL_DISC_RTL_NET_EJR_ASIS
, VAL_RETURN_EJR_ASIS
, VAL_RTL_EJR_ASIS
, VAL_VOID_EJR_ASIS
, VAL_VOID_NET_EJR_ASIS
, VAL_RTL_NET_EJR_ASIS
, VAL_RETURN_NET_EJR_ASIS
, QTY_PIECE_WEIGHT_EJR_ASIS
, QTY_RT_PIECE_WEIGHT_EJR_ASIS
, QTY_RETURN_DEFECT_EJR_ASIS
, QTY_RETURN_SALEABLE_EJR_ASIS
, QTY_RT_PC_WT_DEFECT_EJR_ASIS
, QTY_RT_PC_WT_SALEABLE_EJR_ASIS
, QTY_DISC_PIECE_FA_EJR_ASIS
, QTY_DISC_WEIGHT_FA_EJR_ASIS
, QTY_DISC_PIECE_WT_FA_EJR_ASIS
, QTY_PIECE_FA_EJR_ASIS
, QTY_RETURN_FA_EJR_ASIS
, QTY_WEIGHT_FA_EJR_ASIS
, VAL_DISCOUNT_FA_EJR_ASIS
, VAL_DISCOUNT_NET_FA_EJR_ASIS
, VAL_DISCOUNT_HQ_FA_EJR_ASIS
, VAL_DISC_HQ_NET_FA_EJR_ASIS
, VAL_DISC_RTL_GROSS_FA_EJR_ASIS
, VAL_DISC_RTL_NET_FA_EJR_ASIS
, VAL_RETURN_FA_EJR_ASIS
, VAL_RTL_FA_EJR_ASIS
, VAL_RTL_NET_FA_EJR_ASIS
, VAL_RETURN_NET_FA_EJR_ASIS
, QTY_PIECE_WEIGHT_FA_EJR_ASIS
, QTY_RT_PIECE_WT_FA_EJR_ASIS
, QTY_RETURN_DEFECT_FA_EJR_ASIS
, QTY_RETURN_SALE_FA_EJR_ASIS
, QTY_RT_PC_WT_DFCT_FA_EJR_ASIS
, QTY_RT_PC_WT_SALE_FA_EJR_ASIS
, CURRENCY_ISO_CD
) AS
SELECT
  client_id
, cnt_discount_ejr_asis
, cnt_retail_ejr_asis
, cnt_return_ejr_asis
, cnt_void_ejr_asis
, dat_formdate
, cy_month
, item_id
, orig_store_nr
, container_id
, container_hist_id	
, discount_id
, price_rtl_ejr_adjstd_asis
, price_rtl_net_ejr_adjstd_asis
, price_rtl_ejr_asis
, price_rtl_net_ejr_asis
, qty_disc_piece_ejr_asis
, qty_disc_weight_ejr_asis
, qty_disc_piece_weigth_ejr_asis
, qty_piece_ejr_asis
, qty_return_ejr_asis
, qty_void_ejr_asis
, qty_weight_ejr_asis
, store_id
, move_to_store_id
, time_last_sold_ejr_asis
, val_discount_ejr_asis
, val_discount_net_ejr_asis
, val_discount_hq_ejr_asis
, val_discount_hq_net_ejr_asis
, val_disc_rtl_gross_ejr_asis
, val_disc_rtl_net_ejr_asis
, val_return_ejr_asis
, val_rtl_ejr_asis
, val_void_ejr_asis
, val_void_net_ejr_asis
, val_rtl_net_ejr_asis
, val_return_net_ejr_asis
, qty_piece_weight_ejr_asis
, qty_rt_piece_weight_ejr_asis
, qty_return_defect_ejr_asis
, qty_return_saleable_ejr_asis
, qty_rt_pc_wt_defect_ejr_asis
, qty_rt_pc_wt_saleable_ejr_asis
, qty_disc_piece_fa_ejr_asis
, qty_disc_weight_fa_ejr_asis
, qty_disc_piece_wt_fa_ejr_asis
, qty_piece_fa_ejr_asis
, qty_return_fa_ejr_asis
, qty_weight_fa_ejr_asis
, val_discount_fa_ejr_asis
, val_discount_net_fa_ejr_asis
, val_discount_hq_fa_ejr_asis
, val_disc_hq_net_fa_ejr_asis
, val_disc_rtl_gross_fa_ejr_asis
, val_disc_rtl_net_fa_ejr_asis
, val_return_fa_ejr_asis
, val_rtl_fa_ejr_asis
, val_rtl_net_fa_ejr_asis
, val_return_net_fa_ejr_asis
, qty_piece_weight_fa_ejr_asis
, qty_rt_piece_wt_fa_ejr_asis
, qty_return_defect_fa_ejr_asis
, qty_return_sale_fa_ejr_asis
, qty_rt_pc_wt_dfct_fa_ejr_asis
, qty_rt_pc_wt_sale_fa_ejr_asis
, currency_iso_cd
FROM p_lew_mart_lead.v_agg_store_day_item_ejr_asis_somo_1
;