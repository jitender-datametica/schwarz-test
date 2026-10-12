CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_CAL_CALENDARDAY_BASE_2
 (
    dat_calendar
    , prev_dat_calendar
    , pwd_dat_calendar
    , prev_cy_dat_calendar
    , preprev_cy_dat_calendar
    , day_of_week
    , day_of_month
    , day_of_cy
    , cy_week
    , cy_partial_week
    , cy_month
    , cy
    , byr
    , cy_day_sequence
    , prev_cy_dat_calendar_samewday
    , prev_cy_prev_week_samewday
    , cy_week_99
    , cy_month_sequence
    , cy_week_sequence
    , pmd_dat_calendar
    , pyd_dat_calendar
    , ppy_dat_calendar
    , first_dat_calendar_next_week
 )
 AS
  SELECT
     dat_calendar
    , prev_dat_calendar
    , pwd_dat_calendar
    , prev_cy_dat_calendar
    , preprev_cy_dat_calendar
    , day_of_week
    , day_of_month
    , day_of_cy
    , cy_week
    , cy_partial_week
    , cy_month
    , cy
    , byr
    , cy_day_sequence
    , prev_cy_dat_calendar_samewday
    , prev_cy_prev_week_samewday
    , cy_week_99
    , cy_month_sequence
    , cy_week_sequence
    , pmd_dat_calendar
    , pyd_dat_calendar
    , ppy_dat_calendar
    , first_dat_calendar_next_week
FROM p_lew_mart_lead.v_cal_calendarday_base_2;