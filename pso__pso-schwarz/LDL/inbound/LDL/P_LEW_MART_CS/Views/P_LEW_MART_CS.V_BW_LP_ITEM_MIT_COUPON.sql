/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_LP_ITEM_MIT_COUPON
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2024    Ulrich Ross               Init
#  1.1  06.06.2024    Ulrich Ross               Add DIV0
#                                               User Story 711243     
#                                                                                
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_LP_ITEM_MIT_COUPON
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
  ,itemgroup_int_id
  ,itemgroup_int_desc
  ,lidl_plus_abverkauf_bereinigt_ejr_mit_lp_aktion_lj
  ,lidl_plus_umsatz_ejr_mit_lp_aktion_lj
  ,lidl_plus_preisveraenderung_mit_lp_aktion_lj
  ,Lidl_plus_preisveraenderung_mit_lp_aktion_lj_per
  ,lidl_plus_werbe_pv_mit_lp_aktion_lj
  ,Lidl_Plus_Werbe_PV_mit_LP_Aktion_LJ_per
  ,Lidl_Plus_Restantenverwertung_Sortiment_mit_LP_Aktion_LJ
  ,Lidl_Plus_Restantenverwertung_Sortiment_mit_LP_Aktion_LJ_per
  ,Lidl_Plus_Abschriften_Gesamt_mit_LP_Aktion_LJ
  ,Lidl_Plus_Abschriften_Gesamt_mit_LP_Aktion_LJ_per
  ,Lidl_Plus_Restantenverwertung_Aktion_mit_LP_Aktion_LJ
  ,Lidl_Plus_Restantenverwertung_Aktion_mit_LP_Aktion_LJ_per
  ,Lidl_Plus_Bon_mit_LP_Aktion_LJ
  ,Lidl_Plus_Bon_LW_mit_LP_AktionLJ
  ,Lidl_Plus_Einloeser_mit_LP_Aktion_LJ
 )
AS

