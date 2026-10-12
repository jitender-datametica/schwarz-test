create or replace view SMP_PRODUCTION.FE_MSTR_SMP.V_DOOH_CAMPAIGN_NTP_1(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_ID,
	CAMPAIGN_NAME,
	GTIN_ID,
	CNT_SHOPPER_CAMPAIGN,
	CNT_SHOPPER_PRE,
	NTP_SHOPPER_CNT,
	NTP_SHOPPER_PCT
) as
SELECT 
   division_id
  ,country_Id
  ,campaign_id
  ,campaign_name 
  ,gtin_id 
  ,COUNT(*) AS cnt_shopper_campaign
  ,SUM(pre_fg) AS cnt_shopper_pre
  ,cnt_shopper_campaign - cnt_shopper_pre AS ntp_shopper_cnt
  ,DIV0(ntp_shopper_cnt , cnt_shopper_campaign) AS ntp_shopper_pct
FROM 
(
  SELECT 
     f.division_id
    ,f.country_Id
    ,f.campaign_id
    ,f.campaign_name 
    ,f.shopper_id
    ,f.gtin_id
    ,MAX(CASE WHEN f.PERIOD IN ('0 NTP', '1 PRE') THEN 1 ELSE 0 END) AS pre_fg
    ,MAX(CASE WHEN f.PERIOD IN ('2 CAMPAIGN') THEN 1 ELSE 0 END) AS campaign_fg_
  FROM core.v_ab_test_result_week_1 f
    
  WHERE f.campaign_type_id = 'DOOH'
    AND f.PERIOD IN ('0 NTP', '1 PRE', '2 CAMPAIGN')
    AND f.campaign_fg = 1 

  GROUP BY 1,2,3,4,5,6
  
  HAVING campaign_fg_ = 1 
)a

GROUP BY 1,2,3,4,5
;
