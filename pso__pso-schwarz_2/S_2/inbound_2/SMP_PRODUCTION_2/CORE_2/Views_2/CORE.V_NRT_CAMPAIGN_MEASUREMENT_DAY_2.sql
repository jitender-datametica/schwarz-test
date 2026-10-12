create or replace view SMP_PRODUCTION.CORE.V_NRT_CAMPAIGN_MEASUREMENT_DAY_2(
	DAY_DT,
	CAMPAIGN_ID,
	BUDGET_SPENT_VAL,
	VIEW_QTY,
	CLICK_QTY,
	CLICK_THROUGH_PCT
) as

WITH events_aggregated AS (
SELECT 
    eventtimestamp::DATE AS day_dt
    ,adtemplateid AS campaign_id
    
    ,SUM(CASE WHEN specificity = 'VIEW' THEN 1 ELSE 0 END) AS view_qty
    ,SUM(CASE WHEN specificity = 'CLICK' THEN 1 ELSE 0 END) AS click_qty
    
FROM core_rel.t_nrt_track_event_2
WHERE adtemplateid IS NOT NULL
GROUP BY 1,2
)

SELECT 
    ea.day_dt
    ,ea.campaign_id

    ,CASE 
        WHEN c.campaign_type_id = 'CPM'
        THEN (ea.view_qty/1000) * c.advertiser_bid_val
        ELSE 0
    END budget_spent_val
    ,COALESCE(ea.view_qty, 0) AS view_qty
    ,COALESCE(ea.click_qty, 0) AS click_qty
    ,CAST(100 * NULLIFZERO(ea.click_qty/NULLIFZERO(ea.view_qty)) AS NUMBER(18,3)) AS click_through_pct
    
FROM events_aggregated ea 
    INNER JOIN core.t_dim_campaign_2 c 
    ON ea.campaign_id = c.campaign_id
;
