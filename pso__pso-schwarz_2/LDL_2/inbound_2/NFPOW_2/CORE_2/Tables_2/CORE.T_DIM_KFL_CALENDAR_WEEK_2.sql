/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_calendar_week_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_KFL_CALENDAR_WEEK_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   cal_week                            NUMBER(38,0)     NOT NULL COMMENT 'identifier of the calendar_2 week
            KFL: KFL_PRODUCTION.DBP_DATA.woche.KJWO
            CORE_REL: t_kfl_calendar_week.cal_week',
   cal_week_begin_dt                   DATE             COMMENT 'date of the first day (Monday) of the calendar_2 week
            KFL: KFL_PRODUCTION.DBP_DATA.woche.WO_DAT_VON
            CORE_REL: t_kfl_calendar_week.cal_week_begin_dt',
   cal_week_end_dt                     DATE             COMMENT 'date of the last day (Sunday) of the calendar_2 week
            KFL: KFL_PRODUCTION.DBP_DATA.woche.WO_DAT_BIS
            CORE_REL: t_kfl_calendar_week.cal_week_end_dt',
   kfl_prev_1y_cal_week                NUMBER(38,0)     COMMENT 'identifier of the related calendar_2 week in the previous year in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.woche.KJWO_VJ
            CORE_REL: t_kfl_calendar_week.kfl_prev_1y_cal_week',
   kfl_prev_2y_cal_week                NUMBER(38,0)     COMMENT 'identifier of the related Kaufland business week in the year before last year in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.woche.KJWO_VVJ
            CORE_REL: t_kfl_calendar_week.kfl_prev_2y_cal_week',
   kfl_bus_week                        NUMBER(38,0)     COMMENT 'identifier of the Kaufland business year week in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.woche.GJWO
            CORE_REL: t_kfl_calendar_week.kfl_bus_week',
   kfl_prev_1y_bus_week                NUMBER(38,0)     COMMENT 'identifier of the related Kaufland business week in the previous year in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.woche.GJWO_VJ
            CORE_REL: t_kfl_calendar_week.kfl_prev_1y_bus_week',
   kfl_cal_week_offset                 NUMBER(38,0)     COMMENT 'offset of the calendar_2 week in relation to the current calendar_2 week. If the calendar_2 week is the current calendar_2 week, then the offset is 0, if the calendar_2 week is one week after the current calendar_2 week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche.AKT_WO
            CORE_REL: t_kfl_calendar_week.kfl_cal_week_offset',
   kfl_completed_cal_week_offset       NUMBER(38,0)     COMMENT 'offset of the calendar_2 week in relation to the latest completed calendar_2 week. If the calendar_2 week is the latest completed calendar_2 week, then the offset is 0, if the calendar_2 week is one week after the latest completed calendar_2 week, then the offset is 1
            KFL: KFL_PRODUCTION.DBP_DATA.woche.AKT_WO_KOMPLETT
            CORE_REL: t_kfl_calendar_week.kfl_completed_cal_week_offset',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_KFL_CALENDAR_WEEK PRIMARY KEY (cal_week) NOT ENFORCED 
)  COMMENT = 'Kaufland calendar_2 week
             KFL: KFL_PRODUCTION.DBP_DATA.WOCHE_2
             CORE_REL: T_KFL_CALENDAR_WEEK_2';

