CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_STORE_DAY_SFO_BO_1 as

   SELECT
      client_id,
   loc_sid_store,
   src_orig_store_nr,
   booking_dat,
   cy_month,
   sfotype_id,
   SUM(sfo_total_qty                 ) AS sfo_total_qty,
   SUM(sfo_wrtoff_zero_qty           ) AS sfo_wrtoff_zero_qty,
   SUM(sfo_total_rtl_rl_val          ) AS sfo_total_rtl_rl_val,
   SUM(sfo_total_rtl_rl_net_val      ) AS sfo_total_rtl_rl_net_val,
   SUM(sfo_wrtoff_zero_rtl_rl_val    ) AS sfo_wrtoff_zero_rtl_rl_val,
   SUM(sfo_wrtoff_zero_rtl_rl_net_val) AS sfo_wrtoff_zero_rtl_rl_net_val
   FROM p_lew_bil.t_agg_store_day_item_sfo_1

   GROUP BY
      client_id
     ,loc_sid_store
     ,src_orig_store_nr
     ,booking_dat
     ,cy_month
     ,sfotype_id
;