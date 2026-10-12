CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_ab_campaign_unique_shopper (division_id, country_id, campaign_id,
campaign_name, campaign_type_id, period, cy_week, unique_shopper_cnt, unique_shopper_test_cnt,
unique_shopper_control_cnt) AS SELECT division_id,
 country_id,
 campaign_id,
 campaign_name,
 campaign_type_id,
 period,
 cy_week,
 COUNT(DISTINCT shopper_id) AS unique_shopper_cnt,
 COUNT(DISTINCT CASE
   WHEN cell_group_id = 'TEST'
   THEN shopper_id
   ELSE NULL
   END) AS unique_shopper_test_cnt,
 COUNT(DISTINCT CASE
   WHEN cell_group_id = 'CONTROL'
   THEN shopper_id
   ELSE NULL
   END) AS unique_shopper_control_cnt
FROM smp_production_core.t_ab_test_result_day AS F
WHERE campaign_type_id <> 'DOOH' -- bei DooH sind auch unbekannte Shopper enthalten.

 AND campaign_fg = 1 -- nur kampagnenartikel

GROUP BY division_id,
 country_id,
 campaign_id,
 campaign_name,
 campaign_type_id,
 period,
 cy_week;