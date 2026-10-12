CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_WH_DAY_ITEM_SFO
AS
SELECT
client_id,
loc_sid_wh_asis AS loc_sid_wh,
Max(1)::BYTEINT AS aspect_id -- aji erfordert Agg Funktion fuer definierte Attribute
,
booking_dat,
cy_week,
cy_month,
item_sid,
sfotype_id,
pcwo_reason_id,
Sum(sfo_total_qty) AS sfo_total_qty,
Sum(sfo_wrtoff_zero_qty) AS sfo_wrtoff_zero_qty,
Sum(sfo_total_rtl_rl_val) AS sfo_total_rtl_rl_val,
Sum(sfo_total_rtl_rl_net_val) AS sfo_total_rtl_rl_net_val,
Sum(sfo_wrtoff_zero_rtl_rl_val) AS sfo_wrtoff_zero_rtl_rl_val,
Sum(sfo_wrtoff_zero_rtl_rl_net_val) AS sfo_wrtoff_zero_rtl_rl_net_val,
Sum(val_pr_diff_sfo) AS val_pr_diff_sfo,
Sum(val_pr_diff_net_sfo) AS val_pr_diff_net_sfo,
Sum(CASE WHEN foodaction_fg = 1 THEN sfo_total_qty                     ELSE NULL END) AS sfo_total_fa_qty,
Sum(CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_qty               ELSE NULL END) AS sfo_wrtoff_zero_fa_qty,
Sum(CASE WHEN foodaction_fg = 1 THEN sfo_total_rtl_rl_val              ELSE NULL END) AS sfo_total_rtl_rl_fa_val,
Sum(CASE WHEN foodaction_fg = 1 THEN sfo_total_rtl_rl_net_val          ELSE NULL END) AS sfo_total_rtl_rl_net_fa_val,
Sum(CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_rtl_rl_val        ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_fa_val,
Sum(CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_rtl_rl_net_val    ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_net_fa_val,
Sum(CASE WHEN foodaction_fg = 1 THEN val_pr_diff_sfo                   ELSE NULL END) AS val_pr_diff_fa_sfo,
Sum(CASE WHEN foodaction_fg = 1 THEN val_pr_diff_net_sfo               ELSE NULL END) AS val_pr_diff_net_fa_sfo,
Current_Timestamp  AS timestamp_mod
FROM p_lew_bil.t_agg_store_day_item_sfo

GROUP BY
   client_id
  ,loc_sid_wh_asis
  ,booking_dat
  ,cy_week
  ,cy_month
  ,item_sid
  ,sfotype_id
  ,pcwo_reason_id
;