WITH lp_itm_dr AS (
SELECT	
   sub_itm.itemgroup_int_id                                           AS itemgroup_int_id
	,ldpl_day.cy_month                                                  AS cy_month
	,itm.client_id                                                      AS client_id
	,ldpl_day.feature_id                                                AS feature_id
	,ldpl_day.discount_type_id                                          AS discount_type_id
	,lp_ct.coupon_type_id                                               AS coupon_type_id
	,SUM(DISTINCT ldpl_day.receipt_item_discount_piece_weight_qty_uniq) AS itm_discount_receipt
	,ROUND(SUM(DISTINCT ldpl_day.receipt_total_net_val_item_uniq), 5.0) AS itm_net_receipt
FROM	p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day	AS ldpl_day
INNER JOIN	p_lew_mart_lead_ac.v_itm_item	  AS itm
  ON 	ldpl_day.client_id = itm.client_id 
  AND ldpl_day.item_sid = itm.item_id
INNER JOIN	p_lew_mart_msi_ac.v_itm_subitemgroup	AS sub_itm
  ON 	itm.subitemgroup_id = sub_itm.subitemgroup_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type	AS lp_ct
  ON 	ldpl_day.coupon_type_id = lp_ct.coupon_type_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup	AS lp_cts
  ON 	lp_ct.coupon_type_subgroup_id = lp_cts.coupon_type_subgroup_id
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl
  ON 	itm.client_id = r_cl.client_id
WHERE	ldpl_day.curr_tot_id = 0 
  AND ldpl_day.aspect_id IN (2)
  AND sub_itm.itemgroup_int_id IN (-1000, -4, -3, -2, 0, 10, 20, 30, 32, 40, 50, 60, 70, 80, 90)
  AND lp_cts.coupon_type_group_id IN (0, 1, 2, 3, 4)
  AND r_cl.dashboard_relevant_fg = 1
  AND ldpl_day.cy_month IN (  SELECT DISTINCT cy_month 
                              FROM p_lew_mart_msi_ac.v_cal_calendarday
                              WHERE byr = ( SELECT  byr 
                                            FROM p_lew_mart_msi_ac.v_cal_calendarday
                                            WHERE dat_calendar = CURRENT_DATE - 1
                                          )
                            )
GROUP BY	sub_itm.itemgroup_int_id
  ,ldpl_day.cy_month
  ,itm.client_id
  ,ldpl_day.feature_id
  ,ldpl_day.discount_type_id
  ,lp_ct.coupon_type_id
)
    
 ,cust_c_typ AS (
SELECT	
   sub_itm.itemgroup_int_id            AS itemgroup_int_id
  ,ldpl_day.cy_month                   AS cy_month
  ,itm.client_id                       AS client_id
  ,ldpl_day.feature_id                 AS feature_id
  ,ldpl_day.discount_type_id           AS discount_type_id
  ,lp_ct.coupon_type_id                As coupon_type_id
  ,(1.00001 / 1.00001) * COUNT(DISTINCT (CASE WHEN lp_cts.coupon_type_group_id IN (2, 3, 4) THEN ldpl_day.CUSTOMER_SID ELSE NULL END))         AS cust_c_typ_1
  ,MAX ((CASE WHEN lp_cts.coupon_type_group_id IN (2, 3, 4) THEN 1 ELSE 0 END))                                                                AS c_typ_1
  ,(1.00001 / 1.00001) * COUNT(DISTINCT (CASE WHEN lp_cts.coupon_type_group_id IN (0, 1, 2, 3, 4) THEN ldpl_day.CUSTOMER_SID ELSE NULL END))   AS cust_c_typ_2
  ,MAX (CASE WHEN lp_cts.coupon_type_group_id IN (0, 1, 2, 3, 4) THEN 1 ELSE 0 END)                                                            AS c_typ_2
  ,CASE WHEN SUM(ldpl_day.discount_val)=0 THEN NULL ELSE SUM(ldpl_day.discount_val) END                                                        AS discount_val
  ,CASE WHEN SUM(ldpl_day.writeoff_val)=0 THEN NULL ELSE SUM(ldpl_day.writeoff_val) END                                                        AS writeoff_val
  ,COUNT(DISTINCT ldpl_day.receipt_total_net_val_uniq)  total_net_val
FROM	p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day	ldpl_day
INNER JOIN	p_lew_mart_lead_ac.v_itm_item	itm
  ON 	ldpl_day.client_id = itm.client_id 
  AND ldpl_day.item_sid = itm.item_id
INNER JOIN	p_lew_mart_msi_ac.v_itm_subitemgroup	sub_itm
  ON 	itm.subitemgroup_id = sub_itm.subitemgroup_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type	lp_ct
  ON 	ldpl_day.coupon_type_id = lp_ct.coupon_type_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup	lp_cts
  ON 	lp_ct.coupon_type_subgroup_id = lp_cts.coupon_type_subgroup_id
INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday	a16
  ON 	ldpl_day.DWH_CAL_DT = a16.dat_calendar
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	r_cl
  ON 	itm.client_id = r_cl.client_id
WHERE	ldpl_day.lidlplus_cust_fg = 'Y'
  AND 1 = 1
  AND ldpl_day.curr_tot_id = 0
  AND ldpl_day.aspect_id IN (2)
  AND sub_itm.itemgroup_int_id IN (-1000, -4, -3, -2, 0, 10, 20, 30, 32, 40, 50, 60, 70, 80, 90)
  AND r_cl.dashboard_relevant_fg = 1
  AND lp_cts.coupon_type_group_id IN (0, 1, 2, 3, 4)
  AND ldpl_day.cy_month IN ( SELECT DISTINCT cy_month 
                             FROM p_lew_mart_msi_ac.v_cal_calendarday
                             WHERE byr = ( SELECT  byr 
                                           FROM p_lew_mart_msi_ac.v_cal_calendarday
                                           WHERE dat_calendar = CURRENT_DATE - 1
                                          )
                            )
GROUP BY	sub_itm.itemgroup_int_id
	,ldpl_day.cy_month
	,itm.client_id
	,ldpl_day.feature_id
	,ldpl_day.discount_type_id
	,lp_ct.coupon_type_id
)
    
