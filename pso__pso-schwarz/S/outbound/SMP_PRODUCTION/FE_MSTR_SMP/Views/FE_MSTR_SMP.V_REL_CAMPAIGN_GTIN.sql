CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_rel_campaign_gtin (country_id, division_id, campaign_id, gtin_id) AS
SELECT DISTINCT country_id,
 division_id,
 campaign_id,
 gtin_id
FROM smp_production_core_rel.t_campaign_gtin
UNION DISTINCT
SELECT DISTINCT country_id,
 division_id,
 campaign_id,
 gtin_id
FROM smp_production_fe_mstr_smp.v_dooh_ab_campaign_data;