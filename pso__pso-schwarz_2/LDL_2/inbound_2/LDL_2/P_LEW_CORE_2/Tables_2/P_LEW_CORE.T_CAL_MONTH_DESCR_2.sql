/* --------------------------------------------------------------------------------
   DDL for table: t_cal_month_descr_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CAL_MONTH_DESCR_2 (
   month_id                            NUMBER(38,0)     NOT NULL COMMENT 'Monatszahl: 1=Jan,2=Feb,...',
   lang_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Sprache; FK auf REPORT LANGUAGE;',
   lang_cd                             VARCHAR(20)      COMMENT 'Sprachencode;',
   month_descr                         VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'WAWI: x_data.t_cal_month_desc.month_name',
   month_descr_short                   VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'WAWI: x_data.t_cal_month_desc.month_name_short',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_CAL_MONTH_DESCR PRIMARY KEY (month_id, lang_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. MOND; Monate Bezeichnungen sprachabhaengig;
             WAWI: x_data.t_cal_month_desc_2';

