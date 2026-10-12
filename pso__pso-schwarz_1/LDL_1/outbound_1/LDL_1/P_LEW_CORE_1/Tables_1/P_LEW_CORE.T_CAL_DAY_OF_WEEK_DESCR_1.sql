/* --------------------------------------------------------------------------------
   DDL for table: t_cal_day_of_week_descr_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cal_day_of_week_descr_1 (
day_of_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='MO=1,DI=2,...;'),
lang_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache; FK auf REPORT LANGUAGE'),
lang_cd STRING(20) OPTIONS(description='Sprach-Code'),
day_of_week_descr STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='Wochentagname'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (day_of_week, lang_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. DOWD; Wochentagsbezeichnungen, sparchabhaengig;             WAWI: x_data.t_cal_day_of_week_desc');