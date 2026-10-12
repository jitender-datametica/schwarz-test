/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_LP_ORGA_OHNE_COUPON
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2024    Ulrich Ross               Init
#  1.1  06.06.2024    Ulrich Ross               Add DIV0
#                                               User Story 711243
#     
#                                                                                
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_LP_ORGA_OHNE_COUPON
(
   client_id
  ,country_desc
  ,country_iso_cd
  ,cy_month
  ,cy_month_name
  ,non_lp_werbe_pv
  ,lp_werbe_pv
  ,gesamt_werbe_pv
  ,non_lp_werbe_pv_prozent
  ,lp_werbe_pv_prozent
  ,gesamt_werbe_pv_prozent
  ,lp_preisveraenderung
  ,non_lp_preisveraenderung
  ,gesamt_preisveraenderung
  ,non_lp_abschriften
  ,lp_abschriften
  ,gesamt_abschriften
  ,non_lp_abschriften_prozent
  ,lp_abschriften_prozent
  ,gesamt_abschriften_prozent
  ,lp_Kunden_anz
  ,dv_anteil_lp_kunden_prozent
  ,gesamt_preisveraenderung_prozent
  ,lp_preisveraenderung_prozent
  ,non_lp_preisveraenderung_prozent
  ,lp_deregistrierung_anz
  ,gesamt_bon_anz
  ,non_lp_count_receipt
  ,lp_umsatz_ejr
  ,lp_bon_durchschn
  ,gesamt_bon_durchschn
  ,non_lp_bon_durchschn
  ,lp_bon_identifizierungsrate
  ,lp_einkaufsfrequenz
  ,lp_umsatzanteil_prozent
  ,lp_bon_anz
  ,all_receipt_count
  ,gesamt_umsatz_ejr
  ,lp_registrierte_Nutzer_anz
  ,non_lp_umsatz_ejr
  ,filialen_anz
  ,lp_neuregistrierungen_anz
 )
 AS
--LP Preisveränderung und Abschriften IN LW (Werbe-PV and pcwo_reason_id = 41)
WITH werbe_pv AS (
SELECT	
   cal.cy_month  AS cy_month
	,r_cl.client_id  AS client_id
	,SUM((CASE WHEN (rcpt_lp_day.lidlplus_cust_fg IN ('N') AND rcpt_lp_day.pcwo_reason_id IN (41)) THEN rcpt_lp_day.discount_val ELSE NULL END)) AS non_lp_discount_val_wpv
	,SUM((CASE WHEN (rcpt_lp_day.lidlplus_cust_fg IN ('Y') AND rcpt_lp_day.pcwo_reason_id IN (41)) THEN rcpt_lp_day.discount_val ELSE NULL END)) AS lp_discount_val_wpv
	,SUM((CASE WHEN rcpt_lp_day.pcwo_reason_id IN (41) THEN rcpt_lp_day.discount_val ELSE NULL END)) AS all_discount_val_wpv
	,SUM((CASE WHEN rcpt_lp_day.lidlplus_cust_fg = ('N') THEN rcpt_lp_day.writeoff_val ELSE NULL END)) AS non_lp_writeoff_val_wpv
	,SUM((CASE WHEN rcpt_lp_day.lidlplus_cust_fg = ('Y') THEN rcpt_lp_day.writeoff_val ELSE NULL END)) AS lp_writeoff_val_wpv
	,SUM(rcpt_lp_day.writeoff_val) AS all_writeoff_val_wpv
FROM	p_lew_mart_lidl_digital_ac.v_agg_rcpt_hdr_ldpl_day AS rcpt_lp_day
INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday AS cal
  ON 	rcpt_lp_day.dwh_cal_dt = cal.dat_calendar
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl
  ON 	rcpt_lp_day.client_id = r_cl.client_id
WHERE	rcpt_lp_day.aspect_id IN (2)
  AND cal.cy_month  IN (SELECT DISTINCT cy_month 
                        FROM p_lew_mart_msi_ac.v_cal_calendarday
                        WHERE byr = ( SELECT  byr 
                                      FROM p_lew_mart_msi_ac.v_cal_calendarday
                                      WHERE dat_calendar = CURRENT_DATE - 1
                                              ) 
                        )
  AND rcpt_lp_day.curr_tot_id = 0
  AND r_cl.dashboard_relevant_fg = 1
GROUP BY	cal.cy_month
	,r_cl.client_id
  )
  
