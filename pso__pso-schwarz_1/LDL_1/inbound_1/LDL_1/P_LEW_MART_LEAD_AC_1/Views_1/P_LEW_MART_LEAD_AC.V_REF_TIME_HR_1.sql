CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_TIME_HR_1
AS
   SELECT
   rt.time_hour_id,
   rt.time_hour_display
   FROM p_lew_mart_lead.v_ref_time_hr_1 rt
   GROUP BY 1,2;