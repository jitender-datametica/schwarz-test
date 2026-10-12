/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_KPGES_WEEK_WH_MERGE
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  18.12.2020    Mittler,Patrick          Add Kolli (ID 315) on Week-level
#  1.4  18.12.2020    Mittler,Patrick          set cy_day_seq to check current_date
#  1.5  06.01.2021    Mittler,Patrick          delete logic that exlcude actual week
#  1.6  06.01.2021    Mittler,Patrick          Add comments
#  1.7  06.01.2021    Mittler,Patrick          Add comments
#  1.8  07.01.2021    Mittler,Patrick          Edit val_indicator
#  1.9  07.01.2021    Mittler,Patrick          20201218_2694_Kolli_Wochen_Monitoring
#                                              REP1-14198
#  2.0  16.02.2021    Mittler,Patrick          20210216_2751_Wochmon_Transall_stdown
#                                              Anpassung Referenz Legacy currency_iso_cd
#  2.1  18.02.2021    Mittler,Patrick          20210216_2751_Wochmon_Transall_stdown
#                                              currency_exchange Anpassung
#  2.2  22.02.2021    Mittler,Patrick          20210222_2758_wk_moni_fix_cry
#                                              edit logic for 322 , 325
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_kpges_week_wh_merge AS
SELECT IWEEK.client_id,
 IWEEK.org_unit_nr AS wh_id,
  CASE
  WHEN IWEEK.org_type_id = 50
  THEN 1
  ELSE 2
  END AS aspect_id,
 IWEEK.indicator_id,
   IWEEK.cy * 100 + IWEEK.cal_week AS cy_week,
  CASE
  WHEN IWEEK.indicator_id IN (117, 120, 125, 126, 133, 135, 136, 155, 156, 157, 163, 168, 169, 170, 172, 174, 177, 179,
    203, 204, 209, 210, 212, 216, 228, 229, 230, 238, 240, 242, 250, 251, 255, 256, 257, 258, 259, 260, 261, 270, 271,
    272, 273, 280, 281, 282, 283, 284, 286)
  THEN IWEEK.val_indicator / cry.rate_currency_exchange
  ELSE IWEEK.val_indicator
  END AS val_indicator,
 cry.currency_iso_cd,
 IWEEK.dat_dayend
FROM ldl_p_lew_core_ac.v_wawi_indicator_week AS IWEEK
 INNER JOIN (SELECT B.client_id,
   B.curr_cd_from AS currency_iso_cd,
   B.curr_cd_to AS to_currency_iso_cd,
   B.exchange_rate AS rate_currency_exchange
  FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist AS B
   INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS C ON B.client_id = C.client_id AND B.x_rate_type_sid = C.x_rate_type_sid
       AND C.src_kurst = '@BEWE'
  WHERE CURRENT_DATE BETWEEN B.active_from_dt AND B.active_to_dt
   AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to) AS cry ON IWEEK.client_id = cry.client_id AND IWEEK.indicator_type_id
     = 1 AND IWEEK.org_type_id IN (50, 60)
UNION ALL
SELECT client_id,
 org_unit_nr AS wh_id,
  CASE
  WHEN org_type_id = 50
  THEN 1
  ELSE 2
  END AS aspect_id,
 indicator_id,
 cy_week,
 val_indicator,
 'EUR' AS currency_iso_cd,
 dat_dayend
FROM (SELECT IDAY.client_id -- 50 = BGES; 60 = VGES
,
    IDAY.org_type_id,
    IDAY.org_unit_nr,
    IDAY.indicator_id,
    CAL.cy_week,
    SUM(IDAY.val_indicator) AS val_indicator,
    MAX(IDAY.dat_dayend) AS dat_dayend
   FROM ldl_p_lew_core_ac.v_wawi_indicator_day AS IDAY
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON IDAY.dat_formdate = CAL.cal_dt
   WHERE IDAY.indicator_id IN (315) -- bges

    AND IDAY.org_type_id = 50
   GROUP BY IDAY.client_id,
    IDAY.org_type_id,
    IDAY.org_unit_nr,
    IDAY.indicator_id,
    CAL.cy_week
   UNION ALL
   SELECT IDAY.client_id -- 50 = BGES; 60 = VGES
,
    IDAY.org_type_id,
    IDAY.org_unit_nr,
    IDAY.indicator_id,
    CAL.cy_week,
    SUM(IDAY.val_indicator) AS val_indicator,
    MAX(IDAY.dat_dayend) AS dat_dayend
   FROM ldl_p_lew_core_ac.v_wawi_indicator_day AS IDAY
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON IDAY.dat_formdate = CAL.cal_dt
   WHERE IDAY.indicator_id IN (322, 325) -- bges

    AND IDAY.org_type_id IN (50, 60)
   GROUP BY IDAY.client_id,
    IDAY.org_type_id,
    IDAY.org_unit_nr,
    IDAY.indicator_id,
    CAL.cy_week) AS iweek;