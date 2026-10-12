CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_campaign_group_rel (campaign_group_id, campaign_group_name,
campaign_id, campaign_name, country_id, division_id) AS SELECT RC.campaign_group_id,
 RG.campaign_group_name,
 RC.campaign_id,
 RC.campaign_name,
 RC.country_id,
 RC.division_id
FROM smp_production_core_rel.t_campaign AS RC
 LEFT JOIN smp_production_core_rel.t_campaign_group AS RG ON RC.campaign_group_id = RG.campaign_group_id AND RC.country_id
     = RG.country_id AND RC.division_id = RG.division_id;