,pv_tnv AS (
SELECT	
   cal.cy_month AS cy_month
	,r_cl.client_id AS client_id
	,SUM((CASE WHEN rcpt_lp_day.lidlplus_cust_fg = 'Y' THEN rcpt_lp_day.discount_val ELSE NULL END)) AS lp_discount_val
	,SUM((CASE WHEN rcpt_lp_day.lidlplus_cust_fg = 'Y' THEN rcpt_lp_day.total_net_val ELSE NULL END)) AS lp_total_net_val
	,SUM((CASE WHEN rcpt_lp_day.lidlplus_cust_fg = 'N' THEN rcpt_lp_day.discount_val ELSE NULL END)) AS non_lp_discount_val
	,SUM((CASE WHEN rcpt_lp_day.lidlplus_cust_fg = 'N' THEN rcpt_lp_day.total_net_val ELSE NULL END)) AS  non_lp_total_net_val
	,SUM(rcpt_lp_day.discount_val) AS all_discount_val 
	,SUM(rcpt_lp_day.total_net_val) AS all_total_net_val  
FROM	p_lew_mart_lidl_digital_ac.v_agg_client_rcpt_hdr_ldpl_day	AS rcpt_lp_day
INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday AS cal
  ON 	rcpt_lp_day.dwh_cal_dt = cal.dat_calendar
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl
  ON 	rcpt_lp_day.client_id = r_cl.client_id
WHERE	rcpt_lp_day.aspect_id IN (2)
  AND cal.cy_month  IN (SELECT DISTINCT cy_month 
                        FROM p_lew_mart_msi_ac.v_cal_calendarday
                        WHERE byr = ( SELECT  byr 
                                      FROM p_lew_mart_msi_ac.v_cal_calendarday
                                      WHERE dat_calendar = CURRENT_DATE - 1
                                              ) 
                        )
  AND rcpt_lp_day.curr_tot_id = 0
  AND r_cl.dashboard_relevant_fg = 1
GROUP BY	cal.cy_month
,r_cl.client_id
 )

,count_receipt_cust AS (
SELECT	
   rcpt_lp_item_day.cy_month AS cy_month
	,r_cl.client_id AS client_id
  ,rcpt_lp_item_day.lidlplus_cust_fg AS lidlplus_cust_fg
	,COUNT(DISTINCT rcpt_lp_item_day.receipt_cnt) AS count_receipt
  ,CASE WHEN ((1.00001 / 1.00001) * COUNT(DISTINCT rcpt_lp_item_day.customer_sid))=0 THEN NULL 
        ELSE ((1.00001 / 1.00001) * COUNT(DISTINCT rcpt_lp_item_day.customer_sid)) END  AS count_customer
FROM	p_lew_mart_lidl_digital_ac.v_agg_client_store_rcpt_item_ldpl_day AS rcpt_lp_item_day
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl  
  ON 	rcpt_lp_item_day.client_id = r_cl.client_id
WHERE rcpt_lp_item_day.aspect_id IN (2)
  AND rcpt_lp_item_day.cy_month  IN (SELECT DISTINCT cy_month 
                        FROM p_lew_mart_msi_ac.v_cal_calendarday
                        WHERE byr = ( SELECT  byr 
                                      FROM p_lew_mart_msi_ac.v_cal_calendarday
                                      WHERE dat_calendar = CURRENT_DATE - 1
                                              ) 
                        )
  AND r_cl.dashboard_relevant_fg = 1
GROUP BY	rcpt_lp_item_day.cy_month
	,r_cl.client_id
  ,rcpt_lp_item_day.lidlplus_cust_fg
)

