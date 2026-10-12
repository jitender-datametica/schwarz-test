create or replace view SMP_PRODUCTION.FE_PORTAL_SMP.V_CAMPAIGN(
	CAMPAIGN_ID,
	ADVERTISER_ID,
	SOURCE_SYSTEM_ID,
	ADVERTISER_ID_SMP,
	ADVERTISER_ID_PIQ,
	CAMPAIGN_NAME,
	CAMPAIGN_START_DT,
	CAMPAIGN_END_DT,
	CHANNEL_ID,
	BUDGET_VAL,
	ATTRIBUTION_START_DT,
	ATTRIBUTION_END_DT,
	GTIN_ASSIGNED_LIST,
	CAMPAIGN_TYPE_ID,
	CAMPAIGN_STATUS_ID,
	BID_VAL,
	CAMPAIGN_ID_EXT,
	COUNTRY_ID,
	DIVISION_ID,
	SALES_QTY,
	SALES_VAL,
	BID_AVG_VAL,
	BUDGET_SPENT_VAL,
	IMPRESSION_QTY,
	VIEW_QTY,
	CLICK_QTY,
	SHOPPER_QTY,
	CONVERSION_QTY,
	NTP_PCT,
	LIFETIME_REVENUE_VAL,
	VIEW_FREQUENCY_PCT,
	CLICK_THROUGH_PCT,
	CONVERSION_PCT,
	ROAS_PCT,
	CAMPAIGN_LAST_MODIFIED,
	NEW_TO_BRAND_PCT
) as   
SELECT 
   c.CAMPAIGN_ID
  ,c.ADVERTISER_ID
  ,c.SOURCE_SYSTEM_ID
  ,COALESCE(e.ADVERTISER_ID_SMP_SPLIT, c.ADVERTISER_ID_SMP) AS ADVERTISER_ID_SMP_
  ,c.ADVERTISER_ID_PIQ
  ,c.CAMPAIGN_NAME
  ,c.CAMPAIGN_START_DT
  ,c.CAMPAIGN_END_DT
  ,COALESCE(cm.CHANNEL_ID_MAP, c.CHANNEL_ID) AS CHANNEL_ID 
  ,c.BUDGET_VAL
  ,c.ATTRIBUTION_START_DT
  ,c.ATTRIBUTION_END_DT
  ,c.GTIN_ASSIGNED_LIST
  ,c.CAMPAIGN_TYPE_ID
  ,c.CAMPAIGN_STATUS_ID 
  ,c.ADVERTISER_BID_VAL AS BID_VAL
  ,c.CAMPAIGN_ID_EXT
  ,c.COUNTRY_ID
  ,c.DIVISION_ID
  ,c.SALES_QTY
  ,c.SALES_VAL
  ,c.BID_AVG_VAL
  ,IFNULL(c.BUDGET_SPENT_VAL, 0) 
    + IFNULL(
        CASE 
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 0 
            THEN nrt.BUDGET_SPENT_VAL_1D
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 1 
            THEN nrt.BUDGET_SPENT_VAL_2D
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 2 
            THEN nrt.BUDGET_SPENT_VAL_3D
            ELSE NULL
        END 
        ,0) AS BUDGET_SPENT_VAL
  ,c.IMPRESSION_QTY
  ,IFNULL(c.VIEW_QTY, 0) 
    + IFNULL(
        CASE 
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 0 
            THEN nrt.VIEW_QTY_1D
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 1 
            THEN nrt.VIEW_QTY_2D
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 2 
            THEN nrt.VIEW_QTY_3D
            ELSE NULL
        END 
        ,0) AS VIEW_QTY
  ,IFNULL(c.CLICK_QTY, 0) 
    + IFNULL(
        CASE 
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 0 
            THEN nrt.CLICK_QTY_1D
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 1 
            THEN nrt.CLICK_QTY_2D
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 2 
            THEN nrt.CLICK_QTY_3D
            ELSE NULL
        END 
        ,0) AS CLICK_QTY
  ,c.SHOPPER_QTY
  ,c.CONVERSION_QTY 
  ,c.NTP_SHOPPER_PCT AS NTP_PCT                          
  ,c.LIFETIME_REVENUE_VAL
  ,CAST(NULLIFZERO(c.VIEW_QTY/NULLIFZERO(c.SHOPPER_QTY)) AS NUMBER(18,3)) AS VIEW_FREQUENCY_PCT
  ,CAST(
    100 
    * NULLIFZERO(
        (
        IFNULL(c.CLICK_QTY, 0) 
            + IFNULL(
                CASE 
                    WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 0 
                    THEN nrt.CLICK_QTY_1D
                    WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 1 
                    THEN nrt.CLICK_QTY_2D
                    WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 2 
                    THEN nrt.CLICK_QTY_3D
                    ELSE NULL
                END 
                ,0
                )
            )
            /
            NULLIFZERO(
            IFNULL(c.VIEW_QTY, 0) 
                + IFNULL(
                    CASE 
                        WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 0 
                        THEN nrt.VIEW_QTY_1D
                        WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 1 
                        THEN nrt.VIEW_QTY_2D
                        WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 2 
                        THEN nrt.VIEW_QTY_3D
                        ELSE NULL
                    END 
                    ,0
                    )
                )
            ) AS NUMBER(18,3)
        ) AS CLICK_THROUGH_PCT
  ,CAST(NULLIFZERO(c.CONVERSION_QTY/NULLIFZERO(c.CLICK_QTY)) AS NUMBER(18,3)) AS CONVERSION_PCT
  ,CAST(NULLIFZERO(c.SALES_VAL/NULLIFZERO(c.BUDGET_SPENT_VAL)) AS NUMBER(18,3)) AS ROAS_PCT
  ,c.CAMPAIGN_LAST_MODIFIED
  ,NTP_PCT AS NEW_TO_BRAND_PCT
FROM core.t_dim_campaign c


LEFT OUTER JOIN etl_process.t_campaign_advertiser_exception e
ON c.division_id = e.division_id
  AND c.country_id = e.country_id
  AND c.campaign_id = e.campaign_id 


LEFT OUTER JOIN etl_process.t_ref_channel_map cm
ON c.division_id = cm.division_id
  AND c.country_id = cm.country_id
  AND c.channel_id = cm.channel_id 

LEFT OUTER JOIN core.v_nrt_campaign nrt
ON c.campaign_id = nrt.campaign_id


INNER JOIN fe_portal_smp.v_campaign_portal_permission p
ON c.division_id = p.division_id
  AND c.country_id = p.country_id
  AND c.campaign_id = p.campaign_id
;
