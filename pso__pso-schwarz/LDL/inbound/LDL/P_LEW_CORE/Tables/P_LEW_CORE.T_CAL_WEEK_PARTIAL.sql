/* --------------------------------------------------------------------------------
   DDL for table: t_cal_week_partial
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CAL_WEEK_PARTIAL (
   cy_week                             NUMBER(38,0)     NOT NULL COMMENT 'WAWI: f_data.t_cal_partial_week.cy_week',
   cy_week_part                        NUMBER(38,0)     NOT NULL COMMENT 'WAWI: f_data.t_cal_partial_week.cy_partial_week',
   cy_month                            NUMBER(38,0)     NOT NULL COMMENT 'YYYYMM; WAWI: f_data.t_cal_partial_week.cy_month',
   cy                                  NUMBER(38,0)     NOT NULL COMMENT 'Kalenderjahr; WAWI: f_data.t_cal_partial_week.cy',
   busyear                             NUMBER(38,0)     NOT NULL COMMENT 'Geschaftsjahr; WAWI: f_data.t_cal_partial_week.busyear',
   from_cal_dt                         DATE             NOT NULL COMMENT 'Wochenteilbeginn; WAWI: f_data.t_cal_partial_week.dat_valid_from',
   to_cal_dt                           DATE             NOT NULL COMMENT 'Wochenteilende; WAWI: f_data.t_cal_partial_week.dat_valid_until',
   cy_week_part_descr                  VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Kurzbeschreibung in Stiftungssprache; x_data.cy_partial_week_short_desc',
   partialweek_in_mth_seq_asc          NUMBER(38,0)     NOT NULL COMMENT 'partialweek_in_mth_seq_asc',
   partialweek_in_mth_seq_desc         NUMBER(38,0)     NOT NULL COMMENT 'partialweek_in_mth_seq_desc',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_CAL_WEEK_PARTIAL PRIMARY KEY (cy_week, cy_week_part) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. CWEP; Teil-Wochen;
             WAWI: f_data.t_cal_partial_week';

