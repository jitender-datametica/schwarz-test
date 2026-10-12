CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_CAL_CUM_BUSINESS_YEAR_TO_PARTIAL_WEEK
(
     cy_week_part
,          incl_cy_week_part
,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      Cal.cy_week_part         AS cy_week_part,
   Cal.incl_cy_week_part    AS incl_cy_week_part,
   Cal.dwh_load_id          AS dwh_load_id,
   Cal.dwh_created          AS dwh_created,
   Cal.dwh_updated          AS dwh_updated
FROM p_lew_bil.t_cal_cum_business_year_to_partial_week         AS Cal
   );