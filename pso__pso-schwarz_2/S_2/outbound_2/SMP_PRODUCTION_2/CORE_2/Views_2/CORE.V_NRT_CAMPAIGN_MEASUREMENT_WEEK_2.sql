CREATE OR REPLACE VIEW smp_production_core.v_nrt_campaign_measurement_week_2 AS WITH EVENTS_AGGREGATED AS (SELECT CAST(ROUND(CAST(CAST(EXTRACT(ISOYEAR FROM eventtimestamp) AS STRING) || CASE
        WHEN EXTRACT(ISOWEEK FROM eventtimestamp) < 10
        THEN '0' || CAST(EXTRACT(ISOWEEK FROM eventtimestamp) AS STRING)
        ELSE CAST(EXTRACT(ISOWEEK FROM eventtimestamp) AS STRING)
        END AS FLOAT64)) AS INTEGER) AS cy_week,
   adtemplateid AS campaign_id,
   SUM(CASE
     WHEN specificity = 'VIEW' AND DATE(eventtimestamp) >= CURRENT_DATE
     THEN 1
     ELSE 0
     END) AS view_qty_1d,
   SUM(CASE
     WHEN specificity = 'VIEW' AND DATE(eventtimestamp) >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
     THEN 1
     ELSE 0
     END) AS view_qty_2d,
   SUM(CASE
     WHEN specificity = 'VIEW' AND DATE(eventtimestamp) >= DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY)
     THEN 1
     ELSE 0
     END) AS view_qty_3d,
   SUM(CASE
     WHEN specificity = 'CLICK' AND DATE(eventtimestamp) >= CURRENT_DATE
     THEN 1
     ELSE 0
     END) AS click_qty_1d,
   SUM(CASE
     WHEN specificity = 'CLICK' AND DATE(eventtimestamp) >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
     THEN 1
     ELSE 0
     END) AS click_qty_2d,
   SUM(CASE
     WHEN specificity = 'CLICK' AND DATE(eventtimestamp) >= DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY)
     THEN 1
     ELSE 0
     END) AS click_qty_3d
  FROM smp_production_core_rel.t_nrt_track_event_2 AS EA
  WHERE adtemplateid IS NOT NULL
  GROUP BY cy_week,
   campaign_id) (SELECT ea.cy_week,
   ea.campaign_id,
    CASE
    WHEN C.campaign_type_id = 'CPM'
    THEN ea.view_qty_1d / 1000 * C.advertiser_bid_val
    ELSE 0
    END AS budget_spent_val_1d,
    CASE
    WHEN C.campaign_type_id = 'CPM'
    THEN ea.view_qty_2d / 1000 * C.advertiser_bid_val
    ELSE 0
    END AS budget_spent_val_2d,
    CASE
    WHEN C.campaign_type_id = 'CPM'
    THEN ea.view_qty_3d / 1000 * C.advertiser_bid_val
    ELSE 0
    END AS budget_spent_val_3d,
   ea.view_qty_1d,
   ea.view_qty_2d,
   ea.view_qty_3d,
   ea.click_qty_1d,
   ea.click_qty_2d,
   ea.click_qty_3d,
   CAST(100 * IF(ea.click_qty_1d / IF(ea.view_qty_1d = 0, NULL, ea.view_qty_1d) = 0, NULL, ea.click_qty_1d / IF(ea.view_qty_1d = 0, NULL, ea.view_qty_1d)) AS NUMERIC)
   AS click_through_pct_1d,
   CAST(100 * IF(ea.click_qty_2d / IF(ea.view_qty_2d = 0, NULL, ea.view_qty_2d) = 0, NULL, ea.click_qty_2d / IF(ea.view_qty_2d = 0, NULL, ea.view_qty_2d)) AS NUMERIC)
   AS click_through_pct_2d,
   CAST(100 * IF(ea.click_qty_3d / IF(ea.view_qty_3d = 0, NULL, ea.view_qty_3d) = 0, NULL, ea.click_qty_3d / IF(ea.view_qty_3d = 0, NULL, ea.view_qty_3d)) AS NUMERIC)
   AS click_through_pct_3d
  FROM EVENTS_AGGREGATED AS ea
   INNER JOIN smp_production_core.t_dim_campaign_2 AS C ON ea.campaign_id = C.campaign_id);