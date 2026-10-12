CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_CAL_CUM_MONTH_TO_DATE_2
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
FROM p_lew_bil_ac.v_cal_cum_month_to_date_2        AS Cal
   );