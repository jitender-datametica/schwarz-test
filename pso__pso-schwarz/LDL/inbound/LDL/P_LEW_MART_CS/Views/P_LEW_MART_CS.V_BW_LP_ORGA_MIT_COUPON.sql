/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_LP_ORGA_MIT_COUPON
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2024    Ulrich Ross               Init
#  1.1  06.06.2024    Ulrich Ross               Add DIV0
#                                               User Story 711243     
#                                                                                
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_LP_ORGA_MIT_COUPON
(
   client_id
  ,client_desc
  ,country_iso_cd
  ,cy_month
  ,cy_month_name
  ,coupon_type_id
  ,coupon_type_desc
  ,coupon_type_group_id
  ,coupon_type_group_desc
  ,coupon_type_subgroup_id
  ,coupon_type_subgroup_desc
  ,feature_id
  ,feature_desc
  ,feature_group_id
  ,feature_group_desc
  ,feature_subgroup_id
  ,feature_subgroup_desc
  ,discount_type_id
  ,discount_type_desc
  ,loyalty_id
  ,loyalty_desc
  ,receipt_total_net_val_uniq
  ,count_customer
  ,lp_preisveraenderung_aktion
  ,lp_preisveraenderung_aktion_prozent
  ,lp_werbepv_aktion
  ,lp_werbe_pv_aktion_prozent
  ,lp_restantenverwert_sort
  ,lp_restantenverwert_sort_prozent
  ,lp_abschriften_gesamt
  ,lp_abschriften_gesamt_prozent
  ,lp_val_restantenverwert_aktion
  ,lp_restantenverwert_aktion_prozent_prozent
 )
 AS

WITH lp_values AS (
SELECT	
   ldpl_day.cy_month                                                                                                          AS cy_month
	,r_cl.client_id                                                                                                             AS client_id
  ,ldpl_day.feature_id                                                                                                        AS feature_id
	,ldpl_day.discount_type_id                                                                                                  AS discount_type_id
  ,ldpl_day.coupon_type_id                                                                                                    AS coupon_type_id
	,COUNT(DISTINCT ldpl_day.receipt_total_net_val_uniq)                                                                        AS receipt_total_net_val_uniq
	,CASE WHEN SUM(ldpl_day.discount_val)=0 THEN NULL ELSE ROUND(SUM(ldpl_day.discount_val),2) END                              AS discount_val
	,CASE WHEN SUM(ldpl_day.writeoff_val)=0 THEN NULL ELSE ROUND(SUM(ldpl_day.writeoff_val),2) END                              AS writeoff_val
  ,ROUND((1.00001 / 1.00001) * COUNT(DISTINCT ldpl_day.customer_sid))                                                         AS count_customer
  ,CASE WHEN ldpl_day.pcwo_reason_id IN (41) AND SUM(ldpl_day.discount_val)=0 THEN NULL 
        WHEN ldpl_day.pcwo_reason_id IN (41) AND SUM(ldpl_day.discount_val)<> 0 THEN SUM(ldpl_day.discount_val) 
        END                                                                                                                   AS lp_val_werbepv  --Preisveraenderungen
  ,CASE WHEN ldpl_day.pcwo_reason_id IN (43) AND SUM(ldpl_day.discount_val)=0 THEN NULL 
        WHEN ldpl_day.pcwo_reason_id IN (43) AND SUM(ldpl_day.discount_val)<> 0 THEN SUM(ldpl_day.discount_val) 
        END                                                                                                                   AS lp_val_restantenverwert_sort  --Restantenverwertung (PV) Sortiment
  ,CASE WHEN ldpl_day.pcwo_reason_id IN (6, 81, 151) AND SUM(ldpl_day.writeoff_val)=0 THEN NULL 
        WHEN ldpl_day.pcwo_reason_id IN (6, 81, 151) AND SUM(ldpl_day.writeoff_val)<> 0 THEN SUM(ldpl_day.writeoff_val) 
        END                                                                                                                   AS lp_val_restantenverwert_aktion  --Restantenverwertung (PV) Aktion  = 6
                                                                                                                                                                 --Restantenverwertung (PV) Lager - Aktion  = 81
                                                                                                                                                                 --Restantenverwertung Vollabschrift (GTIN switch) = 151        
FROM	p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day	AS ldpl_day
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl
  ON 	ldpl_day.client_id = r_cl.client_id
WHERE	ldpl_day.lidlplus_cust_fg = 'Y'
  AND ldpl_day.aspect_id IN (2)
  AND ldpl_day.cy_month IN( SELECT DISTINCT cy_month 
                            FROM p_lew_mart_msi_ac.v_cal_calendarday
                            WHERE byr = ( SELECT  byr 
                                          FROM p_lew_mart_msi_ac.v_cal_calendarday
                                          WHERE dat_calendar = CURRENT_DATE - 1
                                              ) 
                          )
  AND ldpl_day.curr_tot_id = 0
  AND r_cl.dashboard_relevant_fg = 1
GROUP BY	ldpl_day.cy_month
  ,r_cl.client_id
  ,ldpl_day.coupon_type_id
  ,ldpl_day.feature_id
  ,ldpl_day.discount_type_id
  ,ldpl_day.pcwo_reason_id
  
)

