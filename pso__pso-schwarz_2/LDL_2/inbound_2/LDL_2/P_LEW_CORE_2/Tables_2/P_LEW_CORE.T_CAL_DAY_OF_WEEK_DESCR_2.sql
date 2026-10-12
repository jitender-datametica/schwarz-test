/* --------------------------------------------------------------------------------
   DDL for table: t_cal_day_of_week_descr_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CAL_DAY_OF_WEEK_DESCR_2 (
   day_of_week                         NUMBER(38,0)     NOT NULL COMMENT 'MO=1,DI=2,...;',
   lang_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Sprache; FK auf REPORT LANGUAGE',
   lang_cd                             VARCHAR(20)      COMMENT 'Sprach-Code',
   day_of_week_descr                   VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'Wochentagname',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_CAL_DAY_OF_WEEK_DESCR PRIMARY KEY (day_of_week, lang_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. DOWD; Wochentagsbezeichnungen, sparchabhaengig;
             WAWI: x_data.t_cal_day_of_week_desc';

