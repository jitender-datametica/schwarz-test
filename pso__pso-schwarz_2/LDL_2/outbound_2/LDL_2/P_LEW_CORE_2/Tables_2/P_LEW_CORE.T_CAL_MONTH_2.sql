CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cal_month_2 (
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='YYYYMM; WAWI: x_data.t_cal_month.cy_month'),
busyear_qtr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier of the quarter of the busines year'),
month_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monatszahl; 1=Jan,2=Feb,...'),
cy_month_prev_1m BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WAWI: x_data.t_cal_month.prev_month'),
cy_month_prev_1y BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WAWI: x_data.t_cal_month.prev_cy_month'),
cy_month_prev_2y BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WAWI: x_data.t_cal_month.preprev_cy_month'),
cy BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr'),
busyear BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschatsjahr; WAWI: x_data.t_cal_month.busyear;'),
cy_month_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='taglich berechnet; WAWI: x_data.t_cal_month.cy_month_sequence'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cy_month) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. CMON; Monate;          WAWI: x_data.t_cal_month_2');