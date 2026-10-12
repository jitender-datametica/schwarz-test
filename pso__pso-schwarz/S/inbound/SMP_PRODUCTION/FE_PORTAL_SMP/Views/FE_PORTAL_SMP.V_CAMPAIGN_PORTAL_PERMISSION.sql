create or replace view SMP_PRODUCTION.FE_PORTAL_SMP.V_CAMPAIGN_PORTAL_PERMISSION(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_ID
) as 
SELECT 
   c.division_id
  ,c.country_id
  ,c.campaign_id
FROM core.t_dim_campaign c

WHERE CASE WHEN c.channel_id = 'lidl-newsletter-banner-001-prod' THEN 0 ELSE 1 END = 1 
  AND 
  
  CASE WHEN 'SMP_PRODUCTION' = CURRENT_DATABASE()
       THEN CASE WHEN 
                      (
                        TRY_TO_NUMERIC(COALESCE(REGEXP_REPLACE(c.advertiser_id_smp, '([^0-9])', ''), '')) IS NOT NULL
                        OR TRY_TO_NUMERIC(COALESCE(c.advertiser_id_piq, '')) IS NOT NULL
                        OR COALESCE(c.advertiser_id_smp, '') = 'schwarz-prod-user-user-internal'
                      )
                 THEN 1
                 ELSE 0
            END
       ELSE CASE WHEN 
                      (
                        TRIM(COALESCE(c.advertiser_id_smp, '')) = 'schwarz-prod-user-user-internal-testing'
                        OR COALESCE(c.advertiser_id_smp, '') = 'schwarz-prod-user-user-internal'
                        OR TRIM(COALESCE(c.advertiser_id_piq, '')) = '342861'
                        OR TRIM(COALESCE(c.advertiser_id_smp, '')) = '20101316-1'
                      )
                 THEN 1
                 ELSE 0 
            END
  END = 1
  AND c.campaign_type_id <> 'DOOH'  
;
