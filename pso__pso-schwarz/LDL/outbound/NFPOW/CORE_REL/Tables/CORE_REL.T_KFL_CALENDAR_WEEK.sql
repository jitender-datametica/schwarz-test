/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_calendar_week
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_calendar_week (
cal_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the calendar week            KFL: KFL_PRODUCTION.DBP_DATA.woche.KJWO'),
cal_week_begin_dt DATE
OPTIONS(description='date of the first day (Monday) of the calendar week            KFL: KFL_PRODUCTION.DBP_DATA.woche.WO_DAT_VON'),
cal_week_end_dt DATE
OPTIONS(description='date of the last day (Sunday) of the calendar week            KFL: KFL_PRODUCTION.DBP_DATA.woche.WO_DAT_BIS'),
kfl_prev_1y_cal_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the related calendar week in the previous year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.woche.KJWO_VJ'),
kfl_prev_2y_cal_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the related Kaufland business week in the year before last year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.woche.KJWO_VVJ'),
kfl_bus_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Kaufland business year week in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.woche.GJWO'),
kfl_prev_1y_bus_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the related Kaufland business week in the previous year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.woche.GJWO_VJ'),
kfl_cal_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar week in relation to the current calendar week. If the calendar week is the current calendar week, then the offset is 0, if the calendar week is one week after the current calendar week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche.AKT_WO'),
kfl_completed_cal_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar week in relation to the latest completed calendar week. If the calendar week is the latest completed calendar week, then the offset is 0, if the calendar week is one week after the latest completed calendar week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche.AKT_WO_KOMPLETT'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_week) NOT ENFORCED
) OPTIONS(description='Kaufland calendar week             KFL: KFL_PRODUCTION.DBP_DATA.WOCHE');