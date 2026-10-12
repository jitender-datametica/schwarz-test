CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_advertiser (advertiser_name, advertiser_id) AS SELECT
 advertiser_name,
 advertiser_id
FROM smp_production_fe_mstr_temp.t_dim_advertiser
WHERE advertiser_id IS NOT NULL;