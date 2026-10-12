CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_CALENDAR_WEEK_2 (
   cal_week                                 COMMENT 'identifier of the calendar_2 week
LDL: P_LEW_MART_MSI_AC.v_cal_calendarday.cy_week
CORE_REL: t_ldl_calendar_week.cy_week'
  ,nfpo_cal_week_name                       COMMENT 'Name of the calendar_2 week
LDL: P_LEW_CORE.T_CAL_WEEK.cy_week
CORE_REL: t_ldl_calendar_week.cy_week'
  ,cal_week_begin_dt                        COMMENT 'date of the first day (Monday) of the calendar_2 week
LDL: P_LEW_MART_MSI_AC.v_cal_calendarday.cy_week / dat_calendar
CORE_REL: t_ldl_calendar_date.cy_week / cal_dt'
  ,cal_year                                 COMMENT 'identifier of the calendar_2 year of the first day (Monday) of the calendar_2 week
LDL: P_LEW_MART_MSI_AC.v_cal_calendarday.cy_week / dat_calendar
CORE_REL: t_ldl_calendar_date.cy_week / cal_dt'
  ,nfpo_cal_week_offset                     COMMENT 'Offset of the calendar_2 week in relation to the current calendar_2 week. If the calendar_2 week is the current calendar_2 week, then the offset is 0, if the calendar_2 week is one day after the current calendar_2 week, then the offset is 1.
Calculated in this view from CAL_WEEK_BEGIN_DT'
  ,dwh_created_tmsp                         COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last update of the record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'Comment 2Do'
AS SELECT
   CAL_WEEK
  ,NFPO_CAL_WEEK_NAME
  ,CAL_WEEK_BEGIN_DT
  ,CAL_YEAR
  ,FLOOR((CAL_WEEK_BEGIN_DT - CURRENT_DATE) / 7, 0) +1 AS NFPO_CAL_WEEK_OFFSET
  ,DWH_CREATED_TMSP
  ,DWH_UPDATED_TMSP
  ,DWH_SRC_TMSP
FROM CORE.T_DIM_NFPO_CALENDAR_WEEK_2
;

