
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_STOR_DAY_SIG_EJR_ASIS_BO 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
      SELECT
         agg.loc_sid_store                      AS store_id,
      agg.client_id                          AS client_id,
      CAST(sig.src_subitemgrp_cd AS INTEGER) AS subitemgroup_id,
      agg.dwh_cal_dt                         AS dat_formdate,
      agg.cy_month                           AS cy_month,
      loc.src_orig_store_nr                  AS orig_store_nr,
      agg.discount_sid                       AS discount_id,
      agg.cnt_sale                           AS cnt_retail_ejr_asis,
      agg.cnt_return                         AS cnt_return_ejr_asis,
      agg.cnt_void                           AS cnt_void_ejr_asis,
      agg.piece_weight_qty                   AS qty_piece_ejr_asis,
      agg.sales_weight_qty                   AS qty_weight_ejr_asis,
      agg.return_qty                         AS qty_return_ejr_asis,
      agg.void_qty                           AS qty_void_ejr_asis,
      agg.sales_gross_val                    AS val_rtl_gross_ejr_asis,
      agg.sales_net_val                      AS val_rtl_net_ejr_asis,
      agg.return_gross_val                   AS val_return_gross_ejr_asis,
      agg.return_net_val                     AS val_return_net_ejr_asis,
      agg.void_gross_val                     AS val_void_gross_ejr_asis,
      agg.void_net_val                       AS val_void_net_ejr_asis,
      agg.discount_gross_val                 AS val_discount_gross_ejr_asis,
      agg.discount_net_val                   AS val_discount_net_ejr_asis,
      agg.piece_weight_qty                   AS qty_piece_weight_ejr_asis,
      agg.return_piece_weight_qty            AS qty_rt_piece_weight_ejr_asis,
      agg.sales_orig_gross_val               AS val_retail_orig_gross_ejr_asis,
      agg.sales_orig_net_val                 AS val_retail_orig_net_ejr_asis,
      agg.discount_base_gross_val            AS val_disc_base_gross_ejr_asis,
      agg.discount_base_net_val              AS val_disc_base_net_ejr_asis,
      agg.discount_weight_qty                AS qty_discount_pos_ejr_asis,
      agg.discount_piece_qty                 AS qty_discount_hq_ejr_asis,
      agg.return_defect_qty                  AS qty_return_defect_ejr_asis,
      agg.return_saleable_qty                AS qty_return_saleable_ejr_asis,
      agg.return_defect_pc_wt_qty            AS qty_rt_pc_wt_defect_ejr_asis,
      agg.return_saleable_pc_wt_qty          AS qty_rt_pc_wt_saleable_ejr_asis
      FROM p_lew_bil_ac.v_agg_pos_store_day_sig_asis agg
      INNER JOIN p_lew_core_ac.v_subitemgroup AS sig
      ON agg.client_id = sig.client_id
      AND agg.sub_item_grp_sid = sig.sub_item_grp_sid
      INNER JOIN p_lew_core_ac.v_location AS loc
      ON agg.client_id = loc.client_id
      AND agg.loc_sid_store = loc.loc_sid
;
