create or replace view SMP_PRODUCTION.CORE.V_NRT_CAMPAIGN_2(
	CAMPAIGN_ID,
	BUDGET_SPENT_VAL_1D,
	BUDGET_SPENT_VAL_2D,
	BUDGET_SPENT_VAL_3D,
	VIEW_QTY_1D,
	VIEW_QTY_2D,
	VIEW_QTY_3D,
	CLICK_QTY_1D,
	CLICK_QTY_2D,
	CLICK_QTY_3D,
	CLICK_THROUGH_PCT_1D,
	CLICK_THROUGH_PCT_2D,
	CLICK_THROUGH_PCT_3D
) as

WITH events_aggregated AS (
SELECT 
    adtemplateid AS campaign_id
    
    ,COALESCE(SUM(CASE WHEN specificity = 'VIEW' AND eventtimestamp::DATE >= CURRENT_DATE THEN 1 ELSE 0 END), 0) AS view_qty_1d
    ,COALESCE(SUM(CASE WHEN specificity = 'VIEW' AND eventtimestamp::DATE >= CURRENT_DATE - 1 THEN 1 ELSE 0 END), 0) AS view_qty_2d
    ,COALESCE(SUM(CASE WHEN specificity = 'VIEW' AND eventtimestamp::DATE >= CURRENT_DATE - 2 THEN 1 ELSE 0 END), 0) AS view_qty_3d
    
    ,COALESCE(SUM(CASE WHEN specificity = 'CLICK' AND eventtimestamp::DATE >= CURRENT_DATE THEN 1 ELSE 0 END), 0) AS click_qty_1d
    ,COALESCE(SUM(CASE WHEN specificity = 'CLICK' AND eventtimestamp::DATE >= CURRENT_DATE - 1 THEN 1 ELSE 0 END), 0) AS click_qty_2d
    ,COALESCE(SUM(CASE WHEN specificity = 'CLICK' AND eventtimestamp::DATE >= CURRENT_DATE - 2 THEN 1 ELSE 0 END), 0) AS click_qty_3d
    
FROM core_rel.t_nrt_track_event_2
WHERE adtemplateid IS NOT NULL
GROUP BY 1
)

SELECT 
    ea.campaign_id
    
    ,CASE 
        WHEN c.campaign_type_id = 'CPM'
        THEN (ea.view_qty_1d/1000) * c.advertiser_bid_val
        ELSE 0
    END budget_spent_val_1d
    ,CASE 
        WHEN c.campaign_type_id = 'CPM'
        THEN (ea.view_qty_2d/1000) * c.advertiser_bid_val
        ELSE 0
    END budget_spent_val_2d
    ,CASE 
        WHEN c.campaign_type_id = 'CPM'
        THEN (ea.view_qty_3d/1000) * c.advertiser_bid_val
        ELSE 0
    END budget_spent_val_3d
    
    ,ea.view_qty_1d
    ,ea.view_qty_2d 
    ,ea.view_qty_3d 
    
    ,ea.click_qty_1d
    ,ea.click_qty_2d
    ,ea.click_qty_3d

    ,CAST(100 * NULLIFZERO(ea.click_qty_1d/NULLIFZERO(ea.view_qty_1d)) AS NUMBER(18,3)) AS click_through_pct_1d
    ,CAST(100 * NULLIFZERO(ea.click_qty_2d/NULLIFZERO(ea.view_qty_2d)) AS NUMBER(18,3)) AS click_through_pct_2d
    ,CAST(100 * NULLIFZERO(ea.click_qty_3d/NULLIFZERO(ea.view_qty_3d)) AS NUMBER(18,3)) AS click_through_pct_3d
    
FROM events_aggregated ea
    INNER JOIN core.t_dim_campaign_2 c 
    ON ea.campaign_id = c.campaign_id
;
