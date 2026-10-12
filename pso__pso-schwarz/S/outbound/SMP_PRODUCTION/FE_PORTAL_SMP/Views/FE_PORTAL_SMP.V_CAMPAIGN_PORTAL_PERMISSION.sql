CREATE OR REPLACE VIEW smp_production_fe_portal_smp.v_campaign_portal_permission (division_id, country_id, campaign_id)
AS SELECT division_id,
 country_id,
 campaign_id
FROM smp_production_core.t_dim_campaign AS C
WHERE CASE
   WHEN channel_id = 'lidl-newsletter-banner-001-prod'
   THEN 0
   ELSE 1
   END = 1
 AND CASE
   WHEN 'SMP_PRODUCTION' = 'SMP_PRODUCTION'
   THEN CASE
    WHEN ROUND(SAFE_CAST(COALESCE(REGEXP_REPLACE(advertiser_id_smp, '([^0-9])', ''), '') AS BIGNUMERIC), 0) IS NOT NULL
      OR ROUND(SAFE_CAST(COALESCE(advertiser_id_piq, '') AS BIGNUMERIC), 0) IS NOT NULL OR COALESCE(advertiser_id_smp,
       '') = 'schwarz-prod-user-user-internal'
    THEN 1
    ELSE 0
    END
   ELSE CASE
    WHEN TRIM(COALESCE(advertiser_id_smp, '')) = 'schwarz-prod-user-user-internal-testing' OR COALESCE(advertiser_id_smp
         , '') = 'schwarz-prod-user-user-internal' OR TRIM(COALESCE(advertiser_id_piq, '')) = '342861' OR TRIM(COALESCE(advertiser_id_smp
        , '')) = '20101316-1'
    THEN 1
    ELSE 0
    END
   END = 1
 AND campaign_type_id <> 'DOOH';