, lp_net_val AS ( 
SELECT	
   sub_itm.itemgroup_int_id        AS itemgroup_int_id
	,ldpl_day.cy_month               AS cy_month
	,org.client_id                   AS client_id
	,CASE WHEN SUM(ldpl_day.total_net_val)=0 THEN NULL ELSE SUM(ldpl_day.total_net_val) END  AS total_net_val
FROM	p_lew_mart_lidl_digital_ac.v_agg_client_store_item_ldpl_day	    AS ldpl_day
INNER JOIN	p_lew_mart_msi_ac.v_org_all_store_merge	                  AS org
  ON 	ldpl_day.aspect_id = org.aspect_id
  AND ldpl_day.client_id = org.client_id
  AND ldpl_day.move_to_store_id = org.move_to_store_id
INNER JOIN	p_lew_mart_lead_ac.v_itm_item	                            As itm
  ON 	ldpl_day.client_id = itm.client_id
  AND ldpl_day.item_sid = itm.item_id
  AND org.client_id = itm.client_id
INNER JOIN	p_lew_mart_msi_ac.v_itm_subitemgroup	                    AS sub_itm
  ON 	itm.subitemgroup_id = sub_itm.subitemgroup_id
WHERE org.aspect_id IN (2)
   AND ldpl_day.curr_tot_id= 0
   AND org.dashboard_relevant_fg = 1
   AND sub_itm.itemgroup_int_id IN (-1000, -4, -3, -2, 0, 10, 20, 30, 32, 40, 50, 60, 70, 80, 90)
   AND ldpl_day.cy_month IN ( SELECT DISTINCT cy_month 
                              FROM p_lew_mart_msi_ac.v_cal_calendarday
                              WHERE byr = ( SELECT  byr 
                                            FROM p_lew_mart_msi_ac.v_cal_calendarday
                                            WHERE dat_calendar = CURRENT_DATE - 1
                                          )
                            )
GROUP BY	sub_itm.itemgroup_int_id
	,ldpl_day.cy_month
	,org.client_id
)

    
, lp_pwco AS (
SELECT	
   sub_itm.itemgroup_int_id                 AS itemgroup_int_id
	,ldpl_day.cy_month                        AS cy_month
	,itm.client_id                            AS client_id
	,ldpl_day.feature_id                      AS feature_id
	,ldpl_day.discount_type_id                AS discount_type_id
	,lp_ct.coupon_type_id                     As coupon_type_id
	,CASE WHEN ldpl_day.pcwo_reason_id=41 THEN CASE WHEN SUM(ldpl_day.discount_val)=0 THEN NULL ELSE SUM(ldpl_day.discount_val) END END                 AS lp_41_discount_receipt
	,CASE WHEN ldpl_day.pcwo_reason_id=43 THEN CASE WHEN SUM(ldpl_day.discount_val)=0 THEN NULL ELSE SUM(ldpl_day.discount_val) END END                 AS lp_43_discount_receipt
  ,CASE WHEN ldpl_day.pcwo_reason_id IN (6, 81, 151) THEN CASE WHEN SUM(ldpl_day.writeoff_val)=0 THEN NULL ELSE SUM(ldpl_day.writeoff_val) END END    AS lp_writeoff
FROM	p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day	AS ldpl_day
INNER JOIN	p_lew_mart_lead_ac.v_itm_item AS itm
  ON 	ldpl_day.client_id = itm.client_id
  AND ldpl_day.item_sid = itm.item_id
INNER JOIN	p_lew_mart_msi_ac.v_itm_subitemgroup	AS sub_itm
  ON 	itm.subitemgroup_id = sub_itm.subitemgroup_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type	AS lp_ct
  ON 	ldpl_day.coupon_type_id = lp_ct.coupon_type_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup	AS lp_cts
  ON 	lp_ct.coupon_type_subgroup_id = lp_cts.coupon_type_subgroup_id
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl
  ON 	itm.client_id = r_cl.client_id
WHERE	ldpl_day.pcwo_reason_id IN (41, 43 ,6, 81, 151)
 AND ldpl_day.lidlplus_cust_fg IN ('Y')
 AND ldpl_day.curr_tot_id = 0
 AND ldpl_day.aspect_id IN (2)
 AND sub_itm.itemgroup_int_id IN (-1000, -4, -3, -2, 0, 10, 20, 30, 32, 40, 50, 60, 70, 80, 90)
 AND lp_cts.coupon_type_group_id IN (0, 1, 2, 3, 4)
 AND r_cl.dashboard_relevant_fg = 1
 AND ldpl_day.cy_month IN ( SELECT DISTINCT cy_month 
                            FROM p_lew_mart_msi_ac.v_cal_calendarday
                            WHERE byr = ( SELECT  byr 
                                          FROM p_lew_mart_msi_ac.v_cal_calendarday
                                          WHERE dat_calendar = CURRENT_DATE - 1
                                        )
                              )
GROUP BY	sub_itm.itemgroup_int_id
  ,ldpl_day.cy_month
  ,itm.client_id
  ,ldpl_day.feature_id
  ,ldpl_day.discount_type_id
  ,lp_ct.coupon_type_id
  ,ldpl_day.pcwo_reason_id
)
	



