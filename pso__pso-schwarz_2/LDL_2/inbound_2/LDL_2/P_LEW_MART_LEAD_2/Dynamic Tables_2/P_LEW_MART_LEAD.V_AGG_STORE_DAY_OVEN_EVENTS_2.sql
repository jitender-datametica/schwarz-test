CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_AGG_STORE_DAY_OVEN_EVENTS_2
(
client_id
,wh_loc_sid
,wh_id
,loc_sid_store_move_to
,aspect_id
,currency_iso_cd
,oven_id
,oven_brand
,dat_formdate
,cy_week
,cy_month
,busyear
,cnt_cleanings
,cnt_baking_last_hour
,no_baking_afternoon_fg
,cnt_chmb_door_open
,cnt_mantn_preheat_temprtr
,cnt_cncld_pgm
,cnt_bake_bfr_str_open
,connected_fg
,cnt_late_door_opening
,cnt_bakings_morning
,cnt_bakings_afternoon
)
TARGET_LAG = '1 hour, 30 minutes'  -- dummy_2 value; will be refreshed by Abinitio job
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
    ,agg.dat_formdate
    ,agg.cy_week
    ,agg.cy_month
    ,agg.busyear
    ,cnt_cleanings
    ,cnt_baking_last_hour
    ,no_baking_afternoon_fg
    ,cnt_chmb_door_open
    ,cnt_mantn_preheat_temprtr
    ,cnt_cncld_pgm
    ,cnt_bake_bfr_str_open
    ,connected_fg
    ,cnt_late_door_opening
    ,cnt_bakings_morning
    ,cnt_bakings_afternoon

   FROM p_lew_mart_lead.t_agg_store_day_oven_events_2 agg
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_2 AS cry
   ON    agg.client_id = cry.client_id
   AND   CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND   CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 c
   ON    c.client_id        = cry.client_id
   AND   c.x_rate_type_sid  = cry.x_rate_type_sid
   AND   c.src_kurst        = '@BEWE'
;