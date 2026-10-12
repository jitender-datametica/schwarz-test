CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_CAL_CUM_YEAR_TO_MONTH
(
     cy_month
,          incl_cy_month
,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      Cal.cy_month         AS cy_month,
   Cal.incl_cy_month    AS incl_cy_month,
   Cal.dwh_load_id      AS dwh_load_id,
   Cal.dwh_created      AS dwh_created,
   Cal.dwh_updated      AS dwh_updated
FROM p_lew_bil.t_cal_cum_year_to_month        AS Cal
   );