, lp_customer AS (
SELECT
   ldpl_day.cy_month            AS cy_month
	,r_cl.client_id               AS client_id
	,ldpl_day.feature_id          AS feature_id
	,ldpl_day.discount_type_id    AS discount_type_id
	,ldpl_day.coupon_type_id      AS coupon_type_id
	,(1.00001 / 1.00001) * COUNT(DISTINCT ldpl_day.customer_sid)  AS count_customer
FROM	p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day AS ldpl_day
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl
	  ON 	ldpl_day.client_id = r_cl.client_id
WHERE	ldpl_day.lidlplus_cust_fg = 'Y'
  AND ldpl_day.aspect_id IN (2)
  AND ldpl_day.cy_month IN( SELECT DISTINCT cy_month 
                            FROM p_lew_mart_msi_ac.v_cal_calendarday
                            WHERE byr = ( SELECT  byr 
                                          FROM p_lew_mart_msi_ac.v_cal_calendarday
                                          WHERE dat_calendar = CURRENT_DATE - 1
                                        ) 
                          )
  AND ldpl_day.curr_tot_id = 0
  AND r_cl.dashboard_relevant_fg = 1
GROUP BY	ldpl_day.cy_month
	,r_cl.client_id
	,ldpl_day.feature_id
	,ldpl_day.discount_type_id
	,ldpl_day.coupon_type_id
)

,lp_umsatz AS (
SELECT	
   cal.cy_month    AS cy_month
	,r_cl.client_id   AS client_id
	,CASE WHEN SUM(lp_rcpt.total_net_val)=0 THEN NULL ELSE ROUND(SUM(lp_rcpt.total_net_val),2) END  AS lp_total_net_val
FROM	p_lew_mart_lidl_digital_ac.v_agg_client_rcpt_hdr_ldpl_day	AS lp_rcpt
INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday	AS cal
  ON 	lp_rcpt.dwh_cal_dt = cal.dat_calendar
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl
  ON 	lp_rcpt.client_id = r_cl.client_id
WHERE	lp_rcpt.aspect_id IN (2)
  AND cal.cy_month IN( SELECT DISTINCT cy_month 
                            FROM p_lew_mart_msi_ac.v_cal_calendarday
                            WHERE byr = ( SELECT  byr 
                                          FROM p_lew_mart_msi_ac.v_cal_calendarday
                                          WHERE dat_calendar = CURRENT_DATE - 1
                                        ) 
                      )
  AND lp_rcpt.curr_tot_id = 0
  AND r_cl.dashboard_relevant_fg = 1
GROUP BY	cal.cy_month
	,r_cl.client_id
)

