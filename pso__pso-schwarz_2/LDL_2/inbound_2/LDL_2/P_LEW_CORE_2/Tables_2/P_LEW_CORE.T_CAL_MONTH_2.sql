create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_CAL_MONTH_2 (
	CY_MONTH NUMBER(38,0) NOT NULL COMMENT 'YYYYMM; WAWI: x_data.t_cal_month.cy_month',
	BUSYEAR_QTR NUMBER(38,0) NOT NULL COMMENT 'Identifier of the quarter of the busines year',
	MONTH_ID NUMBER(38,0) NOT NULL COMMENT 'Monatszahl; 1=Jan,2=Feb,...',
	CY_MONTH_PREV_1M NUMBER(38,0) NOT NULL COMMENT 'WAWI: x_data.t_cal_month.prev_month',
	CY_MONTH_PREV_1Y NUMBER(38,0) NOT NULL COMMENT 'WAWI: x_data.t_cal_month.prev_cy_month',
	CY_MONTH_PREV_2Y NUMBER(38,0) NOT NULL COMMENT 'WAWI: x_data.t_cal_month.preprev_cy_month',
	CY NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahr',
	BUSYEAR NUMBER(38,0) NOT NULL COMMENT 'Geschatsjahr; WAWI: x_data.t_cal_month.busyear;',
	CY_MONTH_SEQ NUMBER(38,0) NOT NULL COMMENT 'taglich berechnet; WAWI: x_data.t_cal_month.cy_month_sequence',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	constraint PK_T_CAL_MONTH primary key (CY_MONTH)
)COMMENT='$Revision: 0000 $. CMON; Monate;\n          WAWI: x_data.t_cal_month_2'
;
