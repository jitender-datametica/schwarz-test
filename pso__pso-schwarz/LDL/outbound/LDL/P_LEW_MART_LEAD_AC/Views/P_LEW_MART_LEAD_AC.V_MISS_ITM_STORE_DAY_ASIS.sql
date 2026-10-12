

CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_miss_itm_store_day_asis (client_id, 
loc_sid_store, 
item_sid, 
wh_loc_sid,
dat_formdate
-- cy_month,
 -- cy_partial_week_id,
 -- cy_week,
 -- busyear,
 -- miss_item_fg
 ) 
AS SELECT client_id,
 loc_sid_store,
 item_sid,
 wh_loc_sid,
 dat_formdate 
 -- asis.cy_month,
 -- asis.miss_item_fg
 -- asis.busyear,
 -- asis.cy_partial_week_id,
 -- asis.cy_week,

FROM ldl_p_lew_mart_lead.v_miss_itm_store_day_asis AS ASIS;