SELECT	
   r_cl.client_id                                         AS client_id
	,r_cl.country_desc                                      AS client_desc
	,r_cl.country_iso_cd                                    AS country_iso_cd
	,cal.cy_month                                           AS cy_month
	,cal.cy_month_name                                      AS cy_month_name
	,lp_coupon_type.coupon_type_id                          AS coupon_type_id
	,lp_coupon_type.coupon_type_desc                        AS coupon_type_desc
	,lp_coupon_type_subgroup.coupon_type_group_id           AS coupon_type_group_id
	,lp_coupon_type_group.coupon_type_group_desc            AS coupon_type_group_desc
	,lp_coupon_type.coupon_type_subgroup_id                 AS coupon_type_subgroup_id
	,lp_coupon_type_subgroup.coupon_type_subgroup_desc      AS coupon_type_subgroup_desc
	,lp_feature.feature_id                                  AS feature_id
	,lp_feature.feature_desc                                AS feature_desc
	,lp_feature_subgroup.feature_group_id                   AS feature_group_id
	,lp_feature_group.feature_group_desc                    AS feature_group_desc
	,lp_feature.feature_subgroup_id                         AS feature_subgroup_id
	,lp_feature_subgroup.feature_subgroup_desc              AS feature_subgroup_desc
	,lp_discount_type.discount_type_id                      AS discount_type_id
	,lp_discount_type.discount_type_desc                    AS discount_type_desc
	,lp_feature_group.loyalty_id                            AS loyalty_id
	,lp_feature_group_loyalty.loyalty_desc                  AS loyalty_desc
	,SUM(lp_values.receipt_total_net_val_uniq)              AS receipt_total_net_val_uniq    --Berichtsname: Lidl Plus Bon (Anz.) mit LP Aktion LJ
	,ROUND(MAX(lp_customer.count_customer))                 AS count_customer               --Berichtsname:  Lidl Plus Einlöser (Anz.) mit LP Aktion LJ
	,ROUND(MAX(lp_values.discount_val))                     AS lp_preisveraenderung_aktion              --Berichtsname:  Lidl Plus Preisveränderung (LW) mit LP Aktion LJ
	,ROUND(CASE WHEN COALESCE(((DIV0(MAX(lp_values.discount_val) , (CASE WHEN MAX(lp_umsatz.lp_total_net_val)=0 THEN NULL ELSE MAX(lp_umsatz.lp_total_net_val) END))) * 100.0), 0)=0 THEN NULL ELSE COALESCE(((MAX(lp_values.discount_val) / (CASE WHEN MAX(lp_umsatz.lp_total_net_val)=0 THEN NULL ELSE MAX(lp_umsatz.lp_total_net_val) END)) * 100.0), 0) END,2) AS lp_preisveraenderung_aktion_prozent --Berichtsname: Lidl Plus Preisveränderung (%) mit LP Aktion LJ
	,ROUND(MAX(lp_values.lp_val_werbepv)) AS lp_werbepv_aktion   --Berichtsname: Lidl Plus Werbe-PV (LW) mit LP Aktion LJ
	,ROUND(CASE WHEN COALESCE(((DIV0(MAX(lp_values.lp_val_werbepv) , (CASE WHEN MAX(lp_umsatz.lp_total_net_val)=0 THEN NULL ELSE MAX(lp_umsatz.lp_total_net_val) END))) * 100.0), 0)=0 THEN NULL ELSE COALESCE(((MAX(lp_values.lp_val_werbepv) / (CASE WHEN MAX(lp_umsatz.lp_total_net_val)=0 THEN NULL ELSE MAX(lp_umsatz.lp_total_net_val) END)) * 100.0), 0) END,2) AS lp_werbe_pv_aktion_prozent    --Berichtsname: Lidl Plus Werbe-PV (%) mit LP Aktion LJ
	,ROUND(MAX(lp_values.lp_val_restantenverwert_sort))  AS lp_restantenverwert_sort    --Berichtsname: Lidl Plus Restantenverwertung (PV) Sortiment (LW) mit LP Aktion LJ
	,ROUND(CASE WHEN COALESCE(((DIV0(MAX(lp_values.lp_val_restantenverwert_sort) , (CASE WHEN MAX(lp_umsatz.lp_total_net_val)=0 THEN NULL ELSE MAX(lp_umsatz.lp_total_net_val) END))) * 100.0), 0)=0 THEN NULL ELSE COALESCE(((MAX(lp_values.lp_val_restantenverwert_sort) / (CASE WHEN MAX(lp_umsatz.lp_total_net_val)=0 THEN NULL ELSE MAX(lp_umsatz.lp_total_net_val) END)) * 100.0), 0) END,2) AS lp_restantenverwert_sort_prozent --Berichtsname:  Lidl Plus Restantenverwertung (PV) Sortiment (%) mit LP Aktion LJ
	,ROUND(MAX(lp_values.writeoff_val)) AS lp_abschriften_gesamt  --Berichtsname: Lidl Plus Abschriften Gesamt (LW) mit LP Aktion LJ
	,ROUND(CASE WHEN COALESCE(((DIV0(MAX(lp_values.writeoff_val) , (CASE WHEN MAX(lp_umsatz.lp_total_net_val)=0 THEN NULL ELSE MAX(lp_umsatz.lp_total_net_val) END))) * 100.0), 0)=0 THEN NULL ELSE COALESCE(((MAX(lp_values.writeoff_val) / (CASE WHEN MAX(lp_umsatz.lp_total_net_val)=0 THEN NULL ELSE MAX(lp_umsatz.lp_total_net_val) END)) * 100.0), 0) END,2) AS lp_abschriften_gesamt_prozent --Berichtsname: Lidl Plus Abschriften Gesamt (%) mit LP Aktion LJ
	,ROUND(MAX(lp_values.lp_val_restantenverwert_aktion))  AS lp_val_restantenverwert_aktion   --Berichtsname: Lidl Plus Restantenverwertung (PV) Aktion (LW) mit LP Aktion LJ
	,ROUND(CASE WHEN COALESCE(((DIV0(MAX(lp_values.lp_val_restantenverwert_aktion) , (CASE WHEN MAX(lp_umsatz.lp_total_net_val)=0 THEN NULL ELSE MAX(lp_umsatz.lp_total_net_val) END))) * 100.0), 0)=0 THEN NULL ELSE COALESCE(((MAX(lp_values.lp_val_restantenverwert_aktion) / (CASE WHEN MAX(lp_umsatz.lp_total_net_val)=0 THEN NULL ELSE MAX(lp_umsatz.lp_total_net_val) END)) * 100.0), 0) END,2) AS lp_restantenverwert_aktion_prozent_prozent --Berichtsname: Lidl Plus Restantenverwertung (PV) Aktion (%) mit LP Aktion LJ
