/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_calendar_year_week
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_calendar_year_week (
kfl_cal_year_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the calendar year related calendar week in the Kaufland DWH, if a calendar week starts in a certain calendar year and ends in the next calendar year then the calendar week is split into 2 calendar year related Kaufland calendar weeks            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.KJWO_KL'),
kfl_cal_year_week_begin_dt DATE
OPTIONS(description='date of the first day of the calendar year related calendar week            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.KJWO_KL_DAT_VON'),
kfl_cal_year_week_end_dt DATE
OPTIONS(description='date of the last day of the calendar year related calendar week            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.KJWO_KL_DAT_BIS'),
cal_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the calendar week the calendar year related calendar week belongs to            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.KJWO'),
kfl_cal_year_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar year related calendar week in relation to the current calendar year related calendar week. If the calendar year related calendar week is the current calendar year related calendar week, then the offset is 0, if the calendar year related calendar week is one week after the current calendar year related calendar week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_KJWO_KL'),
kfl_completed_cal_year_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar year related calendar week in relation to the latest completed calendar year related calendar week. If the calendar year related calendar week is the latest completed calendar year related calendar week, then the offset is 0, if the calendar year related calendar week is one week after the latest completed calendar year related calendar week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_KJWO_KL_KOMPLETT'),
kfl_cal_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar year related calendar week in relation to the current calendar week. If the calendar year related calendar week is in the current calendar week, then the offset is 0, if the calendar year related calendar week is in the calendar week after the current calendar week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_WO'),
kfl_cal_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar year related calendar week in relation to the current calendar year. If the calendar year related calendar week is in the current calendar year, then the offset is 0, if the calendar year related calendar week is in the year after the current calendar year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_KJ'),
kfl_completed_cal_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar year related calendar week in relation to the latest completed calendar year. If the calendar year related calendar week is in the latest completed calendar year, then the offset is 0, if the calendar year related calendar week is in the year after the latest completed calendar year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche_kj_kl.AKT_KJ_KOMPLETT'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_cal_year_week) NOT ENFORCED
)
OPTIONS(description='Kaufland calendar year related calendar weeks, normal calendar weeks are splitted into two partial weeks if begin and end are in two consecutive calendar years.             KFL: KFL_PRODUCTION.DBP_DATA.WOCHE_KJ_KL');