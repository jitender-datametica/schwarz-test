CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_TIME_HR_1
AS
   SELECT
   rt.time_hour_id,
   rt.time_hour_display
   FROM p_lew_core_ac.v_wawi_ref_time_1 rt
   GROUP BY 1,2;