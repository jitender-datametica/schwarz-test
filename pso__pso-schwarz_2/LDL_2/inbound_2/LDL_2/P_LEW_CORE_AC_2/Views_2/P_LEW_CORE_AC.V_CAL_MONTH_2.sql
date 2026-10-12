create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_CAL_MONTH_2(
	CY_MONTH COMMENT 'YYYYMM; WAWI: x_data.t_cal_month.cy_month',
	BUSYEAR_QTR COMMENT 'Identifier of the quarter of the busines year',
	MONTH_ID COMMENT 'Monatszahl; 1=Jan,2=Feb,...',
	CY_MONTH_PREV_1M COMMENT 'WAWI: x_data.t_cal_month.prev_month',
	CY_MONTH_PREV_1Y COMMENT 'WAWI: x_data.t_cal_month.prev_cy_month',
	CY_MONTH_PREV_2Y COMMENT 'WAWI: x_data.t_cal_month.preprev_cy_month',
	CY COMMENT 'Kalenderjahr',
	BUSYEAR COMMENT 'Geschatsjahr; WAWI: x_data.t_cal_month.busyear;',
	CY_MONTH_SEQ COMMENT 'taglich berechnet; WAWI: x_data.t_cal_month.cy_month_sequence',
	DWH_LOAD_ID COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
) as SELECT 
 CY_MONTH,
 BUSYEAR_QTR,
 MONTH_ID,
 CY_MONTH_PREV_1M,
 CY_MONTH_PREV_1Y,
 CY_MONTH_PREV_2Y,
 CY,
 BUSYEAR,
 CY_MONTH_SEQ,
 DWH_LOAD_ID,
 DWH_CREATED,
 DWH_UPDATED
FROM P_LEW_CORE.T_CAL_MONTH_2;
