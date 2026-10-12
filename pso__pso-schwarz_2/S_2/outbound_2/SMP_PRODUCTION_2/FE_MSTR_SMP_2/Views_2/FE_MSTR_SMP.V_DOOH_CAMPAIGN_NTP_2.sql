CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dooh_campaign_ntp_2 (division_id, country_id, campaign_id,
campaign_name, gtin_id, cnt_shopper_campaign, cnt_shopper_pre, ntp_shopper_cnt, ntp_shopper_pct) AS SELECT division_id,
 country_id,
 campaign_id,
 campaign_name,
 gtin_id,
 COUNT(*) AS cnt_shopper_campaign,
 SUM(pre_fg) AS cnt_shopper_pre,
  COUNT(*) - SUM(pre_fg) AS ntp_shopper_cnt,
 IF(COUNT(*) = 0, 0, SAFE_DIVIDE(COUNT(*) - SUM(pre_fg), COUNT(*))) AS ntp_shopper_pct
FROM (SELECT division_id,
   country_id,
   campaign_id,
   campaign_name,
   shopper_id,
   gtin_id,
   MAX(CASE
     WHEN period IN ('0 NTP', '1 PRE')
     THEN 1
     ELSE 0
     END) AS pre_fg,
   MAX(CASE
     WHEN period IN ('2 CAMPAIGN')
     THEN 1
     ELSE 0
     END) AS campaign_fg_
  FROM smp_production_core.v_ab_test_result_week_2 AS F
  WHERE campaign_type_id = 'DOOH'
   AND period IN ('0 NTP', '1 PRE', '2 CAMPAIGN')
   AND campaign_fg = 1
  GROUP BY division_id,
   country_id,
   campaign_id,
   campaign_name,
   shopper_id,
   gtin_id
  HAVING campaign_fg_ = 1) AS t2
GROUP BY division_id,
 country_id,
 campaign_id,
 campaign_name,
 gtin_id;