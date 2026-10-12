create or replace view SMP_PRODUCTION.INSIGHTS.V_AB_CAMPAIGN_GROUP_SETUP_2(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_GROUP_ID,
	CAMPAIGN_ID,
	CAMPAIGN_NAME,
	CAMPAIGN_GROUP_START_DT,
	CAMPAIGN_GROUP_END_DT,
	CG_ATTRIBUTION_START_DT,
	CG_ATTRIBUTION_END_DT,
	CG_PRE_END_DT,
	CG_PRE_START_DT,
	CG_NTP_END_DT,
	CG_NTP_START_DT,
	BUDGET_SPENT_VAL,
	AB_CAMPAIGN_TYPE_ID,
	TEST_GROUP_CNT,
	CONTROL_GROUP_CNT,
	TEST_STORE_CNT,
	CONTROL_STORE_CNT,
	UNIVERSE_ID,
	UNIVERSE_NAME,
	DIVISION_COUNTRY_REF,
	PG_FG,
	CAMPAIGN_ANZ,
	SUPPLIER_ID_REF,
	BID_VAL,
	BUDGET_PLANNED_VAL,
	AB_UNIVERSE_SPLIT,
	UNITS_PURCHASED_ATTRIBUTED_QTY,
	REVENUE_ATTRIBUTED_VAL,
	REVENUE_ATTRIBUTED_REGULAR_PRICE_VAL,
	PEXA_AUDIENCE_ID,
	PEXA_AUDIENCE_TYPE,
	PEXA_AUDIENCE_CATEGORY,
	PEXA_AUDIENCE_NAME,
	CAMPAIGN_TYPE,
	CAMPAIGN_DATE_START,
	CAMPAIGN_DATE_END,
	ATTRIBUTION_DATE_START,
	ATTRIBUTION_DATE_END,
	BUDGET
) as 
SELECT 
   s.division_id
  ,s.country_id
  ,s.campaign_group_id
  ,s.campaign_id
  ,s.campaign_name
  ,s.campaign_group_start_dt
  ,s.campaign_group_end_dt
  ,s.cg_attribution_start_dt
  ,s.cg_attribution_end_dt
  ,s.cg_pre_end_dt
  ,s.cg_pre_start_dt
  ,s.cg_ntp_end_dt
  ,s.cg_ntp_start_dt
  ,s.budget_spent_val
  ,s.ab_campaign_type_id
  ,s.test_group_cnt
  ,s.control_group_cnt
  ,s.test_store_cnt
  ,s.control_store_cnt
  ,s.universe_id
  ,s.universe_name
  ,s.division_country_ref
  ,s.pg_fg
  ,s.campaign_anz
  ,s.supplier_id_ref
  ,s.bid_val
  ,s.budget_planned_val
  ,s.ab_universe_split
  ,s.units_purchased_attributed_qty
  ,s.revenue_attributed_val
  ,s.revenue_attributed_regular_price_val

  -- Extension SMAR-1082
  ,CASE WHEN s.ab_campaign_type_id = 'PEXA' THEN u.universe_id_opt ELSE NULL END AS pexa_audience_id 
  ,CASE WHEN s.ab_campaign_type_id = 'PEXA' THEN u.universe_type_id ELSE NULL END AS pexa_audience_type
  ,CASE WHEN s.ab_campaign_type_id = 'PEXA' THEN u.universe_category ELSE NULL END AS pexa_audience_category
  ,CASE WHEN s.ab_campaign_type_id = 'PEXA' THEN u.universe_name ELSE NULL END AS pexa_audience_name
  
  ,s.ab_campaign_type_id AS campaign_type 
  ,s.campaign_group_start_dt AS campaign_date_start
  ,s.campaign_group_end_dt AS campaign_date_end
  ,s.cg_attribution_start_dt AS attribution_date_start
  ,s.cg_attribution_end_dt AS attribution_date_end
  ,s.budget_planned_val AS budget 
FROM insights.t_ab_campaign_group_setup_2 s 

INNER JOIN core_rel.t_campaign_2 c 
ON s.division_id = c.division_id
  AND s.country_id = c.country_id
  AND s.campaign_id = c.campaign_id
  
-- DOOH hat keine Audience   
LEFT OUTER JOIN core_rel.t_universe_2 u 
ON c.division_id = u.division_id
  AND c.country_id = u.country_id
  AND c.universe_id = u.universe_id
;
