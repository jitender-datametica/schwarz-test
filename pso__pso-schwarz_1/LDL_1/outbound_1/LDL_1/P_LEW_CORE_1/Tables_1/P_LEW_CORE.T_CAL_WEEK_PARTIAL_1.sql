/* --------------------------------------------------------------------------------
   DDL for table: t_cal_week_partial_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cal_week_partial_1 (
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WAWI: f_data.t_cal_partial_week.cy_week'),
cy_week_part BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WAWI: f_data.t_cal_partial_week.cy_partial_week'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='YYYYMM; WAWI: f_data.t_cal_partial_week.cy_month'),
cy BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr; WAWI: f_data.t_cal_partial_week.cy'),
busyear BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschaftsjahr; WAWI: f_data.t_cal_partial_week.busyear'),
from_cal_dt DATE NOT NULL OPTIONS(description='Wochenteilbeginn; WAWI: f_data.t_cal_partial_week.dat_valid_from'),
to_cal_dt DATE NOT NULL OPTIONS(description='Wochenteilende; WAWI: f_data.t_cal_partial_week.dat_valid_until'),
cy_week_part_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='Kurzbeschreibung in Stiftungssprache; x_data.cy_partial_week_short_desc'),
partialweek_in_mth_seq_asc BIGNUMERIC(38,0) NOT NULL OPTIONS(description='partialweek_in_mth_seq_asc'),
partialweek_in_mth_seq_desc BIGNUMERIC(38,0) NOT NULL OPTIONS(description='partialweek_in_mth_seq_desc'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cy_week, cy_week_part) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. CWEP; Teil-Wochen;             WAWI: f_data.t_cal_partial_week_1');