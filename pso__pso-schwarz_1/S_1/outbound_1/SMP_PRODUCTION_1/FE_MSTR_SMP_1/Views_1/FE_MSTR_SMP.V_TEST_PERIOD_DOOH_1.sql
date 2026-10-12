CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_test_period_dooh_1 (campaign_id, dooh_campaign_name, date_updated,
date_start, date_end, country_division_id, campaign_type_id, timerange, duration, date_start_pre_period,
date_end_pre_period, week_start, week_end, baseline_start, baseline_end, analysis_end, date_start_pre_conversion_period
, date_end_pre_conversion_period, baseline_count_days, gtin_list, store_list, budget_spent, delete_fg) AS
-- nur für Kampagnen aus 2023, aus 2024 -42
 SELECT CAMP.campaign_id,
 COALESCE(TP.dooh_campaign_name, CAMP.campaign_name) AS dooh_campaign_name,
 TP.date_updated,
 COALESCE(TP.date_start, CAMP.campaign_start_dt) AS date_start,
 COALESCE(TP.date_end, CAMP.campaign_end_dt) AS date_end,
 C.country_division_id,
 COALESCE(CAMP.campaign_type_id, TP.campaign_type_id) AS campaign_type_id,
 CONCAT(TP.date_start, '-', TP.date_end) AS timerange,
  DATE_DIFF(TP.date_end, TP.date_start, DAY) + 1 AS duration,
 DATE_SUB(DATE_SUB(TP.date_start, INTERVAL GREATEST(28, (DATE_DIFF(TP.date_end, TP.date_start, DAY) + 1) * 2) DAY),
  INTERVAL 1 DAY) AS date_start_pre_period,
 DATE_SUB(TP.date_start, INTERVAL 1 DAY) AS date_end_pre_period,
 DATE_BUCKET(TP.date_start, INTERVAL 1 WEEK, DATE '1969-12-29') AS week_start,
 DATE_ADD(DATE_ADD(DATE_BUCKET(TP.date_end, INTERVAL 1 WEEK, DATE '1969-12-29'), INTERVAL 1 WEEK), INTERVAL -1 DAY)
 AS week_end,
 DATE_ADD(DATE_BUCKET(TP.date_start, INTERVAL 1 WEEK, DATE '1969-12-29'), INTERVAL -6 * 7 DAY) AS baseline_start,
 DATE_ADD(DATE_BUCKET(TP.date_start, INTERVAL 1 WEEK, DATE '1969-12-29'), INTERVAL -2 * 7 - 1 DAY) AS baseline_end,
 DATE_ADD(DATE_ADD(DATE_ADD(DATE_BUCKET(TP.date_end, INTERVAL 1 WEEK, DATE '1969-12-29'), INTERVAL 1 WEEK), INTERVAL -1
   DAY), INTERVAL 6 * 7 DAY) AS analysis_end,
 DATE_SUB(DATE_SUB(DATE_SUB(TP.date_start, INTERVAL GREATEST(28, (DATE_DIFF(TP.date_end, TP.date_start, DAY) + 1) * 2)
    DAY), INTERVAL 1 DAY), INTERVAL 28 DAY) AS date_start_pre_conversion_period,
 DATE_SUB(DATE_SUB(TP.date_start, INTERVAL GREATEST(28, (DATE_DIFF(TP.date_end, TP.date_start, DAY) + 1) * 2) DAY),
  INTERVAL 1 DAY) AS date_end_pre_conversion_period,
 DATE_DIFF(DATE_SUB(DATE_SUB(TP.date_start, INTERVAL GREATEST(28, (DATE_DIFF(TP.date_end, TP.date_start, DAY) + 1) * 2)
    DAY), INTERVAL 1 DAY), DATE_SUB(DATE_SUB(DATE_SUB(TP.date_start, INTERVAL GREATEST(28, (DATE_DIFF(TP.date_end, TP
          .date_start, DAY) + 1) * 2) DAY), INTERVAL 1 DAY), INTERVAL 28 DAY), DAY) AS baseline_count_days,
 COALESCE(REPLACE(TP.gtin_list, '\\n', ','), GTIN_STORE.gtin_list) AS gtin_list,
 COALESCE(REPLACE(TP.store_list, '\\n', ','), GTIN_STORE.store_list) AS store_list,
 TP.budget_spent,
 TP.delete_fg
FROM smp_production_fe_mstr_temp.t_test_period_dooh_1 AS TP
 FULL JOIN smp_production_fe_mstr_smp.v_dim_country_smp_1 AS C ON TP.country_division_id = C.country_division_id
 LEFT JOIN smp_production_fe_mstr_smp.v_dim_campaign_1 AS CAMP ON TP.dooh_campaign_name = CAMP.campaign_name
 LEFT JOIN (SELECT GTIN.division_id,
   GTIN.country_id,
   GTIN.campaign_id,
   GTIN.gtin_list,
   STORE.store_list
  FROM (SELECT division_id,
     country_id,
     campaign_id,
     STRING_AGG(gtin_id, ',') AS gtin_list
    FROM smp_production_core_rel.t_campaign_gtin_1
    WHERE source_system_id = 'DOOH'
    GROUP BY division_id,
     country_id,
     campaign_id) AS GTIN
   INNER JOIN (SELECT division_id,
     country_id,
     campaign_id,
     STRING_AGG(store_id, ',') AS store_list
    FROM smp_production_core_rel.t_campaign_store_1
    WHERE source_system_id = 'DOOH'
    GROUP BY division_id,
     country_id,
     campaign_id) AS STORE ON GTIN.division_id = STORE.division_id AND GTIN.country_id = STORE.country_id AND GTIN.campaign_id
      = STORE.campaign_id) AS GTIN_STORE ON CAMP.division_id = GTIN_STORE.division_id AND CAMP.country_id = GTIN_STORE.country_id
     AND CAMP.campaign_id = GTIN_STORE.campaign_id;