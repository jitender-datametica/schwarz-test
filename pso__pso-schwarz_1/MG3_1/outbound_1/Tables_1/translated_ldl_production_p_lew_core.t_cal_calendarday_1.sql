

CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_cal_calendarday_1 (
cal_dt DATE NOT NULL OPTIONS(description='WAWI: x_data.t_cal_calendarday.dat_calendar'),
day_of_week INTEGER OPTIONS(description='MO=1,DI=2,...; WAWI: x_data.t_cal_calendarday.day_of_week;'),
day_of_month INTEGER OPTIONS(description='EXTRACT(DAY FROM cal_dt); WAWI: x_data.t_cal_calendarday.day_of_month;'),
day_of_cy INTEGER OPTIONS(description='WAWI: x_data.t_cal_calendarday.day_of_cy'),
cy INTEGER OPTIONS(description='Kalendarisches Jahr; WAWI: x_data.t_cal_calendarday.cy'),
cy_week INTEGER OPTIONS(description='; iso_year + iso_week, e.g. 201735; WAWI: x_data.t_cal_calendarday.cy_week'),
cy_week_99 INTEGER,
cy_week_part INTEGER
OPTIONS(description='; Gibt an, ob mind. ein Vorgangertag in der Woche_1 zum Vormonat gehort; 1=alle Vorgangertage der Woche_1 gehoren zum Monat_1 dieses Datums; 2=vice versa; WAWI: x_data.t_cal_calendarday.cy_partial_week'),
cy_month INTEGER OPTIONS(description='; year + month, e.g. 201707; WAWI: x_data.t_cal_calendarday.cy_month'),
cy_month_prev_1m INTEGER,
busyear INTEGER OPTIONS(description='Geschaftsjahr; WAWI: x_data.t_cal_calendarday.busyear'),
busyear_qtr INTEGER NOT NULL OPTIONS(description='Identifier of the quarter of the busines year'),
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
last_day_week_fg INTEGER,
last_day_week_partial_fg INTEGER,
last_day_month_fg INTEGER,
last_day_year_fg INTEGER,
cy_day_seq INTEGER
OPTIONS(description='; = dat_calendar - (CURRENT_DATE - 1) (taglich aktualisiert); WAWI: x_data.t_cal_calendarday.cy_day_sequence'),
cy_week_seq INTEGER OPTIONS(description='; (taglich aktualisiert); WAWI: x_data.t_cal_calendarday.cy_week_sequence'),
cy_month_seq INTEGER
OPTIONS(description='; = ((cy_month - (cy * 100)) - EXTRACT (MONTH FROM (CURRENT_DATE -1)  )) + (cy - EXTRACT (YEAR FROM (CURRENT_DATE -1) ))  * 12 (taglich akutalisiert); WAWI: x_data.t_cal_calendarday.cy_month_sequence'),
cy_year_seq INTEGER NOT NULL
OPTIONS(description='Calendar_1 year sequence: current calendar_1 year has sequence 0, based on yesterday: cy - year(current_date()-1) '),
busyear_seq INTEGER,
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cal_dt) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. CLDR; Kalender;\n          WAWI: x_data.t_cal_calendarday_1');

