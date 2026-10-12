/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_calendar_year_week
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_CALENDAR_YEAR_WEEK DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_cal_year_week                   NUMBER(38,0)     NOT NULL COMMENT 'identifier of the calendar year related calendar week in the Kaufland DWH, if a calendar week starts in a certain calendar year and ends in the next calendar year then the calendar week is split into 2 calendar year related Kaufland calendar weeks
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.KJWO_KL',
   kfl_cal_year_week_begin_dt          DATE             COMMENT 'date of the first day of the calendar year related calendar week
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.KJWO_KL_DAT_VON',
   kfl_cal_year_week_end_dt            DATE             COMMENT 'date of the last day of the calendar year related calendar week
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.KJWO_KL_DAT_BIS',
   cal_week                            NUMBER(38,0)     COMMENT 'identifier of the calendar week the calendar year related calendar week belongs to
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.KJWO',
   kfl_cal_year_week_offset            NUMBER(38,0)     COMMENT 'offset of the calendar year related calendar week in relation to the current calendar year related calendar week. If the calendar year related calendar week is the current calendar year related calendar week, then the offset is 0, if the calendar year related calendar week is one week after the current calendar year related calendar week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_KJWO_KL',
   kfl_completed_cal_year_week_offset  NUMBER(38,0)     COMMENT 'offset of the calendar year related calendar week in relation to the latest completed calendar year related calendar week. If the calendar year related calendar week is the latest completed calendar year related calendar week, then the offset is 0, if the calendar year related calendar week is one week after the latest completed calendar year related calendar week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_KJWO_KL_KOMPLETT',
   kfl_cal_week_offset                 NUMBER(38,0)     COMMENT 'offset of the calendar year related calendar week in relation to the current calendar week. If the calendar year related calendar week is in the current calendar week, then the offset is 0, if the calendar year related calendar week is in the calendar week after the current calendar week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_WO',
   kfl_cal_year_offset                 NUMBER(38,0)     COMMENT 'offset of the calendar year related calendar week in relation to the current calendar year. If the calendar year related calendar week is in the current calendar year, then the offset is 0, if the calendar year related calendar week is in the year after the current calendar year, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_KJ',
   kfl_completed_cal_year_offset       NUMBER(38,0)     COMMENT 'offset of the calendar year related calendar week in relation to the latest completed calendar year. If the calendar year related calendar week is in the latest completed calendar year, then the offset is 0, if the calendar year related calendar week is in the year after the latest completed calendar year, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_KJ_KOMPLETT',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_CALENDAR_YEAR_WEEK PRIMARY KEY (kfl_cal_year_week) NOT ENFORCED 
)  COMMENT = 'Kaufland calendar year related calendar weeks, normal calendar weeks are splitted into two partial weeks if begin and end are in two consecutive calendar years.
             KFL: KFL_PRODUCTION.DBP_DATA.WOCHE_KJ_KL';