--LIDL PLUS WriteOff und receipt count
, lp_wo_rc AS (
SELECT	
   COALESCE(werbe_pv.cy_month, count_receipt.cy_month)  AS cy_month
	,COALESCE(werbe_pv.client_id, count_receipt.client_id) AS client_id
	,werbe_pv.non_lp_writeoff_val_wpv  AS non_lp_writeoff_val_wpv
	,count_receipt.count_receipt  AS lp_count_receipt
FROM	werbe_pv AS werbe_pv
FULL OUTER JOIN	count_receipt_cust AS count_receipt
  ON werbe_pv.client_id = count_receipt.client_id 
  AND werbe_pv.cy_month = count_receipt.cy_month
WHERE count_receipt.lidlplus_cust_fg = 'Y'
)

--LIDL PLUS WriteOff Werbe-pv and NON LIDL PLUS receipt count and total net 
, lp_wo_wpv_non_lp_cr_tnv AS ( 
SELECT	
   COALESCE(werbe_pv.cy_month, count_receipt.cy_month, pv_tnv.cy_month) AS cy_month
	,COALESCE(werbe_pv.client_id, count_receipt.client_id, pv_tnv.client_id) AS client_id
	,werbe_pv.lp_writeoff_val_wpv  AS lp_writeoff_val_wpv
	,count_receipt.count_receipt AS non_lp_count_receipt
	,pv_tnv.non_lp_total_net_val AS non_lp_total_net_val
FROM	werbe_pv AS werbe_pv
FULL OUTER JOIN	count_receipt_cust AS count_receipt
  ON 	werbe_pv.client_id = count_receipt.client_id 
  AND werbe_pv.cy_month = count_receipt.cy_month
FULL OUTER JOIN	pv_tnv AS pv_tnv
  ON 	COALESCE(werbe_pv.client_id, count_receipt.client_id) = pv_tnv.client_id
  AND COALESCE(werbe_pv.cy_month, count_receipt.cy_month) = pv_tnv.cy_month
 WHERE count_receipt.lidlplus_cust_fg = 'N'
)

--all count receipt (berechnet) and write off (Werbe-PV)
,all_wo_cr AS (
SELECT	
   COALESCE(werbe_pv.cy_month, count_receipt.cy_month) AS cy_month
	,COALESCE(werbe_pv.client_id, count_receipt.client_id) AS client_id
	,werbe_pv.all_writeoff_val_wpv AS all_writeoff_val_wpv
	,SUM(count_receipt.count_receipt)   AS all_receipt_count
FROM	werbe_pv AS werbe_pv
FULL OUTER JOIN	count_receipt_cust AS count_receipt
  ON werbe_pv.client_id = count_receipt.client_id 
  AND werbe_pv.cy_month = count_receipt.cy_month
GROUP BY 1,2,3
)

--LIDL PLUS count receipt
 ,lp_cc AS (
SELECT	
   count_receipt_cust.cy_month AS cy_month
	,count_receipt_cust.client_id AS client_id
	,SUM(count_receipt_cust.count_customer)          AS lp_count_customer
FROM	count_receipt_cust AS count_receipt_cust
WHERE	count_receipt_cust.lidlplus_cust_fg = 'Y'
GROUP BY	count_receipt_cust.cy_month
  ,count_receipt_cust.client_id
 )

