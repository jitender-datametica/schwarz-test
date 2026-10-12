CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_campaign_group (country_id, division_id, campaign_group_id,
campaign_group_name) AS SELECT DISTINCT country_id,
 division_id,
 campaign_group_id,
 campaign_group_name
FROM smp_production_core_rel.t_campaign_group;