CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_OVEN_EVENTS
AS
   SELECT
    client_id,
   wh_loc_sid,
   wh_id,
   loc_sid_store_move_to,
   aspect_id,
   currency_iso_cd,
   oven_id,
   oven_brand,
   dat_formdate,
   cy_week,
   cy_month,
   busyear,
   cnt_cleanings,
   cnt_baking_last_hour,
   no_baking_afternoon_fg,
   cnt_chmb_door_open,
   cnt_mantn_preheat_temprtr,
   cnt_cncld_pgm,
   cnt_bake_bfr_str_open,
   connected_fg,
   cnt_late_door_opening,
   cnt_bakings_morning,
   cnt_bakings_afternoon
   FROM p_lew_mart_lead.v_agg_store_day_oven_events
;