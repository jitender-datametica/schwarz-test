CREATE OR REPLACE VIEW P_LEW_BIL.V_CAL_DAY_REL_EXTRAPOL
 AS
 /*
 #DescStart#
 #$Revision: 7084 $, $LastChangedBy: pmittler $
 #SubjectAreas#: Kalender
 #DescEnd#
 */
 (
 SELECT a.cal_dt, a.cal_dt-7 AS dat_calendar_extrapol
 FROM p_lew_core_ac.v_cal_calendarday a

 UNION ALL

 SELECT a.cal_dt, a.cal_dt-14 AS dat_calendar_extrapol
 FROM p_lew_core_ac.v_cal_calendarday a

 UNION  ALL

 SELECT a.cal_dt, a.cal_dt-21 AS dat_calendar_extrapol
 FROM p_lew_core_ac.v_cal_calendarday a

 UNION  ALL

 SELECT a.cal_dt, a.cal_dt-28 AS dat_calendar_extrapol
 FROM p_lew_core_ac.v_cal_calendarday a

 UNION  ALL

 SELECT a.cal_dt, a.cal_dt-35 AS dat_calendar_extrapol
 FROM p_lew_core_ac.v_cal_calendarday a
 )
;