--LIDL PLUS customer registration and deregistration
,lp_reg_dereg AS (
SELECT	
   lp_cust_reg_dereg.cy_month AS cy_month
	,r_cl.client_id AS client_id
  ,SUM((lp_cust_reg_dereg.cm_dereg_cnt * 1.0)) AS lp_cust_dereg_count
	,SUM((lp_cust_reg_dereg.cm_total_new_reg_cnt * 1.0)) AS lp_total_new_reg_count
	,SUM((lp_cust_reg_dereg.cm_reg_cnt * 1.0)) AS lp_reg_count
FROM	p_lew_mart_lidl_digital_ac.v_agg_cust_reg_dereg_ldpl_mth AS lp_cust_reg_dereg
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl
  ON 	lp_cust_reg_dereg.client_id = r_cl.client_id
WHERE	lp_cust_reg_dereg.cy_month IN ( SELECT DISTINCT cy_month 
                                      FROM p_lew_mart_msi_ac.v_cal_calendarday
                                      WHERE byr = ( SELECT  byr 
                                                    FROM p_lew_mart_msi_ac.v_cal_calendarday
                                                    WHERE dat_calendar = CURRENT_DATE - 1
                                                            ) 
                                    )
  AND r_cl.dashboard_relevant_fg = 1
GROUP BY	lp_cust_reg_dereg.cy_month
  ,r_cl.client_id
)

--Store move to store
,store_move AS (
SELECT	
   store_open_month.cy_month AS cy_month
	,r_cl.client_id AS client_id
	,COUNT(DISTINCT store_open_month.client_id || '_' || store_open_month.move_to_store_id) AS client_move_to_store
FROM	p_lew_mart_lidl_digital_ac.v_store_open_month	AS store_open_month
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl
  ON 	store_open_month.client_id = r_cl.client_id
WHERE	store_open_month.cm_mth_ending_str_open_fg = 1
  AND store_open_month.aspect_id IN (2)
  AND r_cl.dashboard_relevant_fg = 1
  AND store_open_month.cy_month IN (SELECT DISTINCT cy_month 
                                    FROM p_lew_mart_msi_ac.v_cal_calendarday
                                    WHERE byr = ( SELECT  byr 
                                                  FROM p_lew_mart_msi_ac.v_cal_calendarday
                                                  WHERE dat_calendar = CURRENT_DATE - 1
                                                          ) 
                                    )
GROUP BY	store_open_month.cy_month
	,r_cl.client_id
)



