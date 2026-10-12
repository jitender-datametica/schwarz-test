/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_PRICECHANGE_1
#----------------------------------------------------------------------------
# History:
#  1.0  16.08.2023    Ulrich Ross               Init
#                                               User Story 501417
#  1.1  05.09.2023    Ulrich Ross               Add DIV0 
#                                               User Story 501417                                                                                
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_PRICECHANGE_1
(
    client_id
  , client_desc
  , fiscyear
  , fiscper
  , wgi
  , perm_price_change_eur
  , perm_price_change_perc
  , remain_price_change_eur
  , remain_price_change_perc
  , adver_price_change_eur
  , adver_price_change_perc
)
AS
WITH item_pricechange AS (
  SELECT	
      ig_pch.itemgroup_int_id                                                       AS itemgroup_int_id
    , cal.cy_month                                                                  AS cy_month
    , wh.client_id                                                                  AS client_id
    , SUM ( CASE  WHEN (ig_pch.sfotype_id IN (134, 144, 180, 190, 186, 196) 
                    AND ig_pch.pcwo_reason_id IN (42) 
                    AND CASE  WHEN ig_pch.client_id IN (12) 
                              THEN ig_pch.pch_bnl_switch_fg 
                              WHEN ig_pch.client_id NOT IN(12) 
                              THEN 1 
                              ELSE 0 
                        END IN (1)) 
                  THEN ig_pch.val_price_change 
                  ELSE NULL 
            END)                                                                    AS perm_price_change 
    , SUM ( CASE  WHEN (ig_pch.sfotype_id IN (134, 144, 180, 190) 
                    AND ig_pch.pcwo_reason_id IN (43) 
                    AND CASE  WHEN ig_pch.client_id IN (12) 
                              THEN ig_pch.pch_bnl_switch_fg 
                              WHEN ig_pch.client_id NOT IN(12) 
                              THEN 1 
                              ELSE 0 
                        END IN (1)) 
                    THEN ig_pch.val_price_change 
                    ELSE NULL 
            END)                                                                    AS remain_price_change
    , SUM ( CASE  WHEN (ig_pch.sfotype_id IN (-99) 
                    AND CASE  WHEN ig_pch.client_id IN (12) 
                              THEN ig_pch.pch_bnl_switch_fg 
                              WHEN ig_pch.client_id NOT IN(12) 
                              THEN 1 
                              ELSE 0 
                        END = 1)
                    THEN ig_pch.val_price_change 
                    ELSE NULL 
            END)                                                                    AS  price_reg_diff 
    , SUM ( CASE  WHEN (ig_pch.sfotype_id IN (134, 144, 180, 190) 
                    AND CASE  WHEN ig_pch.client_id IN (12) 
                              THEN ig_pch.pch_bnl_switch_fg 
                              WHEN ig_pch.client_id NOT IN(12) 
                              THEN 1 
                              ELSE 0 
                        END = 1 
                          AND ig_pch.pcwo_reason_id IN (41)) 
                    THEN ig_pch.val_price_change 
                    ELSE NULL 
            END)                                                                    AS adver_price_change
  FROM	p_lew_mart_lead_ac.v_agg_wh_day_itemgroup_pch_1	        AS ig_pch
  
  INNER JOIN	p_lew_mart_msi_ac.v_org_wh_merge_1	              AS wh
    ON 	ig_pch.aspect_id = wh.aspect_id 
    AND ig_pch.client_id = wh.client_id
    AND ig_pch.wh_id = wh.wh_id
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_1	              AS curr
    ON 	ig_pch.client_id = curr.client_id 
    AND ig_pch.currency_iso_cd = curr.currency_iso_cd
    AND curr.curr_tot_id = 0
    
  INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_1	            AS cal
    ON 	ig_pch.dwh_cal_dt = cal.dat_calendar
    
  WHERE	wh.aspect_id = 2
    AND cal.cy_month IN ( SELECT DISTINCT cy_month 
                          FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                          WHERE byr = ( SELECT  byr 
                                        FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                                        WHERE dat_calendar = CURRENT_DATE - 1
                                      )
                        )    
    AND wh.dashboard_relevant_fg = 1
    AND ((ig_pch.sfotype_id IN (134, 144, 180, 190, 186, 196)
    AND ig_pch.pcwo_reason_id IN (42)
    AND  CASE WHEN ig_pch.client_id IN (12) 
            THEN ig_pch.pch_bnl_switch_fg 
            WHEN ig_pch.client_id NOT IN(12) 
            THEN 1 
            ELSE 0 
        END IN (1))
    OR (ig_pch.sfotype_id IN (134, 144, 180, 190)
        AND ig_pch.pcwo_reason_id IN (43)
        AND CASE  WHEN ig_pch.client_id IN (12) 
                  THEN ig_pch.pch_bnl_switch_fg 
                  WHEN ig_pch.client_id NOT IN(12) 
                  THEN 1 
                  ELSE 0 
            END IN (1))
    OR (ig_pch.sfotype_id IN (-99)
        AND CASE  WHEN ig_pch.client_id IN (12) 
                  THEN ig_pch.pch_bnl_switch_fg 
                  WHEN ig_pch.client_id NOT IN(12) 
                  THEN 1 
                  ELSE 0 
            END = 1)
    OR (ig_pch.sfotype_id IN (134, 144, 180, 190)
        AND CASE  WHEN ig_pch.client_id IN (12) 
                  THEN ig_pch.pch_bnl_switch_fg 
                  WHEN ig_pch.client_id NOT IN(12)
                  THEN 1 
                  ELSE 0 
            END = 1
              AND ig_pch.pcwo_reason_id IN (41)))
  GROUP BY	
      ig_pch.itemgroup_int_id
    , cal.cy_month
    , wh.client_id
)

