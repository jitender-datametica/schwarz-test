CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_zfm_dashboard_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), haulier
OPTIONS(description='Haulier description'), booking_id OPTIONS(description='Identification of booking'), booking_date
OPTIONS(description='Date of booking'), supplier_1 OPTIONS(description='Supplier_1 Name'), supplier_list
OPTIONS(description='Supplier_1 list label indicating if the supplier_1 is OWIM or SCHWARZ'), supplier_label
OPTIONS(description='Supplier_1 label -\"Cross Dock\",\"Import/Grosshandel\" and\"Frei-Haus\"'), order_number
OPTIONS(description='Order number - used to differentiate between\"Cross Dock\",\"Import/Grosshandel\" and\"Frei-Haus\" suppliers'),
count_order_per_booking
OPTIONS(description='counting of orders per booking - support parameter to dedup the calculation'), type_of_goods
OPTIONS(description='Type of goods description'), main_type_of_goods OPTIONS(description='Main type of goods ID'),
booking_datetime OPTIONS(description='Timestamp of booking'), completed OPTIONS(description='Completed'),
reference_number OPTIONS(description='Reference Number - CROSS JOIN column'), timestamp_signed_in
OPTIONS(description='Timestamp signed in'), timestamp_at_gate OPTIONS(description='Timestamp at gate'),
timestamp_signed_out OPTIONS(description='Timestamp signed out'), timestamp_not_arrived
OPTIONS(description='Timestamp not arrived'), waiting_time OPTIONS(description='Waiting time'), ldl_waiting_time
OPTIONS(description='LIDL Waiting time'), unloading_time OPTIONS(description='Unloading time'), processing_time_dct
OPTIONS(description='Processing time DCT chapter'), processing_time OPTIONS(description='Processing time Main'),
processing_time_lbl OPTIONS(description='Processing time label depending on duration'), punctuality
OPTIONS(description='Punctuality'), punctuality_label OPTIONS(description='Punctuality label'), too_late
OPTIONS(description='Too late value if applicable'), too_early OPTIONS(description='Too early value if applicable'),
not_arrived OPTIONS(description='Not arrived Flag'), time_late OPTIONS(description='Time Late'), deleted
OPTIONS(description='Deleted Flag'), dsci OPTIONS(description='DSCI'), count_not_arrived
OPTIONS(description='Flag for not arrived'), count_signed_out OPTIONS(description='Flag for signed out'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'), dwh_updated OPTIONS(description='Last update time')) AS WITH BOOKINGS
 AS (SELECT B.client_id,
   B.wh_id,
   B.warehouse_id,
   B.warehouse,
   B.warehouse_number,
   B.haulier,
   B.booking_id,
   B.booking_date,
   COALESCE(B.supplier_1, BO.supplier_name) AS supplier_1,
   COALESCE(B.order_number, BO.order_number) AS order_number,
   B.type_of_goods,
   B.type_of_goods_id,
   B.booking_datetime,
   B.reference_number,
   B.timestamp_signed_in,
   B.timestamp_at_gate,
   B.timestamp_signed_out,
   B.timestamp_not_arrived,
   B.not_arrived,
   B.deleted,
   B.dwh_valid_from,
   B.dwh_valid_to,
   B.deleted_fg,
   B.dwh_updated,
   ROW_NUMBER() OVER (PARTITION BY CAST(B.client_id AS STRING), CAST(B.wh_id AS STRING), CAST(B.booking_id AS STRING)
    ORDER BY B.booking_id IS NULL, B.booking_id) AS count_order_per_booking
  FROM ldl_logop_data.t_zfm_bookings_1 AS B
   LEFT JOIN ldl_logop_data.t_zfm_bookingorders_1 AS BO ON B.client_id = BO.client_id AND B.booking_id = BO.booking_id AND
      CURRENT_DATE BETWEEN BO.dwh_valid_from AND BO.dwh_valid_to AND NOT BO.deleted_fg
  WHERE CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
   AND NOT B.deleted_fg), WHS AS (SELECT WH_TOG.main_type_of_goods,
   WH_TOG.type_of_goods_id,
   WH.warehouse_id,
   WH.warehouse_number,
   WH.deleted_fg,
   WH.dwh_valid_from,
   WH.dwh_valid_to
  FROM ldl_logop_data.t_zfm_warehouses_1 AS WH
   LEFT JOIN ldl_logop_data.t_zfm_warehouses_tog_1 AS WH_TOG ON WH.warehouse_id = WH_TOG.warehouse_id AND CURRENT_DATE
      BETWEEN WH.dwh_valid_from AND WH.dwh_valid_to AND NOT WH.deleted_fg
  WHERE CURRENT_DATE BETWEEN WH_TOG.dwh_valid_from AND WH_TOG.dwh_valid_to
   AND NOT WH_TOG.deleted_fg), REGISTRATION_WAREHOUSES AS (SELECT warehouse
  FROM ldl_logop_data.t_zfm_registrations_1
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND NOT deleted_fg
  GROUP BY warehouse) (SELECT B.client_id,
   B.wh_id,
   B.haulier,
   B.booking_id,
   B.booking_date,
   B.supplier_1,
   IF(LOWER(B.supplier_1) LIKE LOWER('%OWIM%'), 'OWIM', IF(LOWER(B.supplier_1) LIKE LOWER('%SCHWARZ%'), 'SCHWARZ', NULL)) AS
   supplier_list,
   IF(REGEXP_CONTAINS(B.order_number, r'^[A-Za-z]{2}[0-9]{3,}'), 'Import / /Grosshandel', IF(REGEXP_CONTAINS(B.order_number
      , r'(KL|KT|TL|TK|UF)[A-Za-z]{3}'), 'Cross Dock', 'Frei-Haus')) AS supplier_label,
   B.order_number,
   B.count_order_per_booking,
   B.type_of_goods,
   WH.main_type_of_goods,
   B.booking_datetime,
   IF(B.timestamp_signed_out IS NOT NULL AND B.timestamp_signed_in IS NOT NULL, 1, 0) AS completed,
   B.reference_number,
   B.timestamp_signed_in,
   B.timestamp_at_gate,
   B.timestamp_signed_out,
   B.timestamp_not_arrived,
   CEIL(TIMESTAMP_DIFF(B.timestamp_at_gate, B.timestamp_signed_in, MILLISECOND) / 1000) AS waiting_time,
   IF(B.timestamp_signed_in < B.booking_datetime AND B.timestamp_at_gate < B.booking_datetime, TIMESTAMP_DIFF(B.timestamp_at_gate
     ,B.timestamp_signed_in, SECOND), IF(B.timestamp_signed_in < B.booking_datetime AND B.timestamp_at_gate > B.booking_datetime
       , TIMESTAMP_DIFF(B.timestamp_at_gate, B.booking_datetime, SECOND), IF(B.timestamp_signed_in > B.booking_datetime
      , TIMESTAMP_DIFF(B.timestamp_at_gate, B.timestamp_signed_in, SECOND), NULL))) AS ldl_waiting_time,
   IF(TIMESTAMP_DIFF(B.timestamp_signed_out, B.timestamp_at_gate, SECOND) < 0, NULL, TIMESTAMP_DIFF(B.timestamp_signed_out
     ,B.timestamp_at_gate, SECOND)) AS unloading_time,
    CEIL(TIMESTAMP_DIFF(B.timestamp_at_gate, B.timestamp_signed_in, MILLISECOND) / 1000) + IF(IF(TIMESTAMP_DIFF(B.timestamp_signed_out
        ,B.timestamp_at_gate, SECOND) < 0, NULL, TIMESTAMP_DIFF(B.timestamp_signed_out, B.timestamp_at_gate, SECOND))
     IS NULL, 0, IF(TIMESTAMP_DIFF(B.timestamp_signed_out, B.timestamp_at_gate, SECOND) < 0, NULL, TIMESTAMP_DIFF(B.timestamp_signed_out
       ,B.timestamp_at_gate, SECOND))) AS processing_time_dct,
   TIMESTAMP_DIFF(B.timestamp_signed_out, B.timestamp_signed_in, SECOND) AS processing_time,
   IF(TIMESTAMP_DIFF(B.timestamp_signed_out, B.timestamp_signed_in, SECOND) > 10800, 'More than 3 hours', IF(TIMESTAMP_DIFF(B
       .timestamp_signed_out, B.timestamp_signed_in, SECOND) < 900, 'Less than 15 min', 'Between 15 min and 3 hours'))
   AS processing_time_lbl,
   IF(B.deleted = (0 <> 0) AND B.not_arrived = FALSE, TIMESTAMP_DIFF(B.timestamp_signed_in, B.booking_datetime, MINUTE)
    , NULL) AS punctuality,
   IF(IF(B.deleted = (0 <> 0) AND B.not_arrived = FALSE, TIMESTAMP_DIFF(B.timestamp_signed_in, B.booking_datetime,
       MINUTE), NULL) < - 15, 'Too Early', IF(IF(B.deleted = (0 <> 0) AND B.not_arrived = FALSE, TIMESTAMP_DIFF(B.timestamp_signed_in
        ,B.booking_datetime, MINUTE), NULL) BETWEEN - 15 AND 15, 'On Time', IF(IF(B.deleted = (0 <> 0) AND B.not_arrived
           = FALSE, TIMESTAMP_DIFF(B.timestamp_signed_in, B.booking_datetime, MINUTE), NULL) > 15, 'Too Late', NULL)))
   AS punctuality_label,
   IF(B.deleted = (0 <> 0) AND B.not_arrived = FALSE AND B.timestamp_signed_in > B.booking_datetime, ABS(TIMESTAMP_DIFF(B
      .booking_datetime, B.timestamp_signed_in, SECOND)), NULL) AS too_late,
   IF(B.deleted = (0 <> 0) AND B.not_arrived = FALSE AND B.timestamp_signed_in < B.booking_datetime, ABS(TIMESTAMP_DIFF(B
      .timestamp_signed_in, B.booking_datetime, SECOND)), NULL) AS too_earl,
   B.not_arrived,
   CEIL(TIMESTAMP_DIFF(B.timestamp_at_gate, B.timestamp_signed_in, MILLISECOND) / 1000) AS time_late,
   IF(B.deleted = TRUE, 1, 0) AS deleted,
   IF(t6.warehouse IS NOT NULL, 1, 0) AS dsci,
   IF(B.timestamp_not_arrived IS NOT NULL, 1, 0) AS count_not_arrived,
   IF(B.timestamp_signed_out IS NOT NULL, 1, 0) AS count_signed_out,
   B.dwh_valid_from,
   B.dwh_valid_to,
   B.deleted_fg,
   MAX(B.dwh_updated) OVER (PARTITION BY CAST(B.client_id AS STRING), CAST(B.wh_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dwh_updated
  FROM BOOKINGS AS B
   LEFT JOIN WHS AS WH ON B.warehouse_id = WH.warehouse_id AND B.type_of_goods_id = WH.type_of_goods_id
   LEFT JOIN (SELECT DISTINCT *
    FROM REGISTRATION_WAREHOUSES AS RWH) AS t6 ON B.warehouse = t6.warehouse);