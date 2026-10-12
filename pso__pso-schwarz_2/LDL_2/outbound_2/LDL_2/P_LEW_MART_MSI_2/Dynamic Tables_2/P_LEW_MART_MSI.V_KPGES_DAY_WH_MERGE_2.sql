/*
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_KPGES_DAY_WH_MERGE_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  08.03.2019    Camerzan,Dumitru         Replaced LEW_CORE_AC.V_WAWI_INDICATOR_DAY_2 with LEW_BIL_AC.V_KPI_DAY_2
#  1.4  22.02.2021    Mittler,Patrick          Edit Logic for 322, 325
#  1.5  03.03.2021    Rekovsky,Marvin          Remove national currency for indicator_id 315
#  1.6  12.03.2024    Lesisz,Kamil             Bring back national currency for indicator_id 315
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_kpges_day_wh_merge_2 AS
SELECT IDAY.client_id,
 IDAY.org_unit_nr AS wh_id,
  CASE
  WHEN IDAY.org_type_id = 50
  THEN 1
  ELSE 2
  END AS aspect_id,
 IDAY.indicator_id,
 IDAY.dat_formdate,
  CASE
  WHEN IDAY.indicator_id IN (117, 120, 125, 126, 133, 135, 136, 155, 156, 157, 163, 168, 169, 170, 172, 174, 177, 179,
    203, 204, 209, 210, 212, 216, 228, 229, 230, 238, 240, 242, 250, 251, 255, 256, 257, 258, 259, 260, 261, 270, 271,
    272, 273, 280, 281, 282, 283, 284, 286)
  THEN IDAY.val_indicator / cry.rate_currency_exchange
  ELSE IDAY.val_indicator
  END AS val_indicator,
 cry.currency_iso_cd,
 IDAY.dat_dayend
FROM ldl_p_lew_bil_ac.v_kpi_day_2 AS IDAY
 INNER JOIN (SELECT B.client_id,
   B.curr_cd_from AS currency_iso_cd,
   B.curr_cd_to AS to_currency_iso_cd,
   B.exchange_rate AS rate_currency_exchange
  FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS B
   INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS C ON B.client_id = C.client_id AND B.x_rate_type_sid = C.x_rate_type_sid
       AND C.src_kurst = '@BEWE'
  WHERE CURRENT_DATE BETWEEN B.active_from_dt AND B.active_to_dt
   AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to) AS cry ON IDAY.client_id = cry.client_id AND IDAY.indicator_type_id
     = 1 AND IDAY.org_type_id IN (50, 60) -- für 322 und 325 Landeswährung entfernen und nur in EUR anzeigen

WHERE IDAY.indicator_id NOT IN (322, 325)
UNION ALL
SELECT client_id,
 org_unit_nr AS wh_id,
  CASE
  WHEN org_type_id = 50
  THEN 1
  ELSE 2
  END AS aspect_id,
 indicator_id,
 dat_formdate,
 val_indicator,
 'EUR' AS currency_iso_cd,
 dat_dayend
FROM ldl_p_lew_bil_ac.v_kpi_day_2 AS IDAY
WHERE indicator_type_id = 1
 AND indicator_id IN (322, 325)
 AND org_type_id IN (50, 60);