, lp_itmgrp_dr AS (
SELECT	
  COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id)   AS itemgroup_int_id
	,COALESCE(pldpl_day.cy_month, cust_c_typ.cy_month)                  AS cy_month
	,r_cl.client_id                                                     AS client_id
	,COALESCE(pldpl_day.feature_id, cust_c_typ.feature_id)              AS feature_id
	,COALESCE(pldpl_day.discount_type_id, cust_c_typ.discount_type_id)  AS discount_type_id
	,lp_ct.coupon_type_id                                               AS coupon_type_id
	,COALESCE((pldpl_day.itm_net_receipt / (CASE WHEN cust_c_typ.total_net_val=0 THEN NULL ELSE cust_c_typ.total_net_val END)), 0)  AS discount_receipt
FROM	 lp_itm_dr	AS pldpl_day
FULL OUTER JOIN	cust_c_typ	AS cust_c_typ
  ON 	pldpl_day.client_id = cust_c_typ.client_id
  AND pldpl_day.coupon_type_id = cust_c_typ.coupon_type_id
  AND pldpl_day.cy_month = cust_c_typ.cy_month
  AND pldpl_day.discount_type_id = cust_c_typ.discount_type_id
  AND pldpl_day.feature_id = cust_c_typ.feature_id
  AND pldpl_day.itemgroup_int_id = cust_c_typ.itemgroup_int_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type	AS lp_ct
  ON 	COALESCE(pldpl_day.coupon_type_id, cust_c_typ.coupon_type_id) = lp_ct.coupon_type_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup	AS lp_cts
  ON 	lp_ct.coupon_type_subgroup_id = lp_cts.coupon_type_subgroup_id
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl
  ON 	COALESCE(pldpl_day.client_id, cust_c_typ.client_id) = r_cl.client_id
WHERE	r_cl.dashboard_relevant_fg = 1
  AND COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id) IN (-1000, -4, -3, -2, 0, 10, 20, 30, 32, 40, 50, 60, 70, 80, 90)
  AND lp_cts.coupon_type_group_id IN (0, 1, 2, 3, 4)
)
 