SELECT	
   r_cl.client_id                                                                                                       AS client_id     
	,r_cl.country_desc                                                                                                    AS country_desc   
	,r_cl.country_iso_cd                                                                                                  AS country_iso_cd 
	,cal.cy_month                                                                                                         AS cy_month
	,cal.cy_month_name                                                                                                    AS cy_month_name
  ,ROUND(MAX(werbe_pv.non_lp_discount_val_wpv),2)                                                                       AS non_lp_werbe_pv                                               --Bericht: Non-Lidl Plus Werbe-PV MAX(pa13.wjxbfs1)  wjxbfs1
  ,ROUND(MAX(werbe_pv.lp_discount_val_wpv),2)                                                                           AS lp_werbe_pv                                                --Bericht: Lidl Plus Werbe-PV MAX(pa13.wjxbfs2)  wjxbfs2
  ,ROUND(MAX(werbe_pv.all_discount_val_wpv),2)                                                                          AS gesamt_werbe_pv                                                  --Bericht: Gesamt Werbe-PV MAX(pa13.wjxbfs3)  wjxbfs3                         
  ,ROUND(DIV0(MAX(werbe_pv.non_lp_discount_val_wpv),MAX(pv_tnv.all_total_net_val))*100,2)                               AS non_lp_werbe_pv_prozent                                               --Bericht: Non-Lidl Plus Werbe-PV (%)
  ,ROUND(DIV0(MAX(werbe_pv.lp_discount_val_wpv),MAX(pv_tnv.all_total_net_val))*100,2)                                   AS lp_werbe_pv_prozent                                                --Bericht: Lidl Plus Werbe-PV (%)
  ,ROUND(DIV0(MAX(werbe_pv.all_discount_val_wpv),MAX(pv_tnv.all_total_net_val))*100,2)                                  AS gesamt_werbe_pv_prozent                                                  --Bericht: Gesamt Werbe-PV (%)                      
	,ROUND(MAX(pv_tnv.lp_discount_val),2)                                                                                 AS lp_preisveraenderung          --Bericht: Lidl Plus Preisveränderung MAX(pa14.wjxbfs1)  wjxbfs4
	,ROUND(MAX(pv_tnv.non_lp_discount_val),2)                                                                             AS non_lp_preisveraenderung    --Bericht: Non-Lidl Plus Preisveränderung MAX(pa14.wjxbfs3)  wjxbfs5
	,ROUND(MAX(pv_tnv.all_discount_val),2)                                                                                AS gesamt_preisveraenderung       --Bericht: Gesamt Preisveränderung MAX(pa14.wjxbfs5)  wjxbfs6
	,ROUND(MAX(lp_wo_rc.non_lp_writeoff_val_wpv),2)                                                                       AS non_lp_abschriften                                                   --Bericht: Non-Lidl Plus Abschriften Gesamt MAX(pa17.wjxbfs1)  wjxbfs7
	,ROUND(MAX(lp_wo_wpv_non_lp_cr_tnv.lp_writeoff_val_wpv),2)                                                            AS lp_abschriften                                                            --Bericht: Lidl Plus Abschriften Gesamt MAX(pa18.wjxbfs1)  wjxbfs8
	,ROUND(MAX(all_wo_cr.all_writeoff_val_wpv),2)                                                                         AS gesamt_abschriften                                                          --Bericht: Gesamt Abschriften  MAX(pa19.wjxbfs1)  wjxbfs9
  ,ROUND(DIV0(MAX(lp_wo_rc.non_lp_writeoff_val_wpv),MAX(pv_tnv.all_total_net_val))*100,2)                               AS non_lp_abschriften_prozent                                                   --Bericht: Non-Lidl Plus Abschriften Gesamt (%)  wjxbfs7
	,ROUND(DIV0(MAX(lp_wo_wpv_non_lp_cr_tnv.lp_writeoff_val_wpv),MAX(pv_tnv.all_total_net_val))*100,2)                    AS lp_abschriften_prozent                                                            --Bericht: Lidl Plus Abschriften Gesamt (%)  wjxbfs8
	,ROUND(DIV0(MAX(all_wo_cr.all_writeoff_val_wpv),MAX(pv_tnv.all_total_net_val))*100,2)                                 AS gesamt_abschriften_prozent                                                          --Bericht: Gesamt Abschriften  (%)
	,ROUND(MAX(lp_cc.lp_count_customer),0)                                                                                AS lp_Kunden_anz                           --Bericht: Lidl Plus Kunden (Anz.) MAX(pa110.wjxbfs1) wjxbfsa all_count_customer                              
  ,ROUND(DIV0(MAX(lp_cc.lp_count_customer),MAX(lp_reg_dereg.lp_total_new_reg_count))*100,2)                             AS dv_anteil_lp_kunden_prozent       --Bericht: dv. Anteil Lidl Plus Kunden (%)
  ,ROUND(DIV0(MAX(pv_tnv.all_discount_val),MAX(pv_tnv.all_total_net_val))*100,2)                                        AS gesamt_preisveraenderung_prozent  --Bericht: Gesamt Preisveränderung (%)
  ,ROUND(DIV0(MAX(pv_tnv.lp_discount_val),MAX(pv_tnv.all_total_net_val))*100,2)                                         AS lp_preisveraenderung_prozent      --Bericht: Lidl Plus Preisveränderung(%)
  ,ROUND(DIV0(MAX(pv_tnv.non_lp_discount_val),MAX(pv_tnv.all_total_net_val))*100,2)                                     AS non_lp_preisveraenderung_prozent   --Bericht: Non-Lidl Plus Preisveränderung (%)                                
	,MAX(lp_reg_dereg.lp_cust_dereg_count)                                                                                AS lp_deregistrierung_anz             --Bericht: Lidl Plus De-Registrierungen (Anz.) MAX(pa111.wjxbfs1)  wjxbfsb                
  ,MAX(all_wo_cr.all_receipt_count)                                                                                     AS gesamt_bon_anz                            
	,MAX(lp_wo_wpv_non_lp_cr_tnv.non_lp_count_receipt)                                                                    AS non_lp_count_receipt                                                                                              --MAX(pa18.wjxbfs2)  wjxbfsd
	,ROUND(MAX(pv_tnv.lp_total_net_val),0)                                                                                AS lp_umsatz_ejr              --Bericht: Lidl Plus Umsatz EJR, MAX(pa14.wjxbfs2)  wjxbfse
  ,ROUND(DIV0(MAX(pv_tnv.lp_total_net_val),MAX(lp_wo_rc.lp_count_receipt)),2)                                           AS lp_bon_durchschn           --Bericht: Lidl Plus Ø Bon (LW/Bon)
  ,ROUND(DIV0(MAX(pv_tnv.all_total_net_val),MAX(all_wo_cr.all_receipt_count)),2)                                        AS gesamt_bon_durchschn           --Bericht: Gesamt Ø Bon (LW/Bon)  
  ,ROUND(DIV0(MAX(lp_wo_wpv_non_lp_cr_tnv.non_lp_total_net_val),MAX(lp_wo_wpv_non_lp_cr_tnv.non_lp_count_receipt)),2)   AS non_lp_bon_durchschn           --Bericht: Non-Lidl Plus Ø Bon (LW/Bon)    
  ,ROUND(DIV0(MAX(lp_wo_rc.lp_count_receipt),MAX(all_wo_cr.all_receipt_count))*100,2)                                   AS lp_bon_identifizierungsrate           --Bericht: Lidl Plus Bon Identifizierungsrate
  ,ROUND(DIV0(MAX(lp_wo_rc.lp_count_receipt),MAX(lp_cc.lp_count_customer)),2)                                           AS lp_einkaufsfrequenz         --Bericht: Lidl Plus Einkaufsfrequenz (Bon/Kunde)                       
  ,ROUND(DIV0(MAX(pv_tnv.lp_total_net_val),MAX(pv_tnv.all_total_net_val)) * 100,2)                                      AS lp_umsatzanteil_prozent    --Bericht: Lidl Plus Umsatzanteil (%)
	,MAX(lp_wo_rc.lp_count_receipt)                                                                                       AS lp_bon_anz                             --Bericht: Lidl Plus Bon (Anz.) MAX(pa17.wjxbfs2)  wjxbfsf
	,MAX(all_wo_cr.all_receipt_count)                                                                                     AS all_receipt_count                                                           --MAX(pa19.wjxbfs2)  wjxbfs10
	,ROUND(MAX(pv_tnv.all_total_net_val),0)                                                                               AS gesamt_umsatz_ejr          --Bericht: Gesamt Umsatz EJR (LW) LJ MAX(pa14.wjxbfs6)  wjxbfs11
	,MAX(lp_reg_dereg.lp_total_new_reg_count)                                                                             AS lp_registrierte_Nutzer_anz  --Bericht: Lidl Plus registrierte Nutzer (Anz.) MAX(pa111.wjxbfs2)  wjxbfs12
	,ROUND(MAX(lp_wo_wpv_non_lp_cr_tnv.non_lp_total_net_val),0)                                                           AS non_lp_umsatz_ejr          --Bericht: Non-Lidl Plus Umsatz EJR MAX(pa18.wjxbfs3)  wjxbfs13
	,ROUND(MAX(store_move.client_move_to_store),0)                                                                        AS filialen_anz               --Bericht: Filialen (Anz.) LJ MAX(pa115.wjxbfs1)  wjxbfs14
	,MAX(lp_reg_dereg.lp_reg_count)                                                                                       AS lp_neuregistrierungen_anz             --Bericht: Lidl Plus Neu-Registrierungen (Anz.) MAX(pa111.wjxbfs3)  wjxbfs15
