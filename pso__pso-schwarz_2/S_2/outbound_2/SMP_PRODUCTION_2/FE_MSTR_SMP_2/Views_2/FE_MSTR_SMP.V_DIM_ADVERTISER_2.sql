CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_advertiser_2 (advertiser_name, advertiser_id) AS SELECT
 advertiser_name,
 advertiser_id
FROM smp_production_fe_mstr_temp.t_dim_advertiser_2
WHERE advertiser_id IS NOT NULL;