, lp_cust_c_typ2 AS (
SELECT	
  cust_c_typ.coupon_type_id             AS coupon_type_id
	,cust_c_typ.discount_type_id          AS discount_type_id
	,cust_c_typ.feature_id                AS feature_id
	,cust_c_typ.client_id                 AS client_id
	,cust_c_typ.cy_month                  AS cy_month
	,cust_c_typ.itemgroup_int_id          AS itemgroup_int_id
	,cust_c_typ.cust_c_typ_2              AS cust_c_typ_2
FROM	cust_c_typ	AS cust_c_typ
WHERE	cust_c_typ.c_typ_2 = 1
)

--, lp_artikelebene AS (
SELECT	
   ldpl_day4.client_id                                   AS client_id
	,ldpl_day4.country_desc                                AS client_desc
  ,ldpl_day4.country_iso_cd                              AS country_iso_cd
	,ldpl_day5.cy_month                                    AS cy_month
	,ldpl_day5.cy_month_name                               AS cy_month_name
	,lp_ct.coupon_type_id                                  AS coupon_type_id
	,lp_ct.coupon_type_desc                                AS coupon_type_desc
	,ldpl_day0.coupon_type_group_id                        AS coupon_type_group_id
	,ldpl_day7.coupon_type_group_desc                      AS coupon_type_group_desc
	,lp_ct.coupon_type_subgroup_id                         AS coupon_type_subgroup_id
	,ldpl_day0.coupon_type_subgroup_desc                   AS coupon_type_subgroup_desc
	,ldpl_day1.feature_id                                  AS feature_id
	,ldpl_day1.feature_desc                                AS feature_desc
	,ldpl_day2.feature_group_id                            AS feature_group_id
	,ldpl_day8.feature_group_desc                          AS feature_group_desc
	,ldpl_day1.feature_subgroup_id                         AS feature_subgroup_id
	,ldpl_day2.feature_subgroup_desc                       AS feature_subgroup_desc
	,ldpl_day3.discount_type_id                            AS discount_type_id
	,ldpl_day3.discount_type_desc                          AS discount_type_desc
  ,ldpl_day8.loyalty_id                                  AS loyalty_id
	,lp_feature_group_loyalty.loyalty_desc                 AS loyalty_desc  
	,ldpl_day6.itemgroup_int_id                            AS itemgroup_int_id
	,ldpl_day6.itemgroup_int_desc                          AS itemgroup_int_desc
	,ROUND(MAX (pldpl_day.itm_discount_receipt))           AS lidl_plus_abverkauf_bereinigt_ejr_mit_lp_aktion_lj
	,ROUND(MAX (pldpl_day.itm_net_receipt))                AS lidl_plus_umsatz_ejr_mit_lp_aktion_lj
	,ROUND(MAX (cust_c_typ.discount_val))                  AS lidl_plus_preisveraenderung_mit_lp_aktion_lj
	,ROUND(CASE WHEN COALESCE(((DIV0(MAX (cust_c_typ.discount_val) , (CASE WHEN MAX ( lp_net_val.total_net_val)=0 THEN NULL ELSE MAX ( lp_net_val.total_net_val) END))) * 100.0), 0)=0 THEN NULL ELSE COALESCE(((MAX (cust_c_typ.discount_val) / (CASE WHEN MAX ( lp_net_val.total_net_val)=0 THEN NULL ELSE MAX ( lp_net_val.total_net_val) END)) * 100.0), 0) END,2)                 AS Lidl_plus_preisveraenderung_mit_lp_aktion_lj_per
	,ROUND(MAX (lp_pwco.lp_41_discount_receipt))       AS lidl_plus_werbe_pv_mit_lp_aktion_lj
	,ROUND(CASE WHEN COALESCE(((DIV0(MAX (lp_pwco.lp_41_discount_receipt) , (CASE WHEN MAX ( lp_net_val.total_net_val)=0 THEN NULL ELSE MAX ( lp_net_val.total_net_val) END))) * 100.0), 0)=0 THEN NULL ELSE COALESCE(((MAX (lp_pwco.lp_41_discount_receipt) / (CASE WHEN MAX ( lp_net_val.total_net_val)=0 THEN NULL ELSE MAX ( lp_net_val.total_net_val) END)) * 100.0), 0) END,2)   AS Lidl_Plus_Werbe_PV_mit_LP_Aktion_LJ_per
	,ROUND(MAX (lp_pwco.lp_43_discount_receipt))      AS Lidl_Plus_Restantenverwertung_Sortiment_mit_LP_Aktion_LJ
	,ROUND(CASE WHEN COALESCE(((DIV0(MAX (lp_pwco.lp_43_discount_receipt) , (CASE WHEN MAX ( lp_net_val.total_net_val)=0 THEN NULL ELSE MAX ( lp_net_val.total_net_val) END))) * 100.0), 0)=0 THEN NULL ELSE COALESCE(((MAX (lp_pwco.lp_43_discount_receipt) / (CASE WHEN MAX ( lp_net_val.total_net_val)=0 THEN NULL ELSE MAX ( lp_net_val.total_net_val) END)) * 100.0), 0) END,2)   AS Lidl_Plus_Restantenverwertung_Sortiment_mit_LP_Aktion_LJ_per
	,ROUND(MAX (cust_c_typ.writeoff_val))             AS Lidl_Plus_Abschriften_Gesamt_mit_LP_Aktion_LJ
	,ROUND(CASE WHEN COALESCE(((DIV0(MAX (cust_c_typ.writeoff_val) , (CASE WHEN MAX ( lp_net_val.total_net_val)=0 THEN NULL ELSE MAX ( lp_net_val.total_net_val) END))) * 100.0), 0)=0 THEN NULL ELSE COALESCE(((MAX (cust_c_typ.writeoff_val) / (CASE WHEN MAX ( lp_net_val.total_net_val)=0 THEN NULL ELSE MAX ( lp_net_val.total_net_val) END)) * 100.0), 0) END,2)                 AS Lidl_Plus_Abschriften_Gesamt_mit_LP_Aktion_LJ_per
	,ROUND(MAX (lp_pwco.lp_writeoff))                 AS Lidl_Plus_Restantenverwertung_Aktion_mit_LP_Aktion_LJ
	,ROUND(CASE WHEN COALESCE(((DIV0(MAX (lp_pwco.lp_writeoff) , (CASE WHEN MAX ( lp_net_val.total_net_val)=0 THEN NULL ELSE MAX ( lp_net_val.total_net_val) END))) * 100.0), 0)=0 THEN NULL ELSE COALESCE(((MAX (lp_pwco.lp_writeoff) / (CASE WHEN MAX ( lp_net_val.total_net_val)=0 THEN NULL ELSE MAX ( lp_net_val.total_net_val) END)) * 100.0), 0) END,2)                         AS Lidl_Plus_Restantenverwertung_Aktion_mit_LP_Aktion_LJ_per
	,ROUND(MAX (cust_c_typ.total_net_val))            AS Lidl_Plus_Bon_mit_LP_Aktion_LJ
	,ROUND(MAX (lp_itmgrp_dr.discount_receipt),2)       AS Lidl_Plus_Bon_LW_mit_LP_AktionLJ
	,ROUND(MAX (lp_cust_c_typ2.cust_c_typ_2))       AS Lidl_Plus_Einloeser_mit_LP_Aktion_LJ
FROM	 lp_itm_dr	pldpl_day
FULL OUTER JOIN	cust_c_typ	AS cust_c_typ   
  ON 	pldpl_day.client_id = cust_c_typ.client_id
  AND pldpl_day.coupon_type_id = cust_c_typ.coupon_type_id
  AND pldpl_day.cy_month = cust_c_typ.cy_month
  AND pldpl_day.discount_type_id = cust_c_typ.discount_type_id
  AND pldpl_day.feature_id = cust_c_typ.feature_id
  AND pldpl_day.itemgroup_int_id = cust_c_typ.itemgroup_int_id
FULL OUTER JOIN	lp_pwco	AS lp_pwco
  ON 	COALESCE(pldpl_day.client_id, cust_c_typ.client_id) = lp_pwco.client_id
  AND COALESCE(pldpl_day.coupon_type_id, cust_c_typ.coupon_type_id) = lp_pwco.coupon_type_id
  AND COALESCE(pldpl_day.cy_month, cust_c_typ.cy_month) = lp_pwco.cy_month
  AND COALESCE(pldpl_day.discount_type_id, cust_c_typ.discount_type_id) = lp_pwco.discount_type_id
  AND COALESCE(pldpl_day.feature_id, cust_c_typ.feature_id) = lp_pwco.feature_id
  AND COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id) = lp_pwco.itemgroup_int_id