FROM	werbe_pv AS werbe_pv
FULL OUTER JOIN	pv_tnv AS pv_tnv
  ON werbe_pv.client_id = pv_tnv.client_id
  AND werbe_pv.cy_month = pv_tnv.cy_month
FULL OUTER JOIN	lp_wo_rc AS lp_wo_rc
  ON  COALESCE(werbe_pv.client_id, pv_tnv.client_id) = lp_wo_rc.client_id
  AND COALESCE(werbe_pv.cy_month, pv_tnv.cy_month) = lp_wo_rc.cy_month
FULL OUTER JOIN	lp_wo_wpv_non_lp_cr_tnv AS lp_wo_wpv_non_lp_cr_tnv
  ON  COALESCE(werbe_pv.client_id, pv_tnv.client_id, pv_tnv.client_id) = lp_wo_wpv_non_lp_cr_tnv.client_id
  AND COALESCE(werbe_pv.cy_month, pv_tnv.cy_month, pv_tnv.cy_month) = lp_wo_wpv_non_lp_cr_tnv.cy_month
FULL OUTER JOIN	all_wo_cr AS all_wo_cr
  ON 	COALESCE(werbe_pv.client_id, pv_tnv.client_id, pv_tnv.client_id, lp_wo_wpv_non_lp_cr_tnv.client_id) = all_wo_cr.client_id
  AND COALESCE(werbe_pv.cy_month, pv_tnv.cy_month, pv_tnv.cy_month, lp_wo_wpv_non_lp_cr_tnv.cy_month) = all_wo_cr.cy_month
