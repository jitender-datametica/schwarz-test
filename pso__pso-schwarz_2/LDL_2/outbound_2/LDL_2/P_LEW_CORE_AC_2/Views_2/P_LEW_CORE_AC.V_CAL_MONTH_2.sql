CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_cal_month_2 (cy_month
OPTIONS(description='YYYYMM; WAWI: x_data.t_cal_month.cy_month'), busyear_qtr
OPTIONS(description='Identifier of the quarter of the busines year'), month_id
OPTIONS(description='Monatszahl; 1=Jan,2=Feb,...'), cy_month_prev_1m
OPTIONS(description='WAWI: x_data.t_cal_month.prev_month'), cy_month_prev_1y
OPTIONS(description='WAWI: x_data.t_cal_month.prev_cy_month'), cy_month_prev_2y
OPTIONS(description='WAWI: x_data.t_cal_month.preprev_cy_month'), cy OPTIONS(description='Kalenderjahr'), busyear
OPTIONS(description='Geschatsjahr; WAWI: x_data.t_cal_month.busyear;'), cy_month_seq
OPTIONS(description='taglich berechnet; WAWI: x_data.t_cal_month.cy_month_sequence'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH')) AS SELECT cy_month,
 busyear_qtr,
 month_id,
 cy_month_prev_1m,
 cy_month_prev_1y,
 cy_month_prev_2y,
 cy,
 busyear,
 cy_month_seq,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_cal_month_2;