FULL OUTER JOIN	lp_itmgrp_dr	AS lp_itmgrp_dr
  ON 	COALESCE(pldpl_day.client_id, cust_c_typ.client_id, lp_pwco.client_id) = lp_itmgrp_dr.client_id
  AND COALESCE(pldpl_day.coupon_type_id, cust_c_typ.coupon_type_id, lp_pwco.coupon_type_id) = lp_itmgrp_dr.coupon_type_id
  AND COALESCE(pldpl_day.cy_month, cust_c_typ.cy_month, lp_pwco.cy_month) = lp_itmgrp_dr.cy_month
  AND COALESCE(pldpl_day.discount_type_id, cust_c_typ.discount_type_id, lp_pwco.discount_type_id) = lp_itmgrp_dr.discount_type_id
  AND COALESCE(pldpl_day.feature_id, cust_c_typ.feature_id, lp_pwco.feature_id) = lp_itmgrp_dr.feature_id
  AND COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id, lp_pwco.itemgroup_int_id) = lp_itmgrp_dr.itemgroup_int_id
FULL OUTER JOIN	lp_cust_c_typ2	AS lp_cust_c_typ2  
  ON 	COALESCE(pldpl_day.client_id, cust_c_typ.client_id, lp_pwco.client_id, lp_itmgrp_dr.client_id) = lp_cust_c_typ2.client_id
  AND COALESCE(pldpl_day.coupon_type_id, cust_c_typ.coupon_type_id, lp_pwco.coupon_type_id, lp_itmgrp_dr.coupon_type_id) = lp_cust_c_typ2.coupon_type_id
  AND COALESCE(pldpl_day.cy_month, cust_c_typ.cy_month, lp_pwco.cy_month, lp_itmgrp_dr.cy_month) = lp_cust_c_typ2.cy_month
  AND COALESCE(pldpl_day.discount_type_id, cust_c_typ.discount_type_id, lp_pwco.discount_type_id, lp_itmgrp_dr.discount_type_id) = lp_cust_c_typ2.discount_type_id
  AND COALESCE(pldpl_day.feature_id, cust_c_typ.feature_id, lp_pwco.feature_id, lp_itmgrp_dr.feature_id) = lp_cust_c_typ2.feature_id
  AND COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id, lp_pwco.itemgroup_int_id, lp_itmgrp_dr.itemgroup_int_id) = lp_cust_c_typ2.itemgroup_int_id
