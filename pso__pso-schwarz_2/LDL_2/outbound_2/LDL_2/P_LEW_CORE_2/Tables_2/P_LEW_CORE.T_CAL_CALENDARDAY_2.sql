CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cal_calendarday_2 (
cal_dt DATE NOT NULL OPTIONS(description='WAWI: x_data.t_cal_calendarday.dat_calendar'),
day_of_week BIGNUMERIC(38,0) OPTIONS(description='MO=1,DI=2,...; WAWI: x_data.t_cal_calendarday.day_of_week;'),
day_of_month BIGNUMERIC(38,0)
OPTIONS(description='EXTRACT(DAY FROM cal_dt); WAWI: x_data.t_cal_calendarday.day_of_month;'),
day_of_cy BIGNUMERIC(38,0) OPTIONS(description='WAWI: x_data.t_cal_calendarday.day_of_cy'),
cy BIGNUMERIC(38,0) OPTIONS(description='Kalendarisches Jahr; WAWI: x_data.t_cal_calendarday.cy'),
cy_week BIGNUMERIC(38,0)
OPTIONS(description='; iso_year + iso_week, e.g. 201735; WAWI: x_data.t_cal_calendarday.cy_week'),
cy_week_99 BIGNUMERIC(38,0),
cy_week_part BIGNUMERIC(38,0)
OPTIONS(description='; Gibt an, ob mind. ein Vorgangertag in der Woche_2 zum Vormonat gehort; 1=alle Vorgangertage der Woche_2 gehoren zum Monat_2 dieses Datums; 2=vice versa; WAWI: x_data.t_cal_calendarday.cy_partial_week'),
cy_month BIGNUMERIC(38,0) OPTIONS(description='; year + month, e.g. 201707; WAWI: x_data.t_cal_calendarday.cy_month'),
cy_month_prev_1m BIGNUMERIC(38,0),
busyear BIGNUMERIC(38,0) OPTIONS(description='Geschaftsjahr; WAWI: x_data.t_cal_calendarday.busyear'),
busyear_qtr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier of the quarter of the busines year'),
cal_dt_prev_1d DATE OPTIONS(description='; = cal_dt -1; WAWI: x_data.t_cal_calendarday.prev_dat_calendar'),
cal_dt_prev_7d DATE OPTIONS(description='; = cal_dt - 7; WAWI: x_data.t_cal_calendarday.pwd_dat_calendar'),
cal_dt_prev_1y DATE
OPTIONS(description='; = ADD_MONTHS(cal_dt, -12); WAWI: x_data.t_cal_calendarday.prev_cy_dat_calendar'),
cal_dt_prev_2y DATE
OPTIONS(description='; = ADD_MONTHS(cal_dt, -24); WAWI: x_data.t_cal_calendarday.preprev_cy_dat_calendar'),
cal_dt_prev_3y DATE OPTIONS(description='; = ADD_MONTHS(cal_dt, -36);'),
cal_dt_prev_4y DATE OPTIONS(description='; = ADD_MONTHS(cal_dt, -48);'),
cal_dt_prev_5y DATE OPTIONS(description='; = ADD_MONTHS(cal_dt, -60);'),
cal_dt_prev_yd DATE
OPTIONS(description='; selbes Tages- und Monatsdatum im Vorjahr; WAWI: x_data.t_cal_calendarday.pyd_dat_calendar'),
cal_dt_prev_md DATE
OPTIONS(description='; selbes Tagesdatum im Vormonat; WAWI: x_data.t_cal_calendarday.pmd_dat_calendar'),
cal_dt_prev_py DATE OPTIONS(description='; ?; WAWI: x_data.t_cal_calendarday.ppy_dat_calendar'),
cal_dt_swday_prev_1y DATE OPTIONS(description='; ?; WAWI: x_data.t_cal_calendarday.prev_cy_dat_calendar_samewday'),
cal_dt_swday_prev_2y DATE,
cal_dt_swday_prev_3y DATE,
cal_dt_swday_prev_4y DATE,
cal_dt_swday_prev_5y DATE,
cal_dt_swday_prev_1y_1w DATE OPTIONS(description='; ?; WAWI: x_data.t_cal_calendarday.prev_cy_prev_week_samewday'),
cal_dt_last_day_prev_1w DATE,
cal_dt_last_day_prev_1m DATE,
cal_dt_last_day_prev_1y DATE,
cal_dt_first_day_next_1w DATE,
last_day_week_fg BIGNUMERIC(38,0),
last_day_week_partial_fg BIGNUMERIC(38,0),
last_day_month_fg BIGNUMERIC(38,0),
last_day_year_fg BIGNUMERIC(38,0),
cy_day_seq BIGNUMERIC(38,0)
OPTIONS(description='; = dat_calendar - (CURRENT_DATE - 1) (taglich aktualisiert); WAWI: x_data.t_cal_calendarday.cy_day_sequence'),
cy_week_seq BIGNUMERIC(38,0)
OPTIONS(description='; (taglich aktualisiert); WAWI: x_data.t_cal_calendarday.cy_week_sequence'),
cy_month_seq BIGNUMERIC(38,0)
OPTIONS(description='; = ((cy_month - (cy * 100)) - EXTRACT (MONTH FROM (CURRENT_DATE -1)  )) + (cy - EXTRACT (YEAR FROM (CURRENT_DATE -1) ))  * 12 (taglich akutalisiert); WAWI: x_data.t_cal_calendarday.cy_month_sequence'),
cy_year_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Calendar_2 year sequence: current calendar_2 year has sequence 0, based on yesterday: cy - year(current_date()-1) '),
busyear_seq BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cal_dt) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. CLDR; Kalender;          WAWI: x_data.t_cal_calendarday_2');