CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_campaign_audience_clicks AS WITH CLICKS_BY_AUDIENCE AS (SELECT
  DISTINCT TE.campaign_id,
   TE.country_id,
   TE.division_id,
   DA.descr_audience_id,
   TE.shopper_id
  FROM smp_production_core_rel.t_smp_track_event AS TE
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience AS DA ON TE.country_id = DA.country_id AND TE.division_id
         = DA.division_id AND TE.shopper_id = DA.shopper_id AND TE.specificity_id = 'CLICK' AND LEFT(DA.descr_audience_id
      , 3) NOT IN ('GEN', 'AGE', 'BUY', 'ZIP')
  WHERE TE.record_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND (CURRENT_DATE)), CNT_CLICKS_CAMPAIGN_TOTAL AS (SELECT
   country_id,
   division_id,
   campaign_id,
   COUNT(DISTINCT shopper_id) AS cnt_clicks_campaign
  FROM CLICKS_BY_AUDIENCE
  GROUP BY country_id,
   division_id,
   campaign_id) (SELECT CBA.campaign_id,
   CBA.country_id,
   CBA.division_id,
   DA0.descr_audience_id,
   t9.cnt_clicks_campaign,
   COUNT(DISTINCT CBA.shopper_id) AS cnt_click_users
  FROM CLICKS_BY_AUDIENCE AS CBA
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience AS DA0 ON CBA.country_id = DA0.country_id AND CBA.division_id
        = DA0.division_id AND CBA.shopper_id = DA0.shopper_id AND LEFT(DA0.descr_audience_id, 3) NOT IN ('GEN', 'AGE',
      'BUY', 'ZIP')
   INNER JOIN CNT_CLICKS_CAMPAIGN_TOTAL AS t9 ON CBA.country_id = t9.country_id AND CBA.division_id = t9.division_id AND
     CBA.campaign_id = t9.campaign_id
   INNER JOIN smp_production_core.t_dim_campaign AS DC ON CBA.country_id = DC.country_id AND CBA.division_id = DC.division_id
         AND CBA.campaign_id = DC.campaign_id AND COALESCE(DC.click_qty, 0) > 0 AND COALESCE(DC.sales_val, 0) > 0
  GROUP BY CBA.campaign_id,
   CBA.country_id,
   CBA.division_id,
   DA0.descr_audience_id,
   t9.cnt_clicks_campaign);