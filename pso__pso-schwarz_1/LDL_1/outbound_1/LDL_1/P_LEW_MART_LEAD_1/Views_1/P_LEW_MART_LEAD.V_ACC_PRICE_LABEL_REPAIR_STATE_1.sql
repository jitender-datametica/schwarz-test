/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_L_LABEL_TYPE_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  15.05.2024    Simeon Nikolaev           Initial DDL - ESL Dashboard + q -refresh
#  1.2  11.06.2024    Simeon Nikolaev           Including INTEGER /LAND_1/WH level aggregation
#  1.3  11.06.2024    Simeon Nikolaev           Updated CROSS JOIN of V_price_label_store_1 in LBL
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_acc_price_label_repair_state_1 AS WITH SDAY AS (SELECT DATE_ADD(CURRENT_DATE
    ,INTERVAL - 1 * SEQ DAY) AS dat_formdate,
   FORMAT_DATE('%a', DATE_ADD(CURRENT_DATE, INTERVAL - 1 * SEQ DAY)) AS dat_name
  FROM UNNEST(GENERATE_ARRAY(0, 99999)) AS SEQ
  WHERE (UPPER(FORMAT_DATE('%a', DATE_ADD(CURRENT_DATE, INTERVAL - 1 * SEQ DAY))) = 'SUN' OR DATE_ADD(CURRENT_DATE,
       INTERVAL - 1 * SEQ DAY) = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
   AND DATE_ADD(CURRENT_DATE, INTERVAL - 1 * SEQ DAY) >= DATE '2023-11-01'), CUR AS (SELECT A.client_id,
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
   AND CURRENT_DATE BETWEEN A.dwh_valid_from AND A.dwh_valid_to), LBL AS (SELECT DISTINCT PLC.client_id,
   PLC.move_to_store_id,
   PLC.wh_id,
   PLC.aspect_id,
   PLRS.price_label_sid,
   PLRS.price_label_producer_name,
   PL.electronic_price_label_type_cd,
   PL.electronic_price_label_type_cd_fe,
   PLRS.repair_start_dt,
   PLRS.repair_end_dt,
   PLRS.price_label_warranty_status_cd,
   PLRS.price_label_repair_result_cd,
   PLRS.price_label_repair_origin_name,
   PLRS.defect_txt,
    CASE
    WHEN PLRS.price_label_producer_name = 'Imagotag' AND PLRS.price_label_repair_result_cd = 'Recycling' AND PLRS.price_label_warranty_status_cd
        IN ('Excluded Warranty', 'Out of Warranty') OR PLRS.price_label_producer_name = 'Solum' AND PLRS.price_label_repair_origin_name
         = 'Customer' AND PLRS.defect_txt = 'DAMAGE'
    THEN 1
    ELSE 0
    END AS defect_count,
    CASE
    WHEN PLRS.price_label_producer_name = 'Imagotag' AND PLRS.price_label_repair_result_cd = 'Returned functional' OR
        PLRS.price_label_producer_name = 'Solum' AND PLRS.price_label_repair_origin_name = 'Customer' AND PLRS.defect_txt
        = 'NDF'
    THEN 1
    ELSE 0
    END AS notdefect_count,
    CASE
    WHEN PLRS.price_label_producer_name = 'Imagotag' AND PLRS.price_label_warranty_status_cd = 'In Warranty' AND PLRS.price_label_repair_result_cd
        IN ('Replace', 'Credit note', 'Credit Note') OR PLRS.price_label_producer_name = 'Solum' AND PLRS.price_label_repair_origin_name
        = 'Solum'
    THEN 1
    ELSE 0
    END AS warranty_count,
     CASE
     WHEN PLRS.price_label_producer_name = 'Imagotag' AND PLRS.price_label_repair_result_cd = 'Recycling' AND PLRS.price_label_warranty_status_cd
         IN ('Excluded Warranty', 'Out of Warranty') OR PLRS.price_label_producer_name = 'Solum' AND PLRS.price_label_repair_origin_name
          = 'Customer' AND PLRS.defect_txt = 'DAMAGE'
     THEN 1
     ELSE 0
     END * PLPH.net_price AS defectprice,
   PLPH.net_price,
   CAST(CASE
        WHEN PLRS.price_label_producer_name = 'Imagotag' AND PLRS.price_label_repair_result_cd = 'Recycling' AND PLRS.price_label_warranty_status_cd IN ('Excluded Warranty', 'Out of Warranty') OR PLRS.price_label_producer_name = 'Solum' AND PLRS.price_label_repair_origin_name = 'Customer' AND PLRS.defect_txt
            = 'DAMAGE'
        THEN 1
        ELSE 0
        END * PLPH.net_price * t8.excng_eur_loccur / t8.excng_usd_eur AS NUMERIC) AS defectprice_cur,
   PLPH.curr_iso_cd
  FROM ldl_p_lew_core_ac.v_price_label_repair_state_1 AS PLRS
   INNER JOIN ldl_p_lew_mart_lead_ac.v_price_label_1 AS PL ON PLRS.price_label_sid = PL.price_label_sid
   INNER JOIN ldl_p_lew_core_ac.v_price_label_price_hist_1 AS PLPH ON PL.electronic_price_label_type_cd = PLPH.electronic_price_label_type_cd
      AND PL.price_label_producer_name = PLPH.price_label_producer_name
   INNER JOIN ldl_p_lew_mart_lead.v_price_label_store_1 AS PLC ON PLRS.price_label_sid = PLC.price_label_sid AND PLRS.repair_start_dt
     BETWEEN PLC.dwh_valid_from AND PLC.dwh_valid_to
   INNER JOIN CUR AS t8 ON PLC.client_id = t8.client_id) (SELECT DISTINCT t11.client_id,
   t11.move_to_store_id,
   t11.wh_id,
   t11.aspect_id,
   t11.price_label_producer_name,
   t11.electronic_price_label_type_cd,
   t11.electronic_price_label_type_cd_fe,
   t3.dat_formdate,
   t11.repair_start_dt,
   t11.repair_end_dt,
   t11.price_label_warranty_status_cd,
   t11.price_label_repair_result_cd,
   t11.price_label_repair_origin_name,
   t11.defect_txt,
   t11.net_price,
   t11.defectprice,
   t11.defectprice_cur,
   SUM(t11.defectprice_cur) OVER (PARTITION BY CAST(t11.client_id AS STRING), CAST(t11.wh_id AS STRING), t3.dat_formdate
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_defectprice_cur,
   SUM(t11.defectprice_cur) OVER (PARTITION BY CAST(t11.client_id AS STRING), t3.dat_formdate RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS client_defectprice_cur,
   SUM(t11.defectprice_cur) OVER (PARTITION BY t3.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS int_defectprice_cur,
   t11.curr_iso_cd,
   t11.price_label_sid,
   COUNT(t11.price_label_sid) OVER (PARTITION BY CAST(t11.client_id AS STRING), CAST(t11.wh_id AS STRING), t3.dat_formdate
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_label_cnt,
   COUNT(t11.price_label_sid) OVER (PARTITION BY CAST(t11.client_id AS STRING), t3.dat_formdate RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS client_label_cnt,
   COUNT(t11.price_label_sid) OVER (PARTITION BY t3.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS int_label_cnt,
   t11.defect_count,
   SUM(t11.defect_count) OVER (PARTITION BY CAST(t11.client_id AS STRING), CAST(t11.wh_id AS STRING), t3.dat_formdate
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_defect_count,
   SUM(t11.defect_count) OVER (PARTITION BY CAST(t11.client_id AS STRING), t3.dat_formdate RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS client_defect_count,
   SUM(t11.defect_count) OVER (PARTITION BY t3.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
   AS int_defect_count,
   t11.notdefect_count,
   SUM(t11.notdefect_count) OVER (PARTITION BY CAST(t11.client_id AS STRING), CAST(t11.wh_id AS STRING), t3.dat_formdate
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_notdefect_count,
   SUM(t11.notdefect_count) OVER (PARTITION BY CAST(t11.client_id AS STRING), t3.dat_formdate RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS client_notdefect_count,
   SUM(t11.notdefect_count) OVER (PARTITION BY t3.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS int_notdefect_count,
   t11.warranty_count,
   SUM(t11.warranty_count) OVER (PARTITION BY CAST(t11.client_id AS STRING), CAST(t11.wh_id AS STRING), t3.dat_formdate
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_warranty_count,
   SUM(t11.warranty_count) OVER (PARTITION BY CAST(t11.client_id AS STRING), t3.dat_formdate RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS client_warranty_count,
   SUM(t11.warranty_count) OVER (PARTITION BY t3.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS int_warranty_count
  FROM SDAY AS t3
   INNER JOIN LBL AS t11 ON t3.dat_formdate >= t11.repair_start_dt);