, val_ejr AS (
  SELECT	
      sig.itemgroup_int_id                                          AS itemgroup_int_id
    , cal.cy_month                                                  AS cy_month
    , curr.client_id                                                AS client_id
    , SUM (ejr.val_rtl_net_ejr_asis + ejr.val_return_net_ejr_asis)  AS val_net_ejr
    
  FROM	p_lew_mart_lead_ac.v_agg_wh_org_day_item_ejr_asis_1	    AS ejr
  
  INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_1	              AS curr
    ON 	ejr.client_id = curr.client_id
    AND ejr.currency_iso_cd = curr.currency_iso_cd
    AND curr.curr_tot_id = 0
    
  INNER JOIN	p_lew_mart_lead_ac.v_itm_item_1	                  AS itm
    ON 	ejr.client_id = itm.client_id 
    AND ejr.item_id = itm.item_id 
    AND curr.client_id = itm.client_id
    
  INNER JOIN	p_lew_mart_msi_ac.v_itm_subitemgroup_1	          AS sig
    ON 	itm.subitemgroup_id = sig.subitemgroup_id
    
  INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_1	            AS cal
    ON 	ejr.dat_formdate = cal.dat_calendar
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_1	            AS r_cl
    ON 	curr.client_id = r_cl.client_id
    
  WHERE	ejr.aspect_id = 2
    AND cal.cy_month IN ( SELECT DISTINCT cy_month 
                          FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                          WHERE byr = ( SELECT  byr 
                                        FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                                        WHERE dat_calendar = CURRENT_DATE - 1
                                      )
                        )       
    AND r_cl.dashboard_relevant_fg = 1
  GROUP BY	
      sig.itemgroup_int_id
    , cal.cy_month
    , curr.client_id
)

