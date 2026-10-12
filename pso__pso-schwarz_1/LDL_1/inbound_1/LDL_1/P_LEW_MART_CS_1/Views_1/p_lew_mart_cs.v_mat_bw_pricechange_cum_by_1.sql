/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_BW_PRICECHANGE_CUM_BY_1
#----------------------------------------------------------------------------
# History:
#   1.0      14.11.2023      Ulrich Ross              Init
#                                                     User Story 532005                                                                                
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_bw_pricechange_cum_by_1
(
    client_id
  , wh_id
  , cy_month
  , aspect_id
  , item_familygroup_id
  , subitemgroup_id
  , subitemgroup_id0
  , buying_list_type_id
  , curr_tot_id
  , currency_iso_cd
  , val_pricechange_cum_by
)
AS
SELECT	
    osm.client_id         AS client_id
	, osm.wh_id             AS wh_id
	, cal.cy_month          AS cy_month
	, osm.aspect_id         AS aspect_id
	, fg.family_cd          AS item_familygroup_id
	, itm.subitemgroup_id   AS subitemgroup_id
	, fg.subitemgroup_id    AS subitemgroup_id0
	, (CASE WHEN ilt.buying_list_type_id IS NULL THEN -1 ELSE ilt.buying_list_type_id END)  AS buying_list_type_id
  , cur.curr_tot_id       AS curr_tot_id
	, cur.currency_iso_cd   AS currency_iso_cd
	, SUM(pch.val_price_change)  AS val_pricechange_cum_by   --m1102pvs
FROM	p_lew_mart_lead_ac.v_agg_str_day_item_pch_1	AS pch
INNER JOIN	p_lew_mart_msi_ac.v_cal_busyear_cum_1	AS bcum
  ON 	pch.dwh_cal_dt = bcum.dat_byr_cum
INNER JOIN	p_lew_mart_lead_ac.v_itm_item_list_type_hist_1	AS ilt
  ON 	pch.client_id = ilt.client_id
  AND pch.dwh_cal_dt <= ilt.dat_rec_end
  AND	pch.dwh_cal_dt >= ilt.dat_rec_start
  AND pch.item_sid = ilt.item_id
INNER JOIN	p_lew_mart_lead_ac.v_itm_item_1	AS itm
  ON 	pch.client_id = itm.client_id
  AND pch.item_sid = itm.item_id
INNER JOIN	p_lew_mart_msi_ac.v_itm_familygroup_1	fg
  ON 	itm.client_id = fg.client_id
  AND itm.item_familygroup_id = fg.item_familygroup_id
INNER JOIN	p_lew_mart_msi_ac.v_org_store_merge_1	osm
  ON 	pch.client_id = osm.client_id
  AND pch.loc_sid_store = osm.store_id
INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_1	cur
  ON 	pch.client_id = cur.client_id
  AND pch.currency_iso_cd = cur.currency_iso_cd
INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_1	cal
  ON 	bcum.dat_calendar = cal.dat_calendar
WHERE	(((cur.curr_tot_id = 0 AND cur.currency_iso_cd = 'EUR')
         OR  (cur.curr_tot_id=3 AND cur.currency_iso_cd='BGN')
         OR  (cur.curr_tot_id=4 AND cur.currency_iso_cd='CHF')
         OR  (cur.curr_tot_id=6 AND cur.currency_iso_cd='CZK')
         OR  (cur.curr_tot_id=8 AND cur.currency_iso_cd='DKK')
       OR  (cur.curr_tot_id=16 AND cur.currency_iso_cd='HUF')
       OR  (cur.curr_tot_id=24 AND cur.currency_iso_cd='PLN')
       OR  (cur.curr_tot_id=26 AND cur.currency_iso_cd='RON')
       OR  (cur.curr_tot_id=27 AND cur.currency_iso_cd='SEK')
       OR  (cur.curr_tot_id=33 AND cur.currency_iso_cd='USD')
       OR  (cur.curr_tot_id=34 AND cur.currency_iso_cd='RSD')
       OR  (cur.curr_tot_id=40 AND cur.currency_iso_cd='GBP'))
 AND osm.aspect_id = 1
 AND cal.dat_calendar = CURRENT_DATE -1
 AND bcum.dat_calendar  = CURRENT_DATE -1
 AND osm.dashboard_relevant_fg = 1
)
GROUP BY	
    cur.curr_tot_id
	, cur.currency_iso_cd
	, itm.subitemgroup_id
	, cal.cy_month
	, osm.client_id
	, osm.aspect_id
	, osm.wh_id
	, fg.family_cd
	, fg.subitemgroup_id
	, (CASE WHEN ilt.buying_list_type_id IS NULL THEN -1 ELSE ilt.buying_list_type_id END)
  ;