FULL OUTER JOIN	lp_cc AS lp_cc
  ON 	COALESCE(werbe_pv.client_id, pv_tnv.client_id, pv_tnv.client_id, lp_wo_wpv_non_lp_cr_tnv.client_id, all_wo_cr.client_id) = lp_cc.client_id
  AND COALESCE(werbe_pv.cy_month, pv_tnv.cy_month, pv_tnv.cy_month, lp_wo_wpv_non_lp_cr_tnv.cy_month, all_wo_cr.cy_month) = lp_cc.cy_month
FULL OUTER JOIN	lp_reg_dereg AS lp_reg_dereg
  ON 	COALESCE(werbe_pv.client_id, pv_tnv.client_id, pv_tnv.client_id, lp_wo_wpv_non_lp_cr_tnv.client_id, all_wo_cr.client_id, lp_cc.client_id) = lp_reg_dereg.client_id
  AND COALESCE(werbe_pv.cy_month, pv_tnv.cy_month, pv_tnv.cy_month, lp_wo_wpv_non_lp_cr_tnv.cy_month, all_wo_cr.cy_month, lp_cc.cy_month) = lp_reg_dereg.cy_month
FULL OUTER JOIN	store_move AS store_move
  ON 	COALESCE(werbe_pv.client_id, pv_tnv.client_id, pv_tnv.client_id, lp_wo_wpv_non_lp_cr_tnv.client_id, all_wo_cr.client_id, lp_cc.client_id, lp_reg_dereg.client_id) = store_move.client_id
  AND COALESCE(werbe_pv.cy_month, pv_tnv.cy_month, pv_tnv.cy_month, lp_wo_wpv_non_lp_cr_tnv.cy_month, all_wo_cr.cy_month, lp_cc.cy_month, lp_reg_dereg.cy_month) = store_move.cy_month
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead	AS r_cl
  ON 	COALESCE(werbe_pv.client_id, pv_tnv.client_id, pv_tnv.client_id, lp_wo_wpv_non_lp_cr_tnv.client_id, all_wo_cr.client_id, lp_cc.client_id, lp_reg_dereg.client_id, store_move.client_id) = r_cl.client_id
INNER JOIN	p_lew_mart_msi_ac.v_cal_month_desc	AS cal
  ON 	COALESCE(werbe_pv.cy_month, pv_tnv.cy_month, pv_tnv.cy_month, lp_wo_wpv_non_lp_cr_tnv.cy_month, all_wo_cr.cy_month, lp_cc.cy_month, lp_reg_dereg.cy_month, store_move.cy_month) = cal.cy_month
GROUP BY	r_cl.client_id
	,r_cl.country_desc
	,r_cl.country_iso_cd
	,cal.cy_month
	,cal.cy_month_name
ORDER BY 4 DESC
;

