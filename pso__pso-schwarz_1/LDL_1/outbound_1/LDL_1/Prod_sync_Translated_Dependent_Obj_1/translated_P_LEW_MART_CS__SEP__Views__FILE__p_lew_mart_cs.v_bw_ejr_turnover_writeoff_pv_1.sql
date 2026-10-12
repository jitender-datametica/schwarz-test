CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_ejr_turnover_writeoff_pv_1 (client_id, 
 `land_1 o08 iso-code`, 
 `wg i05 mis wg id`, 
 `uwg i04 mis uwg id`, 
 `artikelfamilie gruppiert i04 artikelfamiliennummer`, 
 `artikelart _u0028_hist_u0029_ hi08 id`,
 `waehrung x02 bezeichnung`, 
 `monat_1 t05 id`,
 `umsatz ejr aufgel`,
 `abschriften_1 gesamt aufgel`,
 `preisveraenderung aufgel`
 ) AS SELECT item_cal.client_id,
 aa14.country_iso_cd AS `land_1 o08 iso-code`,
 aa15.itemgroup_int_id AS `wg i05 mis wg id`,
 item_cal.subitemgroup_id AS `uwg i04 mis uwg id`,
 item_cal.item_familygroup_id AS `artikelfamilie gruppiert i04 artikelfamiliennummer`,
 item_cal.buying_list_type_id AS `artikelart _u0028_hist_u0029_ hi08 id`,
 item_cal.currency_iso_cd AS `waehrung x02 bezeichnung`,
 item_cal.cy_month AS `monat_1 t05 id`,
 IFNULL(SUM(PA.m1401), 0) AS `umsatz ejr aufgel`,
 IFNULL(SUM(PA.m1201bnl), 0) AS `abschriften_1 gesamt aufgel`,
 IFNULL(SUM(PA.m1102pvs), 0) AS `preisveraenderung aufgel`
FROM (SELECT ITEM.client_id,
   SIG.subitemgroup_id,
   ITEMFAMILY.family_cd AS item_familygroup_id,
    CASE
    WHEN ITEM.buying_list_type_id IS NULL
    THEN -1
    ELSE ITEM.buying_list_type_id
    END AS buying_list_type_id,
   CURR.currency_iso_cd,
   CAL.cy_month,
   A12.dat_busyear_cum AS dat_byr_cum,
   ITEM.item_id
  FROM ldl_p_lew_core_ac.v_wawi_cal_busyear_cum_1 AS A12
   INNER JOIN ldl_p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_item_1 AS ITEM_1 ON A12.dat_busyear_cum BETWEEN ITEM.dat_rec_start
    AND ITEM.dat_rec_end
   INNER JOIN ldl_p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_sig_1 AS SIG ON ITEM.client_id = SIG.client_id AND ITEM.item_id
      = SIG.item_id
   INNER JOIN ldl_p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_itemfamily_1 AS ITEMFAMILY ON SIG.client_id = ITEMFAMILY.client_id
       AND SIG.item_familygroup_id = ITEMFAMILY.item_familygroup_id AND SIG.subitemgroup_id = ITEMFAMILY.subitemgroup_id
     
   INNER JOIN ldl_p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_curr_1 AS CURR ON SIG.client_id = CURR.client_id
   INNER JOIN ldl_p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_cal_1 AS CAL ON A12.dat_calendar = CAL.dat_calendar
  WHERE A12.dat_calendar IN (SELECT MAX(cal_dt) AS dat_calendar
     FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS C11
     WHERE cy_month = CAST(TRIM(CAST(CASE
            WHEN EXTRACT(MONTH FROM CURRENT_DATE) = 1
            THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
            ELSE EXTRACT(YEAR FROM CURRENT_DATE)
            END AS STRING) || CASE
           WHEN EXTRACT(MONTH FROM IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL -1 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL -1 MONTH))) <= 9
           THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL -1 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL -1 MONTH))) AS STRING), 1, 19))
           ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL -1 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL -1 MONTH))) AS STRING), 1, 19))
           END) AS FLOAT64))) AS item_cal
 INNER JOIN ldl_p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_values_1 AS PA ON item_cal.client_id = PA.client_id AND
     item_cal.dat_byr_cum = PA.dwh_cal_dt AND item_cal.item_id = PA.item_id AND item_cal.currency_iso_cd = PA.currency_iso_cd
   
 INNER JOIN (SELECT DISTINCT country_id AS client_id,
   country_iso_cd
  FROM ldl_p_lew_core_ac.v_wawi_ref_country_act_1 AS CN) AS aa14 ON item_cal.client_id = aa14.client_id
 INNER JOIN (SELECT subitemgroup_id,
   MAX(itemgroup_int_id) AS itemgroup_int_id,
   client_id
  FROM (SELECT DISTINCT SAFE_CAST(ROUND(CAST(S.src_subitemgrp_cd AS FLOAT64)) AS INTEGER) AS subitemgroup_id,
     SAFE_CAST(ROUND(CAST(H.item_grp_int_cd AS FLOAT64)) AS INTEGER) AS itemgroup_int_id,
     S.client_id
    FROM ldl_p_lew_core_ac.v_subitemgroup_1 AS S
     INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist_1 AS H ON S.client_id = H.client_id AND S.sub_item_grp_sid = H.sub_item_grp_sid
       
    WHERE CURRENT_DATE BETWEEN H.dwh_valid_from AND H.dwh_valid_to) AS max_az
  GROUP BY subitemgroup_id,
   client_id) AS aa15 ON item_cal.client_id = aa15.client_id AND item_cal.subitemgroup_id = aa15.subitemgroup_id
   /* for adjusting pa11 */
 INNER JOIN (SELECT DISTINCT subitemgroup_id,
   family_cd
  FROM ldl_p_lew_core_ac.v_wawi_itm_familygroup_1
  WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
   AND language_id = 7) AS aa17 ON item_cal.item_familygroup_id = aa17.family_cd AND item_cal.subitemgroup_id = aa17.subitemgroup_id
   
GROUP BY item_cal.client_id,
 `land_1 o08 iso-code`,
 `wg i05 mis wg id`,
 `uwg i04 mis uwg id`,
 `artikelfamilie gruppiert i04 artikelfamiliennummer`,
 `artikelart _u0028_hist_u0029_ hi08 id`,
 `waehrung x02 bezeichnung`,
 `monat_1 t05 id`;