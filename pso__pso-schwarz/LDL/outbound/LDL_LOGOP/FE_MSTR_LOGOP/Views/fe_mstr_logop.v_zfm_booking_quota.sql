CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_zfm_booking_quota (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), booking_date
OPTIONS(description='Date of booking'), count_pal_ewm_rec OPTIONS(description='Number of Pallets for EWM_ZFM Received'),
count_pal_ewm_dec OPTIONS(description='Number of Pallets for EWM_ZFM Declined'), count_ep_zfm
OPTIONS(description='Number of Pallets for ZFM'), count_dd_zfm OPTIONS(description='Number of Pallets for ZFM'),
count_booking_gr_zfm OPTIONS(description='Count of signed out bookings ZFM'), count_booking_gr_wawi
OPTIONS(description='Count of signed out bookings WAWI'), count_ep_wawi
OPTIONS(description='Number of Pallets for ZFM from WAWI'), count_dd_wawi
OPTIONS(description='Number of Pallets for ZFM from WAWI'), wawi_pallets
OPTIONS(description='Calculation for WAWI Pallets'), ewm_pallets OPTIONS(description='Calculation for EWM Pallets'),
booking_trucks OPTIONS(description='Calculation for EWM Pallets')) AS WITH ZFM_PALLETS AS (SELECT B.client_id,
   B.wh_id,
   B.booking_date,
   SUM(CASE
     WHEN NOT B.deleted
     THEN BO.ep_count
     ELSE 0
     END) AS count_ep_zfm,
    SUM(CASE
      WHEN NOT B.deleted
      THEN BO.dd_count
      ELSE 0
      END) / 2 AS count_dd_zfm,
   COUNT(DISTINCT CASE
     WHEN NOT B.deleted
     THEN B.booking_id
     ELSE NULL
     END) AS count_booking_gr
  FROM ldl_logop_data.t_zfm_bookings AS B
   LEFT JOIN ldl_logop_data.t_zfm_bookingorders AS BO ON B.client_id = BO.client_id AND B.booking_id = BO.booking_id
  WHERE CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
   AND CURRENT_DATE BETWEEN BO.dwh_valid_from AND BO.dwh_valid_to
   AND NOT B.deleted_fg
   AND NOT BO.deleted_fg
  GROUP BY B.client_id,
   B.wh_id,
   B.booking_date), RECEIVED AS (SELECT client_id,
   wh_id,
   confirmed_date AS booking_date,
   COUNT(tanum) AS count_pal_ewm_rec
  FROM ldl_logop_data.t_sapewm_warehousetask
  WHERE tostat = 'C'
   AND CAST(trart AS FLOAT64) = 5
   AND docno LIKE '41%'
  GROUP BY client_id,
   wh_id,
   booking_date), DECLINED AS (SELECT client_id,
   wh_id,
   confirmed_date AS booking_date,
   COUNT(tanum) AS count_pal_ewm_dec
  FROM ldl_logop_data.t_sapewm_warehousetask
  WHERE tostat = 'C'
   AND CAST(trart AS FLOAT64) = 6
   AND docno LIKE '41%'
   AND exccode LIKE 'Z%'
  GROUP BY client_id,
   wh_id,
   booking_date), EWM_PALLETS AS (SELECT REC.client_id,
   REC.wh_id,
   REC.booking_date,
   REC.count_pal_ewm_rec,
   DEC.count_pal_ewm_dec
  FROM RECEIVED AS REC
   INNER JOIN DECLINED AS DEC ON REC.client_id = DEC.client_id AND REC.wh_id = DEC.wh_id AND REC.booking_date = DEC.booking_date
     
  GROUP BY REC.client_id,
   REC.wh_id,
   REC.booking_date,
   REC.count_pal_ewm_rec,
   DEC.count_pal_ewm_dec), WAWI_PALLETS AS (SELECT client_id,
   wh_nr AS wh_id,
   DATE(mod_date) AS booking_date,
   COUNT(DISTINCT CASE
     WHEN task_status = 99
     THEN task_id
     ELSE NULL
     END) AS count_booking_gr,
   SUM(CASE
     WHEN task_status = 99
     THEN pal_eu_goods
     ELSE 0
     END) AS count_ep_wawi,
    SUM(CASE
      WHEN task_status = 99
      THEN pal_dd_goods
      ELSE 0
      END) / 2 AS count_dd_wawi
  FROM ldl_logop_data.t_wawi_gintasks
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND NOT deleted_fg
  GROUP BY client_id,
   wh_id,
   booking_date), EWM_BOOKINGS AS (WITH BASE AS (SELECT client_id,
       wh_id,
       confirmed_date AS booking_date,
       nlenr,
       docno
      FROM ldl_logop_data.t_sapewm_warehousetask
      WHERE tostat = 'C'
       AND CAST(trart AS INTEGER) IN (5, 6)
       AND docno LIKE '41%'
      GROUP BY client_id,
       wh_id,
       booking_date,
       nlenr,
       docno
      EXCEPT DISTINCT
      SELECT client_id,
       wh_id,
       confirmed_date AS booking_date,
       vlenr,
       docno
      FROM ldl_logop_data.t_sapewm_warehousetask
      WHERE tostat = 'C'
       AND CAST(trart AS FLOAT64) = 6
       AND docno LIKE '41%'
       AND exccode LIKE 'Z%'
      GROUP BY client_id,
       wh_id,
       booking_date,
       vlenr,
       docno) (SELECT COUNT(DISTINCT B0.tu_num_ext) AS count_booking_gr_ewm,
      A.client_id,
      A.wh_id,
      A.booking_date
     FROM BASE AS A
      LEFT JOIN ldl_logop_data.t_sapewm_inbounddeliveryheader AS B0 ON A.client_id = B0.client_id AND A.wh_id = B0.wh_id
          AND A.docno = B0.docno_h
     GROUP BY A.client_id,
      A.wh_id,
      A.booking_date)) (SELECT ZFM.client_id,
   ZFM.wh_id,
   ZFM.booking_date,
   EWM.count_pal_ewm_rec,
   EWM.count_pal_ewm_dec,
   ZFM.count_ep_zfm,
   ZFM.count_dd_zfm,
   ZFM.count_booking_gr,
   WAWI.count_booking_gr AS count_booking_gr0,
   WAWI.count_ep_wawi,
   WAWI.count_dd_wawi,
   IFNULL((ZFM.count_ep_zfm + ZFM.count_dd_zfm) / NULLIF(WAWI.count_ep_wawi + WAWI.count_dd_wawi, 0), 0),
   IFNULL((ZFM.count_ep_zfm + ZFM.count_dd_zfm) / NULLIF(EWM.count_pal_ewm_rec - EWM.count_pal_ewm_dec, 0), 0),
   IF(WAWI.count_booking_gr IS NOT NULL, ZFM.count_booking_gr / NULLIF(WAWI.count_booking_gr, 0), IF(EWMB.count_booking_gr_ewm
     IS NOT NULL, ZFM.count_booking_gr / NULLIF(EWMB.count_booking_gr_ewm, 0), NULL))
  FROM ZFM_PALLETS AS ZFM
   LEFT JOIN EWM_PALLETS AS EWM ON ZFM.client_id = EWM.client_id AND ZFM.booking_date = EWM.booking_date AND ZFM.wh_id =
     EWM.wh_id
   LEFT JOIN WAWI_PALLETS AS WAWI ON ZFM.client_id = WAWI.client_id AND ZFM.booking_date = WAWI.booking_date AND ZFM.wh_id
      = WAWI.wh_id
   LEFT JOIN EWM_BOOKINGS AS EWMB ON ZFM.client_id = EWMB.client_id AND ZFM.booking_date = EWMB.booking_date AND ZFM.wh_id
      = EWMB.wh_id);