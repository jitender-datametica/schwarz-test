/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_BW_WRITEOFF_CUM_BY_1
#----------------------------------------------------------------------------
# History:
#   1.0      14.11.2023      Ulrich Ross              Init
#                                                     User Story 532005                                                                             
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_bw_writeoff_cum_by_1
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
  , val_writeoff_cum_by
)
AS
SELECT	
    sfo.client_id                                                                         AS client_id
	, sfo.wh_id                                                                             AS wh_id
	, cal.cy_month                                                                          AS cy_month
	, sfo.aspect_id                                                                         AS aspect_id
	, fg.family_cd                                                                          AS item_familygroup_id
	, itm.subitemgroup_id                                                                   AS subitemgroup_id
	, fg.subitemgroup_id                                                                    AS subitemgroup_id0
	, (CASE WHEN ilt.buying_list_type_id IS NULL THEN -1 ELSE ilt.buying_list_type_id END)  AS buying_list_type_id
    , cur.curr_tot_id                                                                       AS curr_tot_id
	, cur.currency_iso_cd                                                                   AS currency_iso_cd
	, SUM(COALESCE(sfo.val_rtl_rl_net_sfo_asis, 0))                                         AS val_writeoff_cum_by  --m1201bnl
FROM	p_lew_mart_msi_ac.v_agg_wh_org_day_item_sfo_asis_1      AS sfo
INNER JOIN	p_lew_mart_msi_ac.v_cal_busyear_cum_1	            AS bcum
  ON 	sfo.dat_formdate = bcum.dat_byr_cum
INNER JOIN	p_lew_mart_lead_ac.v_itm_item_list_type_hist_1	  AS ilt
  ON 	sfo.client_id = ilt.client_id 
  AND sfo.dat_formdate <= ilt.dat_rec_end 
  AND sfo.dat_formdate >= ilt.dat_rec_start 
  AND sfo.item_id = ilt.item_id
INNER JOIN	p_lew_mart_lead_ac.v_itm_item_1	                  AS itm
  ON 	sfo.client_id = itm.client_id 
  AND sfo.item_id = itm.item_id
INNER JOIN	p_lew_mart_msi_ac.v_itm_familygroup_1	            AS fg
  ON 	itm.client_id = fg.client_id 
  AND itm.item_familygroup_id = fg.item_familygroup_id
INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_1	              AS cur
  ON 	sfo.client_id = cur.client_id 
  AND sfo.currency_iso_cd = cur.currency_iso_cd
INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_1	            AS cal
  ON 	bcum.dat_calendar = cal.dat_calendar
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_1	            AS cl
  ON 	itm.client_id = cl.client_id
WHERE	(((sfo.sfotype_id IN (182, 192)
    AND sfo.pcwo_reason_id IN (21, 23, 24, 22, 126, 28, 27, 26, 132, 29, 31, 103, 104, 123, 124, 30, 105, 106, 107, 108, 109, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 125, 133, 25, 112, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153))
  OR (sfo.sfotype_id IN (137, 147)
    AND sfo.pcwo_reason_id IN (2, 128, 1, 127, 134, 135, 5, 6, 3, 7, 130, 131, 4, 101, 102, 110, 111, 129, 8, 136, 137, 152))
  OR (sfo.sfotype_id IN (181, 191)
    AND sfo.pcwo_reason_id IN (81, 82, 83, 84)))
  AND ((cur.curr_tot_id = 0 AND cur.currency_iso_cd = 'EUR')
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
  AND sfo.aspect_id = 1
  AND cal.dat_calendar = CURRENT_DATE -1
  AND bcum.dat_calendar  = CURRENT_DATE -1
  AND cl.dashboard_relevant_fg = 1
)
GROUP BY	
    cur.curr_tot_id
  , cur.currency_iso_cd
  , itm.subitemgroup_id
  , cal.cy_month
  , sfo.client_id
  , sfo.aspect_id
  , sfo.wh_id
  , fg.family_cd
  , fg.subitemgroup_id
  , (CASE WHEN ilt.buying_list_type_id IS NULL THEN -1 ELSE ilt.buying_list_type_id END)
  ;