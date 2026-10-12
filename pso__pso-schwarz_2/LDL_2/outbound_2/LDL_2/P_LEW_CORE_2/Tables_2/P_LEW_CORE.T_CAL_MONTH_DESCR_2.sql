/* --------------------------------------------------------------------------------
   DDL for table: t_cal_month_descr_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cal_month_descr_2 (
month_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monatszahl: 1=Jan,2=Feb,...'),
lang_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache; FK auf REPORT LANGUAGE;'),
lang_cd STRING(20) OPTIONS(description='Sprachencode;'),
month_descr STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='WAWI: x_data.t_cal_month_desc.month_name'),
month_descr_short STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='WAWI: x_data.t_cal_month_desc.month_name_short'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (month_id, lang_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. MOND; Monate Bezeichnungen sprachabhaengig;             WAWI: x_data.t_cal_month_desc_2');