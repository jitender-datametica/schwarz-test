CREATE OR REPLACE VIEW smp_production_core.v_nrt_campaign_measurement_day_1 AS WITH EVENTS_AGGREGATED AS (SELECT DATE(eventtimestamp
    ) AS day_dt,
   adtemplateid AS campaign_id,
   SUM(CASE
     WHEN specificity = 'VIEW'
     THEN 1
     ELSE 0
     END) AS view_qty,
   SUM(CASE
     WHEN specificity = 'CLICK'
     THEN 1
     ELSE 0
     END) AS click_qty
  FROM smp_production_core_rel.t_nrt_track_event_1
  WHERE adtemplateid IS NOT NULL
  GROUP BY day_dt,
   campaign_id) (SELECT ea.day_dt,
   ea.campaign_id,
    CASE
    WHEN C.campaign_type_id = 'CPM'
    THEN ea.view_qty / 1000 * C.advertiser_bid_val
    ELSE 0
    END AS budget_spent_val,
   ea.view_qty,
   ea.click_qty,
   CAST(100 * IF(ea.click_qty / IF(ea.view_qty = 0, NULL, ea.view_qty) = 0, NULL, ea.click_qty / IF(ea.view_qty = 0, NULL, ea.view_qty)) AS NUMERIC)
   AS click_through_pct
  FROM EVENTS_AGGREGATED AS ea
   INNER JOIN smp_production_core.t_dim_campaign_1 AS C ON ea.campaign_id = C.campaign_id);