LEFT OUTER JOIN	lp_net_val	AS lp_net_val 
  ON 	COALESCE(pldpl_day.client_id, cust_c_typ.client_id, lp_pwco.client_id, lp_itmgrp_dr.client_id, lp_cust_c_typ2.client_id) = lp_net_val.client_id 
  AND COALESCE(pldpl_day.cy_month, cust_c_typ.cy_month, lp_pwco.cy_month, lp_itmgrp_dr.cy_month, lp_cust_c_typ2.cy_month) = lp_net_val.cy_month
  AND COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id, lp_pwco.itemgroup_int_id, lp_itmgrp_dr.itemgroup_int_id, lp_cust_c_typ2.itemgroup_int_id) = lp_net_val.itemgroup_int_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type	AS lp_ct
  ON 	COALESCE(pldpl_day.coupon_type_id, cust_c_typ.coupon_type_id, lp_pwco.coupon_type_id, lp_itmgrp_dr.coupon_type_id, lp_cust_c_typ2.coupon_type_id) = lp_ct.coupon_type_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup	AS ldpl_day0
  ON 	lp_ct.coupon_type_subgroup_id = ldpl_day0.coupon_type_subgroup_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_feature	AS ldpl_day1
  ON 	COALESCE(pldpl_day.feature_id, cust_c_typ.feature_id, lp_pwco.feature_id, lp_itmgrp_dr.feature_id, lp_cust_c_typ2.feature_id) = ldpl_day1.feature_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_feature_subgroup	AS ldpl_day2
  ON 	ldpl_day1.feature_subgroup_id = ldpl_day2.feature_subgroup_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_discount_type	AS ldpl_day3
  ON 	COALESCE(pldpl_day.discount_type_id, cust_c_typ.discount_type_id, lp_pwco.discount_type_id, lp_itmgrp_dr.discount_type_id, lp_cust_c_typ2.discount_type_id) = ldpl_day3.discount_type_id
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS ldpl_day4
  ON 	COALESCE(pldpl_day.client_id, cust_c_typ.client_id, lp_pwco.client_id, lp_itmgrp_dr.client_id, lp_cust_c_typ2.client_id) = ldpl_day4.client_id
