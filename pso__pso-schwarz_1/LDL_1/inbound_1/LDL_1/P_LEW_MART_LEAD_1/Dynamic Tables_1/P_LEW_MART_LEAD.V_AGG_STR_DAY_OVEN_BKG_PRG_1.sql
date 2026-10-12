CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_AGG_STR_DAY_OVEN_BKG_PRG_1
/*
#DescStart#
#$Revision: 9764 $, $LastChangedBy: knagmote $
#SubjectAreas#: Aggregate view with currency iso code logic
#DescEnd#
*/
(
  client_id
, wh_loc_sid
, wh_id
, loc_sid_store_move_to
, aspect_id
, currency_iso_cd
, oven_id
, oven_brand
, baking_prog_id
, dat_formdate
, cy_week
, cy_month
, busyear
, cnt_bkg_prg_fnshd
, cnt_bkg_chmbr_idle_tm
)
TARGET_LAG = '1 hour, 30 minutes'  -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD
AS
   SELECT
     agg.client_id
   ,agg.wh_loc_sid
   ,agg.wh_id
   ,agg.loc_sid_store_move_to
   ,agg.aspect_id
   ,cry.curr_cd_from AS currency_iso_cd
   ,agg.oven_id
   ,agg.oven_brand
   ,agg.baking_prog_id
   ,agg.dat_formdate
   ,agg.cy_week
   ,agg.cy_month
   ,agg.busyear
   ,agg.cnt_bkg_prg_fnshd
   ,agg.cnt_bkg_chmbr_idle_tm
  FROM p_lew_mart_lead.t_agg_str_day_oven_bkg_prg_1 agg
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS cry
   ON    agg.client_id = cry.client_id
   AND   CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND   CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 c
   ON    c.client_id        = cry.client_id
   AND   c.x_rate_type_sid  = cry.x_rate_type_sid
   AND   c.src_kurst        = '@BEWE'
;