FROM	lp_values AS lp_values
FULL OUTER JOIN	lp_customer AS lp_customer
  ON 	lp_values.client_id = lp_customer.client_id
  AND lp_values.coupon_type_id = lp_customer.coupon_type_id
  AND lp_values.cy_month = lp_customer.cy_month
  AND lp_values.discount_type_id = lp_customer.discount_type_id
  AND lp_values.feature_id = lp_customer.feature_id
LEFT OUTER JOIN	lp_umsatz AS lp_umsatz
  ON 	lp_values.client_id = lp_umsatz.client_id 
  AND lp_values.cy_month = lp_umsatz.cy_month
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type	AS lp_coupon_type
  ON 	lp_values.coupon_type_id = lp_coupon_type.coupon_type_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup	AS lp_coupon_type_subgroup
  ON 	lp_coupon_type.coupon_type_subgroup_id = lp_coupon_type_subgroup.coupon_type_subgroup_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_feature	AS lp_feature
  ON 	lp_values.feature_id = lp_feature.feature_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_feature_subgroup	AS lp_feature_subgroup
  ON 	lp_feature.feature_subgroup_id = lp_feature_subgroup.feature_subgroup_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_feature_group	AS lp_feature_group
  ON 	lp_feature_subgroup.feature_group_id = lp_feature_group.feature_group_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_discount_type	AS lp_discount_type
  ON 	lp_values.discount_type_id = lp_discount_type.discount_type_id
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl
  ON 	lp_values.client_id = r_cl.client_id
INNER JOIN	p_lew_mart_msi_ac.v_cal_month_desc	AS cal
  ON 	lp_values.cy_month = cal.cy_month
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_group AS lp_coupon_type_group
  ON 	lp_coupon_type_subgroup.coupon_type_group_id = lp_coupon_type_group.coupon_type_group_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_feature_group_loyalty	AS lp_feature_group_loyalty
  ON 	lp_feature_group.loyalty_id = lp_feature_group_loyalty.loyalty_id
GROUP BY	r_cl.client_id
	,r_cl.country_desc
	,r_cl.country_iso_cd
	,cal.cy_month
	,cal.cy_month_name
	,lp_coupon_type.coupon_type_id
	,lp_coupon_type.coupon_type_desc
	,lp_coupon_type_subgroup.coupon_type_group_id
	,lp_coupon_type_group.coupon_type_group_desc
	,lp_coupon_type.coupon_type_subgroup_id
	,lp_coupon_type_subgroup.coupon_type_subgroup_desc
	,lp_feature.feature_id
	,lp_feature.feature_desc
	,lp_feature_subgroup.feature_group_id
	,lp_feature_group.feature_group_desc
	,lp_feature.feature_subgroup_id
	,lp_feature_subgroup.feature_subgroup_desc
	,lp_discount_type.discount_type_id
	,lp_discount_type.discount_type_desc
	,lp_feature_group.loyalty_id
	,lp_feature_group_loyalty.loyalty_desc

ORDER BY 1,4,6,8,10,12,14,16,18,20
;