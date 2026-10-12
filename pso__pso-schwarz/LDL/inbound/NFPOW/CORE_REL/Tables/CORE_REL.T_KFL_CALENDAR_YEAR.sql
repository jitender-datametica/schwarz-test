/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_calendar_year
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_CALENDAR_YEAR DATA_RETENTION_TIME_IN_DAYS = 2 (
   cal_year                            NUMBER(38,0)     NOT NULL COMMENT 'identifier of the calendar year
            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_KJ.KJ',
   kfl_cal_year_offset                 NUMBER(38,0)     COMMENT 'offset of the calendar year in relation to the current calendar year. If the calendar year is the current calendar year, then the offset is 0, if the calendar year is one year after the current calendar year, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_KJ.AKT_KJ',
   kfl_completed_cal_year_offset       NUMBER(38,0)     COMMENT 'offset of the calendar year in relation to the latest completed calendar year. If the calendar year is the latest completed calendar year, then the offset is 0, if the calendar year is one year after the latest completed calendar year, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_KJ.AKT_KJ_KOMPLETT',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_CALENDAR_YEAR PRIMARY KEY (cal_year) NOT ENFORCED 
)  COMMENT = 'Kaufland calender year
             KFL: KFL_PRODUCTION.DBP_DATA.JAHR_KJ';

