CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MAT_AGG_STR_DAY_OVEN_BKG_PRG
/*
#DescStart#
#$Revision: 9764 $, $LastChangedBy: knagmote $
#SubjectAreas#: baking program KPIs in a baking chamber at store and day level
#DescEnd#
*/
(
  client_id
, wh_loc_sid
, wh_id
, loc_sid_store_move_to
, aspect_id
, oven_id
, oven_brand
, baking_prog_id
, dat_formdate
, cy_week
, cy_month
, busyear
, cnt_bkg_prg_fnshd
, cnt_bkg_chmbr_idle_tm
, dwh_updated
)
AS
SELECT
oven_logs.client_id,
oven_logs.wh_loc_sid,
oven_logs.wh_id,
oven_logs.loc_sid_store_move_to,
oven_logs.aspect_id,
oven_logs.oven_id,
oven_logs.oven_brand,
oven_logs.baking_prog_id,
oven_logs.dat_formdate,
oven_logs.cy_week,
oven_logs.cy_month,
oven_logs.busyear,
1 AS cnt_bkg_prg_fnshd,
1 AS cnt_bkg_chmbr_idle_tm,
CURRENT_TIMESTAMP(6) AS dwh_updated
FROM
(SELECT
events.client_id,
events.loc_sid_wh AS wh_loc_sid,
loc.src_wh_id     AS wh_id,
org.loc_sid_store_move_to,
org.aspect_id,
events.oven_id,
events.oven_brand,
events.baking_prog_id,
to_date(events.event_tmsp) AS dat_formdate,
cal.cy_week,
cal.cy_month,
cal.busyear
FROM p_lew_core_ac.v_bakeoff_oven_event events

INNER JOIN p_lew_bil_ac.v_org_store_merge org
ON    events.client_id     = org.client_id
AND   events.loc_sid_store = org.loc_sid_store

INNER JOIN p_lew_core_ac.v_location loc
ON    events.client_id     = loc.client_id
AND   events.loc_sid_wh    = loc.loc_sid
AND   loc.wh_store_mark    = 'B'

INNER JOIN p_lew_core_ac.v_cal_calendarday cal
ON    to_date(events.event_tmsp)       = cal.cal_dt
AND   cal.cy_month_seq  BETWEEN -35 AND 1

)oven_logs
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12;



