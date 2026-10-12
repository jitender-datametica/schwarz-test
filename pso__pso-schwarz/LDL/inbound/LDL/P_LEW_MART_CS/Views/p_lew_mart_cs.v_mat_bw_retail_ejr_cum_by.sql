/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_BW_RETAIL_EJR_CUM_BY
#----------------------------------------------------------------------------
# History:
#   1.0      14.11.2023      Ulrich Ross              Init
#                                                     User Story 532005                                                                                  
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_bw_retail_ejr_cum_by
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
  , val_ejr_cum_by
)
AS
SELECT	
    ejr.client_id             AS client_id
  , ejr.wh_id                 AS wh_id
  , cal.cy_month              AS cy_month
  , ejr.aspect_id             AS aspect_id 
  , fg.family_cd              AS item_familygroup_id
  , itm.subitemgroup_id       AS subitemgroup_id
  , fg.subitemgroup_id        AS subitemgroup_id0
  , (CASE WHEN ilt.buying_list_type_id IS NULL THEN -1 ELSE ilt.buying_list_type_id END)  AS buying_list_type_id
  , cur.curr_tot_id           AS curr_tot_id
  , cur.currency_iso_cd       AS currency_iso_cd
  ,SUM(ejr.val_rtl_net_ejr_asis + ejr.val_return_net_ejr_asis)  AS val_ejr_cum_by --M1401
FROM	p_lew_mart_lead_ac.v_agg_wh_org_day_item_ejr_asis   AS ejr
INNER JOIN	P_LEW_MART_MSI_AC.v_cal_busyear_cum	          AS bcum
  ON 	ejr.dat_formdate = bcum.dat_byr_cum 
INNER JOIN	p_lew_mart_lead_ac.v_itm_item_list_type_hist	AS ilt
  ON 	ejr.client_id = ilt.client_id 
  AND ejr.dat_formdate <= ilt.dat_rec_end 
  AND ejr.dat_formdate >= ilt.dat_rec_start 
  AND ejr.item_id = ilt.item_id
INNER JOIN	p_lew_mart_lead_ac.v_itm_item	                AS itm
  ON 	ejr.client_id = itm.client_id 
  AND ejr.item_id = itm.item_id
INNER JOIN	p_lew_mart_msi_ac.v_itm_familygroup	          AS fg
  ON 	itm.client_id = fg.client_id 
  AND itm.item_familygroup_id = fg.item_familygroup_id
INNER JOIN	p_lew_mart_msi_ac.v_ref_currency	            AS cur
  ON 	ejr.client_id = cur.client_id 
  AND ejr.currency_iso_cd = cur.currency_iso_cd
INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday	          AS cal
  ON 	bcum.dat_calendar = cal.dat_calendar
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	          AS cl
  ON 	itm.client_id = cl.client_id
WHERE	cal.cy_day_sequence <=  0
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
  AND ejr.aspect_id = 1
  AND cal.dat_calendar = CURRENT_DATE -1
  AND bcum.dat_calendar  = CURRENT_DATE -1                        
  AND cl.dashboard_relevant_fg = 1
GROUP BY	
  cur.curr_tot_id
  , cur.currency_iso_cd
  , itm.subitemgroup_id
  , cal.cy_month
  , ejr.client_id
  , ejr.aspect_id
  , ejr.wh_id
  , fg.family_cd
  , fg.subitemgroup_id
  , (CASE WHEN ilt.buying_list_type_id IS NULL THEN -1 ELSE ilt.buying_list_type_id END)
  ;