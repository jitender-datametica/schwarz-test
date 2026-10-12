CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_dlz_quality_check_1 AS WITH CTE_ETL AS (SELECT CONCAT(T1.pack_tracking_nr
    , '_', T1.hauler_sid) AS pk_audit,
   T1.pack_sid,
   T1.pack_order_nr,
   T1.pack_tracking_nr,
   T1.hauler_sid,
   T2.hauler_name,
   T2.hauler_country_cd,
   T1.event_type_name,
   T1.carrierlayer_event_tmsp,
   T1.pack_tracking_url,
   IF(T1.pack_order_nr IS NULL, 1, 0) AS null_huid_fg,
   IF(T1.event_type_name = 'DATA_TRANSFERED_TO_CARRIER', 1, 0) AS data_transfer_fg,
   IF(T1.event_type_name = 'FIRST_HUB_SCAN', 1, 0) AS first_hub_scan_fg,
   IF(T1.event_type_name LIKE '%HUB_SCAN', 1, 0) AS hub_scan_events_fg,
    CASE
    WHEN T1.event_type_name LIKE '%DELIVERY%' OR (T2.hauler_country_cd <> 'DE' OR T2.hauler_name = 'DE_DPD') AND T1.event_type_name
         = 'CUSTOMER_INTERVENTION' OR T2.hauler_country_cd = 'DE' AND T1.event_type_name IN ('PARCEL_STOPPED',
        'DAMAGED_UNSUCCESSFUL')
    THEN 1
    ELSE 0
    END AS delivery_event_fg,
   FIRST_VALUE(T1.event_type_name) OVER (PARTITION BY T1.pack_tracking_nr, CAST(T1.hauler_sid AS STRING) ORDER BY T1.carrierlayer_event_tmsp
      IS NULL DESC, T1.carrierlayer_event_tmsp DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   last_event,
   T1.dwh_src_file_name
  FROM ldl_dig_lec_share.v_fact_carrierlayer_track_trace_audit_1 AS T1_1
   INNER JOIN ldl_dig_lec_share.v_dim_hauler_1 AS T2 ON T1.hauler_sid = T2.hauler_sid
  WHERE CONCAT(T1.pack_tracking_nr, '_', T1.hauler_sid) IN (SELECT CONCAT(pack_tracking_nr, '_', hauler_sid) AS pk_audit
      
     FROM ldl_dig_lec_share.v_fact_sales_package_shipment_1
     WHERE cust_delivery_tgt_dt >= DATE(DATE_SUB(CURRENT_DATE, INTERVAL 50 DAY))
      AND LENGTH(TRIM(pack_tracking_nr)) > 0)
   AND T2.dwh_valid_fg
   AND T1.event_type_name NOT IN ('UNKNOWN', 'IGNORE')), PACKAGE_LEVEL_AUDIT AS (SELECT pk_audit,
   ANY_VALUE(pack_sid) AS pack_sid,
   ANY_VALUE(pack_order_nr) AS pack_order_nr,
   ANY_VALUE(pack_tracking_nr) AS tracking_nr,
   ANY_VALUE(hauler_sid) AS hauler_sid,
   ANY_VALUE(hauler_name) AS hauler,
   ANY_VALUE(hauler_country_cd) AS hauler_country_cd,
   ANY_VALUE(pack_tracking_url) AS tracking_url,
    IF(ANY_VALUE(hauler_country_cd) = 'DE', 1, 0) <> 0 AS german_carrier_fg,
    IF(ANY_VALUE(hauler_country_cd) = 'DE', 1, 0) = 0 AS international_carrier_fg,
   ANY_VALUE(last_event) AS last_event,
   MAX(carrierlayer_event_tmsp) AS max_event_tmsp,
   MIN(carrierlayer_event_tmsp) AS min_event_tmsp,
   IF(SUM(null_huid_fg) > 0, 1, 0) AS missing_huid_fg,
   IF(SUM(data_transfer_fg) = 0, 1, 0) AS missing_data_transfer_fg,
   IF(SUM(first_hub_scan_fg) = 0, 1, 0) AS missing_first_hub_scan_fg,
   IF(SUM(hub_scan_events_fg) = 0, 1, 0) AS missing_hub_scan_events_fg,
   IF(SUM(delivery_event_fg) = 0, 1, 0) AS missing_delivery_event_fg,
   ANY_VALUE(dwh_src_file_name) AS dwh_src_file_name
  FROM CTE_ETL
  GROUP BY pk_audit), NR_LIST AS (SELECT CONCAT(pack_tracking_nr, '_', hauler_sid) AS pk_audit,
   pack_sid,
   pack_tracking_nr AS tracking_nr,
   cust_delivery_tgt_dt,
   first_attempt_delivery_tmsp
  FROM ldl_dig_lec_share.v_fact_sales_package_shipment_1
  WHERE cust_delivery_tgt_dt >= DATE(DATE_SUB(CURRENT_DATE, INTERVAL 50 DAY))
   AND LENGTH(TRIM(pack_tracking_nr)) > 0), OVERVIEW AS (SELECT t1.pk_audit AS pk,
   t1.pack_sid,
   t1.german_carrier_fg,
   t1.international_carrier_fg,
   t1.hauler_sid,
   t1.hauler,
   t1.hauler_country_cd,
   t1.tracking_nr AS pack_tracking_nr,
   t1.pack_order_nr,
   CONCAT('https://kep-parcel-status_1-api.prod.sit.sys.odj.cloud/api/tracking-ids/', t1.tracking_nr) AS api_url,
   t1.tracking_url AS pack_tracking_url,
    CASE
    WHEN DATE_DIFF(CAST(t2.first_attempt_delivery_tmsp AS DATE), t2.cust_delivery_tgt_dt, DAY) <= 0
    THEN 'pünktlich'
    WHEN DATE_DIFF(CAST(t2.first_attempt_delivery_tmsp AS DATE), t2.cust_delivery_tgt_dt, DAY) > 0
    THEN 'zu spät'
    ELSE 'Zustellung nicht bestätigt'
    END AS customer_punctuality_shipment_level,
   t2.cust_delivery_tgt_dt,
   t2.cust_delivery_tgt_dt AS quality_check_date,
   t2.first_attempt_delivery_tmsp,
   IF(t1.missing_delivery_event_fg = 1, 0, 1) AS delivery_event_was_recorded_fg,
   t1.last_event,
   t1.max_event_tmsp AS last_event_tmsp,
   t1.min_event_tmsp,
   t1.max_event_tmsp,
   IF(t1.missing_huid_fg + t1.missing_hub_scan_events_fg = 0, 0, 1) AS data_quality_issue_fg,
   t1.missing_huid_fg,
   t1.missing_data_transfer_fg,
   t1.missing_first_hub_scan_fg,
   t1.missing_hub_scan_events_fg AS missing_both_hub_scan_fg,
   t1.dwh_src_file_name
  FROM PACKAGE_LEVEL_AUDIT AS t1_1
   LEFT JOIN NR_LIST AS t2 ON t1.pk_audit = t2.pk_audit) (SELECT *
  FROM OVERVIEW);