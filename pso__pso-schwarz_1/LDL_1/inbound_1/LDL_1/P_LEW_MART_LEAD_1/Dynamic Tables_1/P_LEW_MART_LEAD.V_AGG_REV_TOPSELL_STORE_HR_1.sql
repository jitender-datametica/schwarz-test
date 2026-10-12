CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_AGG_REV_TOPSELL_STORE_HR_1
(
   client_id
   ,dat_formdate
   ,loc_sid_store_move_to
   ,wh_loc_sid
   ,wh_id
   ,cy_week
   ,currency_iso_cd
   ,time_hour_id
   ,receipt_for_count_id
   ,qty_piece_ejr
   ,qty_weight_ejr
   ,qty_sold
   ,val_retail_net_ejr
)
TARGET_LAG = '1 hour, 30 minutes'  -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD
AS
   SELECT
   hrl.client_id
   ,hrl.dat_formdate
   ,hrl.loc_sid_store_move_to
   ,hrl.wh_loc_sid
   ,hrl.wh_id
   ,hrl.cy_week
   ,cry.curr_cd_from   AS currency_iso_cd
   ,hrl.time_hour_id
   ,hrl.receipt_for_count_id
   ,hrl.qty_piece_ejr
   ,hrl.qty_weight_ejr
   ,hrl.qty_sold
   ,CAST(hrl.val_retail_net_ejr /cry.exchange_rate AS DECIMAL(19,5))  AS val_retail_net_ejr
   FROM p_lew_mart_lead.t_agg_rev_topsell_store_hr_1 hrl
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS cry
   ON    hrl.client_id = cry.client_id
   AND   CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND   CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 c
   ON    c.client_id        = cry.client_id
   AND   c.x_rate_type_sid  = cry.x_rate_type_sid
   AND   c.src_kurst        = '@BEWE'
;