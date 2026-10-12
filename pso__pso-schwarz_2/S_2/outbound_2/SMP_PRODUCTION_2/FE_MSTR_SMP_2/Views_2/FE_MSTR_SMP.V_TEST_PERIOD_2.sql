CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_test_period_2 (dooh_campaign_name, date_updated, date_start, date_end
, timerange, duration, date_start_pre_period, date_end_pre_period, week_start, week_end, baseline_start, baseline_end,
analysis_end, date_start_pre_conversion_period, date_end_pre_conversion_period, baseline_count_days) AS
-- nur für Kampagnen aus 2023, aus 2024 -42
 SELECT dooh_campaign_name,
 date_updated,
 date_start,
 date_end,
 CONCAT(date_start, '-', date_end) AS timerange,
  DATE_DIFF(date_end, date_start, DAY) + 1 AS duration,
 DATE_SUB(DATE_SUB(date_start, INTERVAL GREATEST(28, (DATE_DIFF(date_end, date_start, DAY) + 1) * 2) DAY), INTERVAL 1
  DAY) AS date_start_pre_period,
 DATE_SUB(date_start, INTERVAL 1 DAY) AS date_end_pre_period,
 DATE_BUCKET(date_start, INTERVAL 1 WEEK, DATE '1969-12-29') AS week_start,
 DATE_ADD(DATE_ADD(DATE_BUCKET(date_end, INTERVAL 1 WEEK, DATE '1969-12-29'), INTERVAL 1 WEEK), INTERVAL -1 DAY) AS
 week_end,
 DATE_ADD(DATE_BUCKET(date_start, INTERVAL 1 WEEK, DATE '1969-12-29'), INTERVAL -6 * 7 DAY) AS baseline_start,
 DATE_ADD(DATE_BUCKET(date_start, INTERVAL 1 WEEK, DATE '1969-12-29'), INTERVAL -2 * 7 - 1 DAY) AS baseline_end,
 DATE_ADD(DATE_ADD(DATE_ADD(DATE_BUCKET(date_end, INTERVAL 1 WEEK, DATE '1969-12-29'), INTERVAL 1 WEEK), INTERVAL -1
   DAY), INTERVAL 6 * 7 DAY) AS analysis_end,
 DATE_SUB(DATE_SUB(DATE_SUB(date_start, INTERVAL GREATEST(28, (DATE_DIFF(date_end, date_start, DAY) + 1) * 2) DAY),
   INTERVAL 1 DAY), INTERVAL 28 DAY) AS date_start_pre_conversion_period,
 DATE_SUB(DATE_SUB(date_start, INTERVAL GREATEST(28, (DATE_DIFF(date_end, date_start, DAY) + 1) * 2) DAY), INTERVAL 1
  DAY) AS date_end_pre_conversion_period,
 DATE_DIFF(DATE_SUB(DATE_SUB(date_start, INTERVAL GREATEST(28, (DATE_DIFF(date_end, date_start, DAY) + 1) * 2) DAY),
   INTERVAL 1 DAY), DATE_SUB(DATE_SUB(DATE_SUB(date_start, INTERVAL GREATEST(28, (DATE_DIFF(date_end, date_start, DAY) +
         1) * 2) DAY), INTERVAL 1 DAY), INTERVAL 28 DAY), DAY) AS baseline_count_days
FROM smp_production_fe_mstr_temp.t_test_period_2;