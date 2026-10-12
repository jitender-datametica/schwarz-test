CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_calendar_week (cal_week
OPTIONS(description='''identifier of the calendar week
LDL: P_LEW_MART_MSI_AC.v_cal_calendarday.cy_week
CORE_REL: t_ldl_calendar_week.cy_week'''),
nfpo_cal_week_name
OPTIONS(description='''Name of the calendar week
LDL: P_LEW_CORE.T_CAL_WEEK.cy_week
CORE_REL: t_ldl_calendar_week.cy_week'''),
cal_week_begin_dt
OPTIONS(description='''date of the first day (Monday) of the calendar week
LDL: P_LEW_MART_MSI_AC.v_cal_calendarday.cy_week / dat_calendar
CORE_REL: t_ldl_calendar_date.cy_week / cal_dt'''),
cal_year
OPTIONS(description='''identifier of the calendar year of the first day (Monday) of the calendar week
LDL: P_LEW_MART_MSI_AC.v_cal_calendarday.cy_week / dat_calendar
CORE_REL: t_ldl_calendar_date.cy_week / cal_dt'''),
nfpo_cal_week_offset
OPTIONS(description='''Offset of the calendar week in relation to the current calendar week. If the calendar week is the current calendar week, then the offset is 0, if the calendar week is one day after the current calendar week, then the offset is 1.
Calculated in this view from CAL_WEEK_BEGIN_DT'''),
dwh_created_tmsp OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated_tmsp
OPTIONS(description='Timestamp of the last update of the record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.')
) 
OPTIONS(description = 'Comment 2Do') AS SELECT cal_week,
 nfpo_cal_week_name,
 cal_week_begin_dt,
 cal_year,
   FLOOR(DATE_DIFF(cal_week_begin_dt, CURRENT_DATE, DAY) / 7 * 1) / 1 + 1 AS nfpo_cal_week_offset,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_src_tmsp
FROM nfpow_core.t_dim_nfpo_calendar_week;