CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_universe_cnt_shopper_2 (country_id, division_id, campaign_id,
universe_id, cnt_shopper_id) AS SELECT TD.country_id,
 TD.division_id,
 TD.campaign_id,
 TD.universe_id,
 COUNT(DISTINCT TU.shopper_id) AS cnt_shopper_id
FROM smp_production_core_rel.t_campaign_2 AS TD
 INNER JOIN smp_production_core_rel.t_universe_shopper_2 AS TU ON TD.universe_id = TU.universe_id AND TD.country_id = TU.country_id
     AND TD.division_id = TU.division_id
WHERE TU.universe_id <> ''
GROUP BY TD.country_id,
 TD.division_id,
 TD.campaign_id,
 TD.universe_id;