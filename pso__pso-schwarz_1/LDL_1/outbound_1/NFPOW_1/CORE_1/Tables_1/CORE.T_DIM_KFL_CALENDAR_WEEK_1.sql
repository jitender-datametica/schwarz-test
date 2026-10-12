/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_calendar_week_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_calendar_week_1 (
cal_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the calendar_1 week            KFL: KFL_PRODUCTION.DBP_DATA.woche.KJWO            CORE_REL: t_kfl_calendar_week.cal_week'),
cal_week_begin_dt DATE
OPTIONS(description='date of the first day (Monday) of the calendar_1 week            KFL: KFL_PRODUCTION.DBP_DATA.woche.WO_DAT_VON            CORE_REL: t_kfl_calendar_week.cal_week_begin_dt'),
cal_week_end_dt DATE
OPTIONS(description='date of the last day (Sunday) of the calendar_1 week            KFL: KFL_PRODUCTION.DBP_DATA.woche.WO_DAT_BIS            CORE_REL: t_kfl_calendar_week.cal_week_end_dt'),
kfl_prev_1y_cal_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the related calendar_1 week in the previous year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.woche.KJWO_VJ            CORE_REL: t_kfl_calendar_week.kfl_prev_1y_cal_week'),
kfl_prev_2y_cal_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the related Kaufland business week in the year before last year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.woche.KJWO_VVJ            CORE_REL: t_kfl_calendar_week.kfl_prev_2y_cal_week'),
kfl_bus_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Kaufland business year week in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.woche.GJWO            CORE_REL: t_kfl_calendar_week.kfl_bus_week'),
kfl_prev_1y_bus_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the related Kaufland business week in the previous year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.woche.GJWO_VJ            CORE_REL: t_kfl_calendar_week.kfl_prev_1y_bus_week'),
kfl_cal_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar_1 week in relation to the current calendar_1 week. If the calendar_1 week is the current calendar_1 week, then the offset is 0, if the calendar_1 week is one week after the current calendar_1 week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche.AKT_WO            CORE_REL: t_kfl_calendar_week.kfl_cal_week_offset'),
kfl_completed_cal_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar_1 week in relation to the latest completed calendar_1 week. If the calendar_1 week is the latest completed calendar_1 week, then the offset is 0, if the calendar_1 week is one week after the latest completed calendar_1 week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche.AKT_WO_KOMPLETT            CORE_REL: t_kfl_calendar_week.kfl_completed_cal_week_offset'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_week) NOT ENFORCED
)
OPTIONS(description='Kaufland calendar_1 week             KFL: KFL_PRODUCTION.DBP_DATA.WOCHE_1             CORE_REL: T_KFL_CALENDAR_WEEK_1');