INNER JOIN	p_lew_mart_msi_ac.v_cal_month_desc	AS ldpl_day5
  ON 	COALESCE(pldpl_day.cy_month, cust_c_typ.cy_month, lp_pwco.cy_month, lp_itmgrp_dr.cy_month, lp_cust_c_typ2.cy_month) = ldpl_day5.cy_month
INNER JOIN	p_lew_mart_msi_ac.v_itm_itemgroup_int	AS ldpl_day6
  ON 	COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id, lp_pwco.itemgroup_int_id, lp_itmgrp_dr.itemgroup_int_id, lp_cust_c_typ2.itemgroup_int_id) = ldpl_day6.itemgroup_int_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_group	AS ldpl_day7
  ON 	ldpl_day0.coupon_type_group_id = ldpl_day7.coupon_type_group_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_feature_group	AS ldpl_day8
  ON 	ldpl_day2.feature_group_id = ldpl_day8.feature_group_id
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_feature_group_loyalty	AS lp_feature_group_loyalty
  ON 	ldpl_day8.loyalty_id = lp_feature_group_loyalty.loyalty_id   
GROUP BY	ldpl_day4.client_id
	,ldpl_day4.country_desc
  ,ldpl_day4.country_iso_cd
	,ldpl_day5.cy_month
	,ldpl_day5.cy_month_name
	,lp_ct.coupon_type_id
	,lp_ct.coupon_type_desc
	,ldpl_day0.coupon_type_group_id
	,ldpl_day7.coupon_type_group_desc
	,lp_ct.coupon_type_subgroup_id
	,ldpl_day0.coupon_type_subgroup_desc
	,ldpl_day1.feature_id
	,ldpl_day1.feature_desc
	,ldpl_day2.feature_group_id
	,ldpl_day8.feature_group_desc
	,ldpl_day1.feature_subgroup_id
	,ldpl_day2.feature_subgroup_desc
	,ldpl_day3.discount_type_id
	,ldpl_day3.discount_type_desc
	,ldpl_day6.itemgroup_int_id
	,ldpl_day6.itemgroup_int_desc
  ,ldpl_day8.loyalty_id
  ,lp_feature_group_loyalty.loyalty_desc
;