, bnl_switch AS (
  SELECT	
      cal.cy_month                                                                                    AS cy_month
    , wh.client_id                                                                                    AS client_id
    , MIN(CASE  WHEN  wh_day_pch.dwh_cal_dt >= (SELECT MIN(dat_calendar) 
                                                FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                                                WHERE byr = ( SELECT  byr 
                                                              FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                                                              WHERE dat_calendar = CURRENT_DATE - 1
                                                            )) 
                THEN 1 
                ELSE 0 
          END)                                                                                        AS bnl_switch
  FROM	p_lew_mart_lead_ac.v_agg_wh_day_pch_1	          AS wh_day_pch 
  
  INNER JOIN	p_lew_mart_msi_ac.v_org_wh_merge_1	      AS wh
    ON  wh_day_pch.aspect_id = wh.aspect_id 
    AND wh_day_pch.client_id = wh.client_id 
    AND wh_day_pch.wh_id = wh.wh_id
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_1	      AS curr
    ON 	wh_day_pch.client_id = curr.client_id 
    AND wh_day_pch.currency_iso_cd = curr.currency_iso_cd
    AND curr.curr_tot_id = 0
    
  INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_1	    AS cal
    ON 	wh_day_pch.dwh_cal_dt = cal.dat_calendar
    
  WHERE	wh.aspect_id = 2
    AND cal.cy_month IN ( SELECT DISTINCT cy_month 
                          FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                          WHERE byr = ( SELECT  byr 
                                        FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                                        WHERE dat_calendar = CURRENT_DATE - 1
                                      )
                        )          
    AND wh.dashboard_relevant_fg = 1
  GROUP BY	
      cal.cy_month
    , wh.client_id
)

SELECT	
	  r_cl.client_id                              AS client_id
	, r_cl.country_iso_cd                         AS client_desc
	, cal_month_desc.byr                          AS fiscyear
	, cal_month_desc.cy_month                     AS fiscper
  , itemgroup_int.itemgroup_int_id       AS wgi
  , ROUND(MAX(COALESCE(item_pricechange.perm_price_change,0)),3) AS perm_price_change_eur
  , ROUND(MAX(DIV0((COALESCE(item_pricechange.perm_price_change,0)),val_ejr.val_net_ejr*100)),3) AS perm_price_change_perc
  , ROUND(MAX(COALESCE(item_pricechange.remain_price_change,0)),3)   AS remain_price_change_eur
  , ROUND(MAX(DIV0((COALESCE(item_pricechange.remain_price_change,0)),val_ejr.val_net_ejr*100)),3) AS remain_price_change_perc
  , ROUND(MAX(COALESCE(item_pricechange.adver_price_change,0)),3)   AS adver_price_change_eur
  , ROUND(MAX(DIV0((COALESCE(item_pricechange.adver_price_change,0)),val_ejr.val_net_ejr*100)),3) AS adver_price_change_perc   
  
FROM	item_pricechange	                                                                                            AS item_pricechange

FULL OUTER JOIN	val_ejr	                                                                                            AS val_ejr
  ON 	item_pricechange.client_id = val_ejr.client_id 
  AND item_pricechange.cy_month = val_ejr.cy_month
  AND item_pricechange.itemgroup_int_id = val_ejr.itemgroup_int_id
  
LEFT OUTER JOIN	bnl_switch	                                                                                        AS bnl_switch
  ON 	COALESCE(item_pricechange.client_id, val_ejr.client_id) = bnl_switch.client_id 
  AND COALESCE(item_pricechange.cy_month, val_ejr.cy_month) = bnl_switch.cy_month                          
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_1	                                                                    AS r_cl
  ON 	COALESCE(item_pricechange.client_id, val_ejr.client_id) = r_cl.client_id
  
INNER JOIN	p_lew_mart_msi_ac.v_cal_month_desc_1	                                                        AS cal_month_desc
  ON 	COALESCE(item_pricechange.cy_month, val_ejr.cy_month) = cal_month_desc.cy_month                        
                            
INNER JOIN	p_lew_mart_msi_ac.v_itm_itemgroup_int_1	                                                    AS itemgroup_int
  ON 	COALESCE(item_pricechange.itemgroup_int_id, val_ejr.itemgroup_int_id) = itemgroup_int.itemgroup_int_id
  
GROUP BY	
    itemgroup_int.itemgroup_int_id
	, cal_month_desc.cy_month
	, cal_month_desc.byr
	, r_cl.client_id
	, r_cl.country_iso_cd
  ;