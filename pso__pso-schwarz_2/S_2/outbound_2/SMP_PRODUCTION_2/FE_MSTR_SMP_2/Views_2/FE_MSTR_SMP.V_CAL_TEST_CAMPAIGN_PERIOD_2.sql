CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_cal_test_campaign_period_2 (campaign_id, country_id, division_id,
day_dt, cal_dt_trans, campaign_start_dt, campaign_end_dt) AS SELECT DISTINCT CAM.campaign_id,
 CAM.country_id,
 CAM.division_id,
 CAL.cal_dt AS day_dt,
  CASE
  WHEN CAM.duration_in_days = 7
  THEN DATE_SUB(CAM.campaign_start_dt, INTERVAL 28 DAY)
  WHEN CAM.duration_in_days > 14
  THEN DATE_ADD(CAM.campaign_start_dt, INTERVAL -1 * (CAM.duration_in_days * 2) DAY)
  ELSE DATE_SUB(CAM.campaign_start_dt, INTERVAL 28 DAY)
  END AS cal_dt_trans,
 CAM.campaign_start_dt,
 CAM.campaign_end_dt
FROM smp_production_fe_mstr_smp.v_dim_calendarday_2 AS CAL
 INNER JOIN smp_production_fe_mstr_smp.v_dim_campaign_2 AS CAM ON CAL.cal_dt = CAM.campaign_start_dt;