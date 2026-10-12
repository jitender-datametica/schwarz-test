CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_campaign_audience_shopper_gender_age_2 AS WITH SHOPPERS_BY_GENDER
 AS (SELECT DISTINCT FCT.campaign_id,
   FCT.country_id,
   FCT.division_id,
   FCT.shopper_id,
   DA.descr_audience_id
  FROM smp_production_core_rel.t_smp_attributed_sales_2 AS FCT
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience_2 AS DA ON FCT.country_id = DA.country_id AND FCT.division_id
        = DA.division_id AND FCT.shopper_id = DA.shopper_id AND LEFT(DA.descr_audience_id, 3) = 'GEN'
  WHERE FCT.event_tmsp BETWEEN CAST(DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AS DATETIME) AND (CAST(CURRENT_DATE AS DATETIME)
     )), CNT_CAMPAIGN AS (SELECT country_id,
   division_id,
   campaign_id,
   COUNT(DISTINCT shopper_id) AS cnt_shopper_campaign
  FROM SHOPPERS_BY_GENDER
  GROUP BY country_id,
   division_id,
   campaign_id) (SELECT SBG.campaign_id,
   SBG.country_id,
   SBG.division_id,
   SBG.descr_audience_id AS gender,
   DA0.descr_audience_id AS age,
   t9.cnt_shopper_campaign,
   COUNT(SBG.shopper_id) AS cnt_shopper
  FROM SHOPPERS_BY_GENDER AS SBG
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience_2 AS DA0 ON SBG.country_id = DA0.country_id AND SBG.division_id
        = DA0.division_id AND SBG.shopper_id = DA0.shopper_id AND LEFT(DA0.descr_audience_id, 3) = 'AGE'
   INNER JOIN CNT_CAMPAIGN AS t9 ON SBG.country_id = t9.country_id AND SBG.division_id = t9.division_id AND SBG.campaign_id
      = t9.campaign_id
   INNER JOIN smp_production_core.t_dim_campaign_2 AS DC ON SBG.country_id = DC.country_id AND SBG.division_id = DC.division_id
         AND SBG.campaign_id = DC.campaign_id AND COALESCE(DC.click_qty, 0) > 0 AND COALESCE(DC.sales_val, 0) > 0
  GROUP BY SBG.campaign_id,
   SBG.country_id,
   SBG.division_id,
   gender,
   age,
   t9.cnt_shopper_campaign);