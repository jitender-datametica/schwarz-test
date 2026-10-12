CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_CAL_CUM_PARTIAL_WEEK_TO_DATE
(
     cal_dt
,          incl_cal_dt
,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      Cal.cal_dt           AS cal_dt,
   Cal.incl_cal_dt      AS incl_cal_dt,
   Cal.dwh_load_id      AS dwh_load_id,
   Cal.dwh_created      AS dwh_created,
   Cal.dwh_updated      AS dwh_updated
FROM p_lew_bil.t_cal_cum_partial_week_to_date        AS Cal
   );