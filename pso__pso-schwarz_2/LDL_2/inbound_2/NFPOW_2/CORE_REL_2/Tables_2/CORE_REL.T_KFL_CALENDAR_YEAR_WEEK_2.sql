/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_calendar_year_week_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_CALENDAR_YEAR_WEEK_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_cal_year_week                   NUMBER(38,0)     NOT NULL COMMENT 'identifier of the calendar_2 year related calendar_2 week in the Kaufland DWH, if a calendar_2 week starts in a certain calendar_2 year and ends in the next calendar_2 year then the calendar_2 week is split into 2 calendar_2 year related Kaufland calendar_2 weeks
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.KJWO_KL',
   kfl_cal_year_week_begin_dt          DATE             COMMENT 'date of the first day of the calendar_2 year related calendar_2 week
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.KJWO_KL_DAT_VON',
   kfl_cal_year_week_end_dt            DATE             COMMENT 'date of the last day of the calendar_2 year related calendar_2 week
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.KJWO_KL_DAT_BIS',
   cal_week                            NUMBER(38,0)     COMMENT 'identifier of the calendar_2 week the calendar_2 year related calendar_2 week belongs to
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.KJWO',
   kfl_cal_year_week_offset            NUMBER(38,0)     COMMENT 'offset of the calendar_2 year related calendar_2 week in relation to the current calendar_2 year related calendar_2 week. If the calendar_2 year related calendar_2 week is the current calendar_2 year related calendar_2 week, then the offset is 0, if the calendar_2 year related calendar_2 week is one week after the current calendar_2 year related calendar_2 week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_KJWO_KL',
   kfl_completed_cal_year_week_offset  NUMBER(38,0)     COMMENT 'offset of the calendar_2 year related calendar_2 week in relation to the latest completed calendar_2 year related calendar_2 week. If the calendar_2 year related calendar_2 week is the latest completed calendar_2 year related calendar_2 week, then the offset is 0, if the calendar_2 year related calendar_2 week is one week after the latest completed calendar_2 year related calendar_2 week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_KJWO_KL_KOMPLETT',
   kfl_cal_week_offset                 NUMBER(38,0)     COMMENT 'offset of the calendar_2 year related calendar_2 week in relation to the current calendar_2 week. If the calendar_2 year related calendar_2 week is in the current calendar_2 week, then the offset is 0, if the calendar_2 year related calendar_2 week is in the calendar_2 week after the current calendar_2 week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_WO',
   kfl_cal_year_offset                 NUMBER(38,0)     COMMENT 'offset of the calendar_2 year related calendar_2 week in relation to the current calendar_2 year. If the calendar_2 year related calendar_2 week is in the current calendar_2 year, then the offset is 0, if the calendar_2 year related calendar_2 week is in the year after the current calendar_2 year, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_KJ',
   kfl_completed_cal_year_offset       NUMBER(38,0)     COMMENT 'offset of the calendar_2 year related calendar_2 week in relation to the latest completed calendar_2 year. If the calendar_2 year related calendar_2 week is in the latest completed calendar_2 year, then the offset is 0, if the calendar_2 year related calendar_2 week is in the year after the latest completed calendar_2 year, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_KJ_KOMPLETT',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_CALENDAR_YEAR_WEEK PRIMARY KEY (kfl_cal_year_week) NOT ENFORCED 
)  COMMENT = 'Kaufland calendar_2 year related calendar_2 weeks, normal calendar_2 weeks are splitted into two partial weeks if begin and end are in two consecutive calendar_2 years.
             KFL: KFL_PRODUCTION.DBP_DATA.WOCHE_KJ_KL_2';

