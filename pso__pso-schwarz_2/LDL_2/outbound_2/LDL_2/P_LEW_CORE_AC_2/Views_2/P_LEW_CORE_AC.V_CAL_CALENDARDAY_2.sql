CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_cal_calendarday_2 (cal_dt
OPTIONS(description='WAWI: x_data.t_cal_calendarday.dat_calendar'), day_of_week
OPTIONS(description='MO=1,DI=2,...; WAWI: x_data.t_cal_calendarday.day_of_week;'), day_of_month
OPTIONS(description='EXTRACT(DAY FROM cal_dt); WAWI: x_data.t_cal_calendarday.day_of_month;'), day_of_cy
OPTIONS(description='WAWI: x_data.t_cal_calendarday.day_of_cy'), cy
OPTIONS(description='Kalendarisches Jahr; WAWI: x_data.t_cal_calendarday.cy'), cy_week
OPTIONS(description='; iso_year + iso_week, e.g. 201735; WAWI: x_data.t_cal_calendarday.cy_week'), cy_week_99,
cy_week_part
OPTIONS(description='; Gibt an, ob mind. ein Vorgangertag in der Woche_2 zum Vormonat gehort; 1=alle Vorgangertage der Woche_2 gehoren zum Monat_2 dieses Datums; 2=vice versa; WAWI: x_data.t_cal_calendarday.cy_partial_week'),
cy_month OPTIONS(description='; year + month, e.g. 201707; WAWI: x_data.t_cal_calendarday.cy_month'), cy_month_prev_1m,
busyear OPTIONS(description='Geschaftsjahr; WAWI: x_data.t_cal_calendarday.busyear'), busyear_qtr
OPTIONS(description='Identifier of the quarter of the busines year'), cal_dt_prev_1d
OPTIONS(description='; = cal_dt -1; WAWI: x_data.t_cal_calendarday.prev_dat_calendar'), cal_dt_prev_7d
OPTIONS(description='; = cal_dt - 7; WAWI: x_data.t_cal_calendarday.pwd_dat_calendar'), cal_dt_prev_1y
OPTIONS(description='; = ADD_MONTHS(cal_dt, -12); WAWI: x_data.t_cal_calendarday.prev_cy_dat_calendar'), cal_dt_prev_2y
OPTIONS(description='; = ADD_MONTHS(cal_dt, -24); WAWI: x_data.t_cal_calendarday.preprev_cy_dat_calendar'),
cal_dt_prev_3y OPTIONS(description='; = ADD_MONTHS(cal_dt, -36);'), cal_dt_prev_4y
OPTIONS(description='; = ADD_MONTHS(cal_dt, -48);'), cal_dt_prev_5y OPTIONS(description='; = ADD_MONTHS(cal_dt, -60);'),
cal_dt_prev_yd
OPTIONS(description='; selbes Tages- und Monatsdatum im Vorjahr; WAWI: x_data.t_cal_calendarday.pyd_dat_calendar'),
cal_dt_prev_md OPTIONS(description='; selbes Tagesdatum im Vormonat; WAWI: x_data.t_cal_calendarday.pmd_dat_calendar'),
cal_dt_prev_py OPTIONS(description='; ?; WAWI: x_data.t_cal_calendarday.ppy_dat_calendar'), cal_dt_swday_prev_1y
OPTIONS(description='; ?; WAWI: x_data.t_cal_calendarday.prev_cy_dat_calendar_samewday'), cal_dt_swday_prev_2y,
cal_dt_swday_prev_3y, cal_dt_swday_prev_4y, cal_dt_swday_prev_5y, cal_dt_swday_prev_1y_1w
OPTIONS(description='; ?; WAWI: x_data.t_cal_calendarday.prev_cy_prev_week_samewday'), cal_dt_last_day_prev_1w,
cal_dt_last_day_prev_1m, cal_dt_last_day_prev_1y, cal_dt_first_day_next_1w, last_day_week_fg, last_day_week_partial_fg,
last_day_month_fg, last_day_year_fg, cy_day_seq
OPTIONS(description='; = dat_calendar - (CURRENT_DATE - 1) (taglich aktualisiert); WAWI: x_data.t_cal_calendarday.cy_day_sequence'),
cy_week_seq OPTIONS(description='; (taglich aktualisiert); WAWI: x_data.t_cal_calendarday.cy_week_sequence'),
cy_month_seq
OPTIONS(description='; = ((cy_month - (cy * 100)) - EXTRACT (MONTH FROM (CURRENT_DATE -1)  )) + (cy - EXTRACT (YEAR FROM (CURRENT_DATE -1) ))  * 12 (taglich akutalisiert); WAWI: x_data.t_cal_calendarday.cy_month_sequence'),
cy_year_seq
OPTIONS(description='Calendar_2 year sequence: current calendar_2 year has sequence 0, based on yesterday: cy - year(current_date()-1) '),
busyear_seq, dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH')) AS SELECT cal_dt,
 day_of_week,
 day_of_month,
 day_of_cy,
 cy,
 cy_week,
 cy_week_99,
 cy_week_part,
 cy_month,
 cy_month_prev_1m,
 busyear,
 busyear_qtr,
 cal_dt_prev_1d,
 cal_dt_prev_7d,
 cal_dt_prev_1y,
 cal_dt_prev_2y,
 cal_dt_prev_3y,
 cal_dt_prev_4y,
 cal_dt_prev_5y,
 cal_dt_prev_yd,
 cal_dt_prev_md,
 cal_dt_prev_py,
 cal_dt_swday_prev_1y,
 cal_dt_swday_prev_2y,
 cal_dt_swday_prev_3y,
 cal_dt_swday_prev_4y,
 cal_dt_swday_prev_5y,
 cal_dt_swday_prev_1y_1w,
 cal_dt_last_day_prev_1w,
 cal_dt_last_day_prev_1m,
 cal_dt_last_day_prev_1y,
 cal_dt_first_day_next_1w,
 last_day_week_fg,
 last_day_week_partial_fg,
 last_day_month_fg,
 last_day_year_fg,
 cy_day_seq,
 cy_week_seq,
 cy_month_seq,
 cy_year_seq,
 busyear_seq,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_cal_calendarday_2;