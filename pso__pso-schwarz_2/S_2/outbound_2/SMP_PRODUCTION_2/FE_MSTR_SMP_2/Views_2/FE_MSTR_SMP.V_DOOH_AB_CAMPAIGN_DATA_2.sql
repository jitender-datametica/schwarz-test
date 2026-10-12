CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dooh_ab_campaign_data_2 (division_id, country_id, campaign_id, period
, cy_week, gtin_id, campaign_halo, control_qty, test_qty, baseline_control_qty, baseline_test_qty, control_val, test_val
, baseline_control_val, baseline_test_val) AS SELECT R.division_id,
 R.country_id,
 R.campaign_id,
 R.period,
 R.cy_week,
 R.gtin_id,
  CASE
  WHEN gg.faecher = 1 AND R.campaign_fg = 1
  THEN 'CAMPAIGN'
  WHEN gg.faecher = 2 AND R.campaign_fg = 0 AND R.art_hierarchy_level_id = 1
  THEN 'HALO 1'
  WHEN gg.faecher = 3 AND R.campaign_fg = 0 AND R.art_hierarchy_level_id IN (1, 2)
  THEN 'HALO 2'
  ELSE ''
  END AS campaign_halo,
 SUM(R.control_qty) AS control_qty,
 SUM(R.test_qty) AS test_qty,
 CAST(ROUND(IF((SUM(CASE
        WHEN R.period = '1 PRE'
        THEN 1
        ELSE 0
        END) OVER (PARTITION BY R.period, R.gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, 0, SAFE_DIVIDE(SUM(CASE
       WHEN R.period = '1 PRE'
       THEN SUM(R.control_qty)
       ELSE 0
       END) OVER (PARTITION BY R.period, R.gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), SUM(CASE
       WHEN R.period = '1 PRE'
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY R.period, R.gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)))) AS INTEGER)
 AS baseline_control_qty,
 CAST(ROUND(IF((SUM(CASE
        WHEN R.period = '1 PRE'
        THEN 1
        ELSE 0
        END) OVER (PARTITION BY R.period, R.gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, 0, SAFE_DIVIDE(SUM(CASE
       WHEN R.period = '1 PRE'
       THEN SUM(R.test_qty)
       ELSE 0
       END) OVER (PARTITION BY R.period, R.gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), SUM(CASE
       WHEN R.period = '1 PRE'
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY R.period, R.gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)))) AS INTEGER)
 AS baseline_test_qty,
 SUM(R.control_val) AS control_val,
 SUM(R.test_val) AS test_val,
 CAST(ROUND(IF((SUM(CASE
        WHEN R.period = '1 PRE'
        THEN 1
        ELSE 0
        END) OVER (PARTITION BY R.period, R.gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, 0, SAFE_DIVIDE(SUM(CASE
       WHEN R.period = '1 PRE'
       THEN SUM(R.control_val)
       ELSE 0
       END) OVER (PARTITION BY R.period, R.gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), SUM(CASE
       WHEN R.period = '1 PRE'
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY R.period, R.gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)))) AS INTEGER)
 AS baseline_control_val,
 CAST(ROUND(IF((SUM(CASE
        WHEN R.period = '1 PRE'
        THEN 1
        ELSE 0
        END) OVER (PARTITION BY R.period, R.gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, 0, SAFE_DIVIDE(SUM(CASE
       WHEN R.period = '1 PRE'
       THEN SUM(R.test_val)
       ELSE 0
       END) OVER (PARTITION BY R.period, R.gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), SUM(CASE
       WHEN R.period = '1 PRE'
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY R.period, R.gtin_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)))) AS INTEGER)
 AS baseline_test_val
FROM smp_production_core.v_ab_test_result_week_2 AS R
 INNER JOIN (SELECT 1 AS faecher
   UNION ALL
   SELECT 2 AS faecher
   UNION ALL
   SELECT 3 AS faecher) AS gg ON TRUE
WHERE R.campaign_type_id = 'DOOH'
 AND CASE
   WHEN gg.faecher = 1 AND R.campaign_fg = 1
   THEN 'CAMPAIGN'
   WHEN gg.faecher = 2 AND R.campaign_fg = 0 AND R.art_hierarchy_level_id = 1
   THEN 'HALO 1'
   WHEN gg.faecher = 3 AND R.campaign_fg = 0 AND R.art_hierarchy_level_id IN (1, 2)
   THEN 'HALO 2'
   ELSE ''
   END <> ''
GROUP BY R.division_id,
 R.country_id,
 R.campaign_id,
 R.period,
 campaign_halo,
 R.cy_week,
 R.gtin_id;