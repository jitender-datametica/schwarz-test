/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_PRICE_LABEL_REPAIR_STATE_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  31.10.2023    Chetana Dyamangouda Patil           Initial DDL - ESL Dashboard
#  1.1  29.11.2023    Stephane Djiomou Tonga              correcting label's names and adding Usage_diff column
#  1.2  27.12.2023    Stephane Tonga                      ELECTRONIC_PRICE_LABEL_TYPE_CD_FE was added
#  1.3  06.02.2024    Simeon Nikolaev                     Fixed duplicate SIDs and Exchange rate calculation
#  1.4  13.02.2024    Simeon Nikolaev					  CLIENT/WH/INTEGER AGGREGATIONS
#  1.5  01.03.2024    Simeon Nikolaev                     Included Solum Logic for WARRANTY/DEFECT/NOTDEFECT
#  1.6  04.06.2024    Simeon Nikolaev                     Included Solum Logic for WARRANTY/DEFECT/NOTDEFECT
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_price_label_repair_state_1 AS WITH PLRC AS (SELECT DISTINCT PLRS.price_label_sid
   ,
   PLRS.price_label_producer_name,
   PL.electronic_price_label_type_cd,
   PL.electronic_price_label_type_cd_fe,
   CAL.cal_dt,
   PLRS.repair_start_dt,
   PLRS.repair_end_dt,
   PLRS.price_label_warranty_status_cd,
   PLRS.price_label_repair_result_cd,
   PLRS.price_label_repair_origin_name,
   PLRS.defect_txt /* DEFECT_LABELS: */,
    CASE
    WHEN PLRS.price_label_producer_name = 'Imagotag' AND PLRS.price_label_repair_result_cd = 'Recycling' AND PLRS.price_label_warranty_status_cd
        IN ('Excluded Warranty', 'Out of Warranty') OR PLRS.price_label_producer_name = 'Solum' AND PLRS.price_label_repair_origin_name
         = 'Customer' AND PLRS.defect_txt = 'DAMAGE'
    THEN 1
    ELSE 0
    END AS defect_labels,
    CASE
    WHEN PLRS.price_label_producer_name = 'Imagotag' AND PLRS.price_label_repair_result_cd = 'Returned functional' OR
        PLRS.price_label_producer_name = 'Solum' AND PLRS.price_label_repair_origin_name = 'Customer' AND PLRS.defect_txt
        = 'NDF'
    THEN 1
    ELSE 0
    END AS notdefect_labels,
    CASE
    WHEN PLRS.price_label_producer_name = 'Imagotag' AND PLRS.price_label_warranty_status_cd = 'In Warranty' AND PLRS.price_label_repair_result_cd
        IN ('Replace', 'Credit note') OR PLRS.price_label_producer_name = 'Solum' AND PLRS.price_label_repair_origin_name
        = 'Solum'
    THEN 1
    ELSE 0
    END AS warranty_labels,
   PLPH.net_price,
     CASE
     WHEN PLRS.price_label_producer_name = 'Imagotag' AND PLRS.price_label_repair_result_cd = 'Recycling' AND PLRS.price_label_warranty_status_cd
         IN ('Excluded Warranty', 'Out of Warranty') OR PLRS.price_label_producer_name = 'Solum' AND PLRS.price_label_repair_origin_name
          = 'Customer' AND PLRS.defect_txt = 'DAMAGE'
     THEN 1
     ELSE 0
     END * PLPH.net_price AS defectprice,
   PLPH.curr_iso_cd
  FROM ldl_p_lew_core_ac.v_price_label_repair_state_1 AS PLRS
   INNER JOIN ldl_p_lew_mart_lead_ac.v_price_label_1 AS PL ON PLRS.price_label_sid = PL.price_label_sid
   INNER JOIN ldl_p_lew_core_ac.v_price_label_price_hist_1 AS PLPH ON PL.electronic_price_label_type_cd = PLPH.electronic_price_label_type_cd
      AND PL.price_label_producer_name = PLPH.price_label_producer_name
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON CAL.cal_dt BETWEEN PLRS.repair_start_dt AND PLRS.repair_end_dt
    ), CUR AS (SELECT A.client_id,
   A.active_from_dt,
   A.active_to_dt,
   A.dwh_valid_from,
   A.dwh_valid_to,
   A.curr_cd_from AS curr_cd_from_loc,
   A.curr_cd_to AS curr_cd_to_loc,
   EURUSD.curr_cd_from AS curr_cd_from_usd_eur,
   EURUSD.curr_cd_to AS curr_cd_to_usd_eur,
   A.exchange_rate AS excng_eur_loccur,
   EURUSD.exchange_rate AS excng_usd_eur
  FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS A
   INNER JOIN (SELECT CUR1.client_id,
     CUR1.curr_cd_from,
     CUR1.curr_cd_to,
     CUR1.exchange_rate
    FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CUR1
     INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS CY1 ON CUR1.client_id = CY1.client_id AND CUR1.x_rate_type_sid
         = CY1.x_rate_type_sid AND CY1.src_kurst = '@BEWE'
    WHERE CUR1.client_id = 33
     AND CURRENT_DATE BETWEEN CUR1.active_from_dt AND CUR1.active_to_dt
     AND CURRENT_DATE BETWEEN CUR1.dwh_valid_from AND CUR1.dwh_valid_to
     AND CUR1.curr_cd_from = 'EUR') AS EURUSD ON A.curr_cd_from = EURUSD.curr_cd_from
   INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS CY ON A.client_id = CY.client_id AND A.x_rate_type_sid = CY.x_rate_type_sid
       AND CY.src_kurst = '@BEWE'
  WHERE CURRENT_DATE BETWEEN A.active_from_dt AND A.active_to_dt
   AND CURRENT_DATE BETWEEN A.dwh_valid_from AND A.dwh_valid_to), GEN AS (SELECT DISTINCT PLC.client_id,
   PLC.move_to_store_id,
   PLC.wh_id,
   PLC.aspect_id,
   t1.price_label_sid,
   t1.price_label_producer_name,
   t1.electronic_price_label_type_cd,
   t1.electronic_price_label_type_cd_fe,
   t1.cal_dt AS dat_formdate,
   t1.repair_start_dt,
   t1.repair_end_dt,
   t1.price_label_warranty_status_cd,
   t1.price_label_repair_result_cd,
   t1.price_label_repair_origin_name,
   t1.defect_txt,
   t1.defect_labels AS defect_count,
   t1.notdefect_labels AS notdefect_count,
   t1.warranty_labels AS warranty_count,
    CASE
    WHEN t1.defect_labels = 1
    THEN DATETIME_DIFF(CAST(t1.repair_start_dt AS DATETIME), PLC.price_label_create_tmsp, DAY)
    ELSE DATETIME_DIFF(CAST(CURRENT_DATE AS DATETIME), PLC.price_label_create_tmsp, DAY)
    END AS usage_diff,
   t1.net_price,
   t1.defectprice,
   CAST(t1.defectprice * t6.excng_eur_loccur / t6.excng_usd_eur AS NUMERIC) AS defectprice_cur,
   t1.curr_iso_cd AS currency_iso_cd
  FROM PLRC AS t1_1
   INNER JOIN ldl_p_lew_mart_lead.v_price_label_store_1 AS PLC ON t1.price_label_sid = PLC.price_label_sid AND t1.cal_dt =
     PLC.dat_formdate
   INNER JOIN CUR AS t6 ON PLC.client_id = t6.client_id) (/* IMAGOTAG DEFECT_LABELS: */ /* SOLUM DEFECT_LABELS: */
  /* NOTDEFECT_LABELS: */ /* IMAGOTAG NOTDEFECT_LABELS: */ /* SOLUM NOTDEFECT_LABELS: */ /* WARRANTY_LABELS: */
  /* IMAGOTAG WARRANTY_LABELS: */ /* SOLUM WARRANTY_LABELS: */ SELECT client_id,
   move_to_store_id,
   wh_id,
   aspect_id,
   price_label_sid,
   COUNT(price_label_sid) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), dat_formdate
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_label_cnt,
   COUNT(price_label_sid) OVER (PARTITION BY CAST(client_id AS STRING), dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING) AS client_label_cnt,
   COUNT(price_label_sid) OVER (PARTITION BY dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   int_label_cnt,
   price_label_producer_name,
   electronic_price_label_type_cd,
   electronic_price_label_type_cd_fe,
   dat_formdate,
   repair_start_dt,
   repair_end_dt,
   price_label_warranty_status_cd,
   price_label_repair_result_cd,
   price_label_repair_origin_name,
   defect_txt,
   defect_count,
   SUM(defect_count) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), dat_formdate RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_defect_count,
   SUM(defect_count) OVER (PARTITION BY CAST(client_id AS STRING), dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS client_defect_count,
   SUM(defect_count) OVER (PARTITION BY dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   int_defect_count,
   notdefect_count,
   SUM(notdefect_count) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), dat_formdate RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_notdefect_count,
   SUM(notdefect_count) OVER (PARTITION BY CAST(client_id AS STRING), dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS client_notdefect_count,
   SUM(notdefect_count) OVER (PARTITION BY dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   int_notdefect_count,
   warranty_count,
   SUM(warranty_count) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), dat_formdate RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_warranty_count,
   SUM(warranty_count) OVER (PARTITION BY CAST(client_id AS STRING), dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS client_warranty_count,
   SUM(warranty_count) OVER (PARTITION BY dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   int_warranty_count,
   usage_diff,
   SUM(usage_diff) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), dat_formdate RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_usage_diff,
   SUM(usage_diff) OVER (PARTITION BY CAST(client_id AS STRING), dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS client_usage_diff,
   SUM(usage_diff) OVER (PARTITION BY dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   int_usage_diff,
   net_price,
   defectprice,
   defectprice_cur,
   SUM(defectprice_cur) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), dat_formdate RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_defectprice_cur,
   SUM(defectprice_cur) OVER (PARTITION BY CAST(client_id AS STRING), dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS client_defectprice_cur,
   SUM(defectprice_cur) OVER (PARTITION BY dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   int_defectprice_cur,
   currency_iso_cd
  FROM GEN AS t9);