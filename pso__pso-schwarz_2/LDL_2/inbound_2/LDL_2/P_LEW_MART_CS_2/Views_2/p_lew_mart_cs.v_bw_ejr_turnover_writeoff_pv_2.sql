create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_CS.V_BW_EJR_TURNOVER_WRITEOFF_PV_2(
	CLIENT_ID,
	""LAND_2 O08 ISO-CODE"",
	""WG I05 MIS WG ID"",
	""UWG I04 MIS UWG ID"",
	""ARTIKELFAMILIE GRUPPIERT I04 ARTIKELFAMILIENNUMMER"",
	""ARTIKELART (HIST) HI08 ID"",
	""WAEHRUNG X02 BEZEICHNUNG"",
	""MONAT_2 T05 ID"",
	""UMSATZ EJR AUFGEL."",
	""ABSCHRIFTEN_2 GESAMT AUFGEL."",
	""PREISVERAENDERUNG AUFGEL.""
) as (
SELECT
      item_cal.client_id AS ""Client_id""
    , aa14.country_iso_cd  AS ""Land_2 O08 ISO-Code""
    , aa15.itemgroup_int_id AS ""WG I05 MIS WG ID""
    , item_cal.subitemgroup_id AS  ""UWG I04 MIS UWG ID""
    , item_cal.item_familygroup_id AS ""Artikelfamilie gruppiert I04 Artikelfamiliennummer""
    , item_cal.buying_list_type_id AS ""Artikelart (hist) HI08 ID""
    , item_cal.currency_iso_cd AS ""Waehrung X02 Bezeichnung""
    , item_cal.cy_month AS ""Monat_2 T05 ID""
    , ZeroIfNull(Sum(pa.M1401))     AS ""Umsatz EJR aufgel.""
    , ZeroIfNull(Sum(pa.M1201BNL))  AS ""Abschriften_2 Gesamt aufgel.""
    , ZeroIfNull(Sum(pa.M1102PVS))  AS ""Preisveraenderung aufgel."" 
FROM
    (SELECT
          item.client_id
        , sig.subitemgroup_id  subitemgroup_id
        , itemfamily.family_cd  item_familygroup_id
        , (CASE WHEN item.buying_list_type_id IS NULL THEN -1 ELSE item.buying_list_type_id END)  buying_list_type_id
        , curr.currency_iso_cd  currency_iso_cd
        , cal.cy_month  cy_month
        , a12.dat_busyear_cum dat_byr_cum
        , item.item_id
    FROM p_lew_core_ac.v_wawi_cal_busyear_cum_2 a12
    INNER JOIN p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_item_2 item_2
      ON a12.dat_busyear_cum BETWEEN item.dat_rec_start AND item.dat_rec_end
    INNER JOIN p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_sig_2 sig
      ON item.client_id = sig.client_id
     AND item.item_id = sig.item_id
    INNER JOIN p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_itemfamily_2 itemfamily
      ON sig.client_id           = itemfamily.client_id
     AND sig.item_familygroup_id = itemfamily.item_familygroup_id
     AND sig.subitemgroup_id     = itemfamily.subitemgroup_id
    INNER JOIN p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_curr_2 curr
      ON sig.client_id = curr.client_id
    INNER JOIN p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_cal_2  cal
      ON a12.dat_calendar = cal.dat_calendar
    WHERE a12.dat_calendar
        IN (SELECT MAX(c11.cal_dt) AS dat_calendar
              FROM p_lew_core_ac.v_cal_calendarday_2 c11
             WHERE cy_month = Trim(CASE WHEN Extract(MONTH FROM CURRENT_DATE) = 1 THEN EXTRACT(YEAR FROM CURRENT_DATE)-1 ELSE EXTRACT(YEAR FROM CURRENT_DATE) END || CASE WHEN EXTRACT(MONTH FROM ADD_MONTHS(CURRENT_DATE, -1))<=9 THEN '0' || TRIM(EXTRACT(MONTH FROM ADD_MONTHS(CURRENT_DATE, -1))) ELSE TRIM(EXTRACT(MONTH FROM ADD_MONTHS(CURRENT_DATE, -1))) END)
            )
    ) item_cal
INNER JOIN p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_values_2 pa
ON  pa.client_id       = item_cal.client_id
AND pa.dwh_cal_dt      = item_cal.dat_byr_cum
AND pa.item_id         = item_cal.item_id
AND pa.currency_iso_cd = item_cal.currency_iso_cd
INNER JOIN (SELECT DISTINCT cn.country_id AS client_id
                  ,country_iso_cd
        FROM  p_lew_core_ac.v_wawi_ref_country_act_2 AS cn
        ) aa14
ON item_cal.client_id = aa14.client_id
INNER JOIN (SELECT max_az.subitemgroup_id
            , MAX(max_az.itemgroup_int_id) AS itemgroup_int_id
            , max_az.client_id
        FROM (
                SELECT DISTINCT
                    TRY_CAST(s.src_subitemgrp_cd AS INTEGER) AS subitemgroup_id
                    , TRY_CAST(h.item_grp_int_cd AS INTEGER) AS itemgroup_int_id
                    , s.client_id
                FROM p_lew_core_ac.v_subitemgroup_2 AS s
                    INNER JOIN p_lew_core_ac.v_subitemgroup_hist_2 AS h
                        ON s.client_id = h.client_id
                        AND s.sub_item_grp_sid = h.sub_item_grp_sid
                WHERE CURRENT_DATE BETWEEN h.dwh_valid_from AND h.dwh_valid_to
        ) AS max_az
        GROUP BY max_az.subitemgroup_id
            , max_az.client_id
     ) aa15
     ON item_cal.client_id     = aa15.client_id
    AND item_cal.subitemgroup_id = aa15.subitemgroup_id
/*  for adjusting pa11 */
INNER JOIN ( SELECT DISTINCT
             subitemgroup_id
             , family_cd
         FROM p_lew_core_ac.v_wawi_itm_familygroup_2
         WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
         AND language_id = 7
     ) aa17
  ON item_cal.item_familygroup_id = aa17.family_cd
 AND item_cal.subitemgroup_id = aa17.subitemgroup_id
GROUP BY
     item_cal.client_id
   , aa14.country_iso_cd
   , aa15.itemgroup_int_id
   , item_cal.subitemgroup_id
   , item_cal.item_familygroup_id
   , item_cal.buying_list_type_id
   , item_cal.currency_iso_cd
   , item_cal.cy_month
) 
;
